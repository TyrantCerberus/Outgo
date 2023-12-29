/obj/projectile/neurotoxin
	name = "neurotoxin spit"
	icon_state = "neurotoxin"
	damage = 5
	damage_type = TOX
	nodamage = FALSE
	paralyze = 100
	flag = BIO
	impact_effect_type = /obj/effect/temp_visual/impact_effect/neurotoxin

/obj/projectile/neurotoxin/on_hit(atom/target, blocked = FALSE)
	if(isalien(target))
		paralyze = 0
		nodamage = TRUE
	if(ishuman(target))
		var/mob/living/carbon/human/H = target
		paralyze = clamp((paralyze - H.getarmor(null, BIO)), 10, 100) //minimum stun time can be reduced to is 1 second
	return ..()
