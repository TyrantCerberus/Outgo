SUBSYSTEM_DEF(blackmarket)
	name  = "Blackmarket"
	flags  = SS_BACKGROUND
	init_order  = INIT_ORDER_DEFAULT

	/// Descriptions for each shipping methods.
	var/shipping_method_descriptions = list(
		SHIPPING_METHOD_LTSRBT="Long-To-Short-Range-Bluespace-Transceiver, a machine that receives items outside the station and then teleports them to the location of the uplink.",
		SHIPPING_METHOD_LAUNCH="Launches the item at the station from space, cheap but you might not receive your item at all.",
		SHIPPING_METHOD_CARGO="Sends the item to the station on the next cargo shuttle, discretely disguised as a standard personal purchase. An additional 25cr fee will be charged upon arrival."
	)

	/// List of all existing markets.
	var/list/datum/blackmarket_market/markets = list()
	/// List of existing ltsrbts.
	var/list/obj/machinery/ltsrbt/telepads = list()
	/// Currently queued purchases.
	var/list/queued_purchases = list()

/datum/controller/subsystem/blackmarket/Initialize(timeofday)
	for(var/market in subtypesof(/datum/blackmarket_market))
		markets[market] += new market

	for(var/item in subtypesof(/datum/blackmarket_item))
		var/datum/blackmarket_item/I = new item()
		if(!I.item)
			continue

		for(var/M in I.markets)
			if(!markets[M])
				stack_trace("SSblackmarket: Item [I] available in market that does not exist.")
				continue
			markets[M].add_item(item)
		qdel(I)
	. = ..()


/datum/controller/subsystem/blackmarket/fire(resumed)
	while(length(queued_purchases))
		var/datum/blackmarket_purchase/purchase = queued_purchases[1]
		queued_purchases.Cut(1,2)

		// Uh oh, uplink is gone. We will just keep the money and you will not get your order.
		if(!purchase.uplink || QDELETED(purchase.uplink))
			queued_purchases -= purchase
			qdel(purchase)
			continue

		switch(purchase.method)
			// Find a ltsrbt pad and make it handle the shipping.
			if(SHIPPING_METHOD_LTSRBT)
				if(!telepads.len)
					continue
				// Prioritize pads that don't have a cooldown active.
				var/free_pad_found = FALSE
				for(var/obj/machinery/ltsrbt/pad in telepads)
					if(pad.recharge_cooldown)
						continue
					pad.add_to_queue(purchase)
					queued_purchases -= purchase
					free_pad_found = TRUE
					break

				if(free_pad_found)
					continue

				var/obj/machinery/ltsrbt/pad = pick(telepads)

				to_chat(recursive_loc_check(purchase.uplink.loc, /mob), span_notice("[purchase.uplink] flashes a message noting that the order is being processed by [pad]."))

				queued_purchases -= purchase
				pad.add_to_queue(purchase)
			if(SHIPPING_METHOD_LAUNCH)
				var/startSide = pick(GLOB.cardinals)
				var/turf/T = get_turf(purchase.uplink)
				var/pickedloc = spaceDebrisStartLoc(startSide, T.z)

				var/atom/movable/item = purchase.entry.spawn_item(pickedloc)
				item.throw_at(purchase.uplink, 3, 3, spin = FALSE)

				to_chat(recursive_loc_check(purchase.uplink.loc, /mob), span_notice("[purchase.uplink] flashes a message noting the order is being launched at the station from [dir2text(startSide)]."))

				queued_purchases -= purchase
				qdel(purchase)
			if(SHIPPING_METHOD_CARGO)
				var/datum/supply_pack/goody/blackmarket/our_order = new /datum/supply_pack/goody/blackmarket
				our_order.contains = list(purchase.entry.get_item_path())
				var/datum/supply_order/SO = new(our_order, purchase.buyer, purchase.buyer.GetJob(), purchase.buyer.ckey, "None required.", purchase.buyer.get_bank_account())
				SSshuttle.shoppinglist += SO

				to_chat(recursive_loc_check(purchase.uplink.loc, /mob), span_notice("[purchase.uplink] flashes a message noting that the order will be dispatched aboard the next inbound cargo shuttle, additional 25cr charge pending."))

				queued_purchases -= purchase
				qdel(purchase)
		if(MC_TICK_CHECK)
			break

/// Used to make a teleportation effect as do_teleport does not like moving items from nullspace.
/datum/controller/subsystem/blackmarket/proc/fake_teleport(atom/movable/item, turf/target)
	item.forceMove(target)
	var/datum/effect_system/spark_spread/sparks = new
	sparks.set_up(5, 1, target)
	sparks.attach(item)
	sparks.start()

/// Used to add /datum/blackmarket_purchase to queued_purchases var. Returns TRUE when queued.
/datum/controller/subsystem/blackmarket/proc/queue_item(datum/blackmarket_purchase/P)
	if(P.method == SHIPPING_METHOD_LTSRBT && !telepads.len)
		return FALSE
	queued_purchases += P
	return TRUE

/// Used to repopulate the market when the auction rotation happens.
/datum/controller/subsystem/blackmarket/proc/repopulate_market(market)
	markets[market].available_items.Cut()
	markets[market].categories.Cut()

	for(var/item in subtypesof(/datum/blackmarket_item))
		var/datum/blackmarket_item/rotated_item = new item()

		if(rotated_item.root == rotated_item.type)
			qdel(rotated_item)
			continue

		if(!rotated_item.item)
			stack_trace("Blackmarket repopulation failure! [rotated_item] didn't contain a path to an item!")
			qdel(rotated_item)
			continue

		if(market in rotated_item.markets)
			markets[market].add_item(item)

		qdel(rotated_item)
