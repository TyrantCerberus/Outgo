/mob/living/simple_animal/possum
	name = "possum"
	desc = "It's a possum, a small scavenging marsupial."
	icon_state = "possum"
	icon_living = "possum"
	icon_dead = "possum_dead"
	speak = list("Hiss!","HISS!","Hissss?")
	speak_emote = list("hisses")
	emote_hear = list("hisses.")
	emote_see = list("runs in a circle.", "shakes.")
	speak_chance = 1
	turns_per_move = 3
	blood_volume = 250
	see_in_dark = 5
	maxHealth = 15
	health = 15
	butcher_results = list(/obj/item/food/meat/slab = 1)
	response_help_continuous = "pets"
	response_help_simple = "pet"
	response_disarm_continuous = "gently pushes aside"
	response_disarm_simple = "gently push aside"
	response_harm_continuous = "kicks"
	response_harm_simple = "kick"
	density = FALSE
	pass_flags = PASSTABLE | PASSMOB
	mob_size = MOB_SIZE_TINY
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	gold_core_spawnable = FRIENDLY_SPAWN

/mob/living/simple_animal/possum/Initialize()
	. = ..()
	ADD_TRAIT(src, TRAIT_VENTCRAWLER_ALWAYS, INNATE_TRAIT)

/mob/living/simple_animal/possum/poppy
	name = "Poppy the Safety Possum"
	desc = "Safety first!"
	icon_state = "poppypossum"
	icon_living = "poppypossum"
	icon_dead = "poppypossum_dead"
	butcher_results = list(/obj/item/food/meat/slab = 1, /obj/item/clothing/head/hardhat = 1)
