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
