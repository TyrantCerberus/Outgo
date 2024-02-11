/obj/item/reagent_containers/pill/patch
	name = "chemical patch"
	desc = "A chemical patch for touch based applications."
	icon = 'icons/obj/chemical.dmi'
	icon_state = "bandaid"
	inhand_icon_state = "bandaid"
	possible_transfer_amounts = list()
	volume = 40
	apply_type = PATCH
	apply_method = "apply"
	self_delay = 30 // three seconds
	dissolvable = FALSE

/obj/item/reagent_containers/pill/patch/attack(mob/living/L, mob/user)
	if(ishuman(L))
		var/obj/item/bodypart/affecting = L.get_bodypart(check_zone(user.zone_selected))
		if(!affecting)
			to_chat(user, span_warning("The limb is missing!"))
			return
		if(affecting.status != BODYPART_ORGANIC)
			to_chat(user, span_notice("Medicine won't work on a robotic limb!"))
			return
	..()

/obj/item/reagent_containers/pill/patch/canconsume(mob/eater, mob/user)
	if(!iscarbon(eater))
		return FALSE
	return TRUE // Masks were stopping people from "eating" patches. Thanks, inheritance.

/obj/item/reagent_containers/pill/patch/libital
	name = "libital patch (brute)"
	desc = "Alleviates bruising; does minor liver damage. Diluted with Granibitaluri."
	list_reagents = list(/datum/reagent/medicine/c2/libital = 4, /datum/reagent/medicine/granibitaluri = 6)
	icon_state = "bandaid_brute"

/obj/item/reagent_containers/pill/patch/colpisbital
	name = "colpisbital patch (brute)"
	desc = "Alleviates light bruising but does minor liver damage. Also contains: Granibitaluri."
	list_reagents = list(/datum/reagent/medicine/c2/libital/colpisbital = 4, /datum/reagent/medicine/granibitaluri = 6)
	icon_state = "bandaid_brute"

/obj/item/reagent_containers/pill/patch/aiuri
	name = "aiuri patch (burn)"
	desc = "Heals burn injuries; does minor eye damage. Diluted with Granibitaluri."
	list_reagents = list(/datum/reagent/medicine/c2/aiuri = 6, /datum/reagent/medicine/granibitaluri = 4)
	icon_state = "bandaid_burn"

/obj/item/reagent_containers/pill/patch/cremiisuri
	name = "cremiisuri patch (burn)"
	desc = "Heals mild burn injuries but does minor eye damage. Also contains: Granibitaluri."
	list_reagents = list(/datum/reagent/medicine/c2/aiuri/cremiisuri = 6, /datum/reagent/medicine/granibitaluri = 4)
	icon_state = "bandaid_burn"

/obj/item/reagent_containers/pill/patch/synthflesh
	name = "synthflesh patch"
	desc = "Heals both brute and burn injuries. Toxic."
	list_reagents = list(/datum/reagent/medicine/c2/synthflesh = 20)
	icon_state = "bandaid_both"
