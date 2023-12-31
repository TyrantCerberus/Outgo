//Note: Everything in modules/clothing/spacesuits should have the entire suit grouped together.
//      Meaning the the suit is defined directly after the corrisponding helmet. Just like below!
/obj/item/clothing/head/helmet/space
	name = "space helmet"
	icon_state = "spaceold"
	desc = "A special helmet with solar UV shielding to protect your eyes from harmful rays."
	clothing_flags = STOPSPRESSUREDAMAGE | THICKMATERIAL | SNUG_FIT
	inhand_icon_state = "spaceold"
	permeability_coefficient = 0.01
	armor = list(MELEE = 0, BULLET = 0, LASER = 0,ENERGY = 0, BOMB = 0, BIO = 100, RAD = 50, FIRE = 80, ACID = 70)
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR|HIDESNOUT
	dynamic_hair_suffix = ""
	dynamic_fhair_suffix = ""
	cold_protection = HEAD
	min_cold_protection_temperature = SPACE_HELM_MIN_TEMP_PROTECT
	heat_protection = HEAD
	max_heat_protection_temperature = SPACE_HELM_MAX_TEMP_PROTECT
	flash_protect = FLASH_PROTECTION_WELDER
	strip_delay = 50
	equip_delay_other = 50
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH | PEPPERPROOF
	resistance_flags = NONE
	dog_fashion = null

/obj/item/clothing/suit/space
	name = "space suit"
	desc = "A suit that protects against low pressure environments. Has a big 13 on the back."
	icon_state = "spaceold"
	inhand_icon_state = "s_suit"
	w_class = WEIGHT_CLASS_BULKY
	gas_transfer_coefficient = 0.01
	permeability_coefficient = 0.02
	clothing_flags = STOPSPRESSUREDAMAGE | THICKMATERIAL
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	allowed = list(/obj/item/flashlight, /obj/item/tank/internals)
	slowdown = 1
	armor = list(MELEE = 0, BULLET = 0, LASER = 0,ENERGY = 0, BOMB = 0, BIO = 100, RAD = 50, FIRE = 80, ACID = 70)
	flags_inv = HIDEGLOVES|HIDESHOES|HIDEJUMPSUIT
	cold_protection = CHEST | GROIN | LEGS | FEET | ARMS | HANDS
	min_cold_protection_temperature = SPACE_SUIT_MIN_TEMP_PROTECT
	heat_protection = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	max_heat_protection_temperature = SPACE_SUIT_MAX_TEMP_PROTECT
	strip_delay = 80
	equip_delay_other = 80
	resistance_flags = NONE

//////// Softsuits ////////

/obj/item/clothing/head/helmet/space/soft
	name = "\improper EVA softsuit helmet"
	desc = "A fitted helmet providing temporary protection from the vaccuum of space, this one is intended to accompany a suit of the same make. \
			It is rated as having a maximum exposure time of 5 minutes, after which it will need to 'recharge' in a pressurised environment. \
			A quirk of its design means it must be worn in order to recharge."
	icon_state = "softsuit_helm"
	inhand_icon_state = "s_suit"
	armor = list(MELEE = 0, BULLET = 0, LASER = 0,ENERGY = 0, BOMB = 0, BIO = 100, RAD = 30, FIRE = 0, ACID = 0)
	var/suit_integrity = 300 //at a loss rate of 1 per second exposed, this amounts to 5 minutes maximum exposure duration
	var/integrity_has_failed = FALSE //has this suit lost its protections?
	var/regeneration_timer

/obj/item/clothing/head/helmet/space/soft/Initialize()
	. = ..()
	RegisterSignal(src, COMSIG_ITEM_EQUIPPED, PROC_REF(on_equip))
	RegisterSignal(src, COMSIG_ITEM_POST_UNEQUIP, PROC_REF(on_unequip))

/obj/item/clothing/head/helmet/space/soft/proc/on_equip()
	SIGNAL_HANDLER
	START_PROCESSING(SSprocessing, src)

/obj/item/clothing/head/helmet/space/soft/proc/on_unequip()
	SIGNAL_HANDLER
	STOP_PROCESSING(SSprocessing, src)
	if(regeneration_timer)
		deltimer(regeneration_timer)

/obj/item/clothing/head/helmet/space/soft/process()
	var/turf/open/T = get_turf(src)
	var/pressure = T.air.return_pressure()
	if(pressure < WARNING_LOW_PRESSURE)
		if(suit_integrity > 0)
			suit_integrity--
			if(suit_integrity == 60) //1 minute of protection left
				src.audible_message(span_warning("The [src] squeaks unnervingly."))
			if(suit_integrity <= 0 && !(integrity_has_failed))
				src.audible_message(span_boldwarning("The [src] creaks and hisses, its protections have failed!"))
				clothing_flags = THICKMATERIAL | SNUG_FIT
				cold_protection = null
				integrity_has_failed = TRUE
		if(regeneration_timer)
			deltimer(regeneration_timer)
	else if(pressure >= 101 && !(regeneration_timer)) //pressure requirement set slightly lower than ONE_ATMOSPHERE
		regeneration_timer = addtimer(CALLBACK(src, PROC_REF(on_timer_expire)), 60 SECONDS, TIMER_STOPPABLE)
		src.audible_message(span_notice("The [src] sounds as if it's inhaling as it begins to recharge."))

/obj/item/clothing/head/helmet/space/soft/proc/on_timer_expire()
	clothing_flags = STOPSPRESSUREDAMAGE | THICKMATERIAL | SNUG_FIT
	cold_protection = HEAD
	suit_integrity = 300
	integrity_has_failed = FALSE
	src.audible_message(span_notice("The [src] warbles like rubber. It seems to have recharged."))

/obj/item/clothing/suit/space/soft
	name = "\improper EVA softsuit"
	desc = "A tight, flexible suit that uses microcell technology to provide temporary protection from exposure to the vaccuum of space. \
			This one is rated as having a maximum exposure time of 5 minutes, after which it will need to 'recharge' in a pressurised environment. \
			A quirk of its design means it must be worn in order to recharge."
	icon_state = "softsuit"
	inhand_icon_state = "s_suit"
	armor = list(MELEE = 0, BULLET = 0, LASER = 0,ENERGY = 0, BOMB = 0, BIO = 100, RAD = 30, FIRE = 0, ACID = 0)
	var/suit_integrity = 300
	var/integrity_has_failed = FALSE
	var/regeneration_timer

/obj/item/clothing/suit/space/soft/Initialize()
	. = ..()
	RegisterSignal(src, COMSIG_ITEM_EQUIPPED, PROC_REF(on_equip))
	RegisterSignal(src, COMSIG_ITEM_POST_UNEQUIP, PROC_REF(on_unequip))

/obj/item/clothing/suit/space/soft/proc/on_equip()
	SIGNAL_HANDLER
	START_PROCESSING(SSprocessing, src)

/obj/item/clothing/suit/space/soft/proc/on_unequip()
	SIGNAL_HANDLER
	STOP_PROCESSING(SSprocessing, src)
	if(regeneration_timer)
		deltimer(regeneration_timer)

/obj/item/clothing/suit/space/soft/process()
	var/turf/open/T = get_turf(src)
	var/pressure = T.air.return_pressure()
	if(pressure < WARNING_LOW_PRESSURE)
		if(suit_integrity > 0)
			suit_integrity--
			if(suit_integrity == 60)
				src.visible_message(span_warning("The [src] has begun to visibly deflate."))
			if(suit_integrity <= 0 && !(integrity_has_failed))
				src.audible_message(span_boldwarning("The [src] creaks and hisses, its protections have failed!"))
				clothing_flags = THICKMATERIAL
				cold_protection = null
				integrity_has_failed = TRUE
		if(regeneration_timer)
			deltimer(regeneration_timer)
	else if(pressure >= 101 && !(regeneration_timer))
		regeneration_timer = addtimer(CALLBACK(src, PROC_REF(on_timer_expire)), 60 SECONDS, TIMER_STOPPABLE)
		src.audible_message(span_notice("The [src] sounds as if it's inhaling as it begins to recharge."))

/obj/item/clothing/suit/space/soft/proc/on_timer_expire()
	clothing_flags = STOPSPRESSUREDAMAGE | THICKMATERIAL
	cold_protection = CHEST | GROIN | LEGS | FEET | ARMS | HANDS
	suit_integrity = 300
	integrity_has_failed = FALSE
	src.visible_message(span_notice("The [src] bulks back up. It seems to have recharged."))
