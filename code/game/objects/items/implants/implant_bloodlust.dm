/obj/item/implant/bloodlust
	name = "bloodlust implant"
	desc = "Causes the implantee to become energized when engaging in melee combat."
	icon_state = "reagents"
	activated = FALSE
	passive = TRUE
	allow_multiple = FALSE

/obj/item/implant/bloodlust/implant(mob/living/target, mob/user, silent = FALSE, force = FALSE)
	if(!ishuman(target))
		to_chat(user, "<span class='warning'>The [src] smartly refuses to enter the non-humanoid organism.</span>")
		return
	if(target.has_quirk(/datum/quirk/bloodlust))
		to_chat(user, "<span class='warning'>The [src] detects \the [target] is already under the influence of an endorphin enhancer and refuses to implant.</span>")
		return
	if(HAS_TRAIT(target, TRAIT_PACIFISM) && target.has_quirk(/datum/quirk/harm_averse))
		to_chat(user, "<span class='warning'>The [src] detects factors within \the [target] that would negate its effectiveness and refuses to implant.</span>")
		return
	. = ..()

/obj/item/implant/bloodlust/add_passive(mob/living/target)
	return target.add_quirk(/datum/quirk/bloodlust)

/obj/item/implant/bloodlust/remove_passive(mob/living/source)
	return source.remove_quirk(/datum/quirk/bloodlust)

///Implanter that spawns with a bloodlust implant, as well as an appropriate name
/obj/item/implanter/bloodlust
	name = "implanter (bloodlust)"
	imp_type = /obj/item/implant/bloodlust

///Implant case that spawns with a bloodlust implant, as well as an appropriate name and description
/obj/item/implantcase/bloodlust
	name = "implant case - 'Bloodlust'"
	desc = "A glass case containing a bloodlust implant."
	imp_type = /obj/item/implant/bloodlust
