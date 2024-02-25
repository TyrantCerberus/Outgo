//Reward containers unlocked by completing achievements
/obj/item/storage/box/reward
	name = "generic reward box"
	desc = "A box containing the reward for completing a specific task."

/obj/item/storage/box/reward/meteor
	name = "\improper Mini-Meteor reward box"
	desc = "Awarded for looking death in the eye."

/obj/item/storage/box/reward/meteor/PopulateContents()
	new /obj/item/toy/minimeteor(src)

/obj/item/storage/box/reward/bubblegum_gum
	name = "\improper Bubblegum Gum - Lifetime Supply reward box"
	desc = "Awarded for contributions to culinary science."

/obj/item/storage/box/reward/bubblegum_gum/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/storage/box/gum/bubblegum(src)

/obj/item/storage/box/reward/skillcape_miner
	name = "\improper Legendary Miner's cape reward box"
	desc = "Awarded for dedication to the acquisition of natural resources."

/obj/item/storage/box/reward/skillcape_miner/PopulateContents()
	new /obj/item/clothing/neck/cloak/skill_reward/mining(src)

/obj/item/storage/box/reward/skillcape_gamer
	name = "\improper Legendary Gamer's cape reward box"
	desc = "Awarded for being the very best, like no-one ever was!"

/obj/item/storage/box/reward/skillcape_gamer/PopulateContents()
	new /obj/item/clothing/neck/cloak/skill_reward/gaming(src)

/obj/item/storage/box/reward/skillcape_hacker
	name = "\improper Legendary Hacker's cape reward box"
	desc = "Awarded for demonstrating exceptional skill in the cracking of cyberware encryption."

/obj/item/storage/box/reward/skillcape_hacker/PopulateContents()
	new /obj/item/clothing/neck/cloak/skill_reward/hacker(src)

/obj/item/storage/box/reward/skillcape_cleaner
	name = "\improper Legendary Cleaner's cape reward box"
	desc = "Awarded for providing outstanding janitorial service."

/obj/item/storage/box/reward/skillcape_cleaner/PopulateContents()
	new /obj/item/clothing/neck/cloak/skill_reward/cleaning(src)
