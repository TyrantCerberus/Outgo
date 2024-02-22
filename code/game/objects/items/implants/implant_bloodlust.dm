/obj/item/implant/bloodlust
	name = "bloodlust implant"
	desc = "Causes the implantee to become energized when engaging in melee combat."
	icon_state = "reagents"
	activated = FALSE
	allow_multiple = FALSE

/obj/item/implant/bloodlust/implant(mob/living/target, mob/user, silent = FALSE, force = FALSE)
	if(!ishuman(target))
		to_chat(user, "<span class='warning'>The [src] smartly refuses to enter the non-human organism.</span>")
		return
	if(target.has_quirk(/datum/quirk/bloodlust))
		to_chat(user, "<span class='warning'>The [src] detects \the [target] is already under the influence of an endorphin enhancer and refuses to implant.</span>")
		return
	. = ..()
