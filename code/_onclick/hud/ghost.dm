/atom/movable/screen/ghost
	icon = 'icons/hud/screen_ghost.dmi'

/atom/movable/screen/ghost/MouseEntered(location, control, params)
	. = ..()
	flick(icon_state + "_anim", src)

/atom/movable/screen/ghost/spawners_menu
	name = "Spawners menu"
	icon_state = "spawners"

/atom/movable/screen/ghost/spawners_menu/Click()
	var/mob/dead/observer/observer = usr
	observer.open_spawners_menu()

/atom/movable/screen/ghost/orbit
	name = "Orbit"
	icon_state = "orbit"

/atom/movable/screen/ghost/orbit/Click()
	var/mob/dead/observer/G = usr
	G.follow()

/atom/movable/screen/ghost/reenter_corpse
	name = "Reenter corpse"
	icon_state = "reenter_corpse"

/atom/movable/screen/ghost/reenter_corpse/Click()
	var/mob/dead/observer/G = usr
	G.reenter_corpse()

/atom/movable/screen/ghost/teleport
	name = "Teleport"
	icon_state = "teleport"

/atom/movable/screen/ghost/teleport/Click()
	var/mob/dead/observer/G = usr
	G.dead_tele()

/atom/movable/screen/ghost/activities
	name = "Bored?"
	icon_state = "bored"

/atom/movable/screen/ghost/activities/Click()
	var/mob/dead/observer/G = usr
	if(usr.hud_used.inventory_shown && G.hud_used)
		usr.hud_used.inventory_shown = FALSE
		usr.client.screen -= G.hud_used.toggleable_inventory
	else
		usr.hud_used.inventory_shown = TRUE
		usr.client.screen += G.hud_used.toggleable_inventory

/atom/movable/screen/ghost/pai
	name = "pAI Candidate"
	icon_state = "pai"

/atom/movable/screen/ghost/pai/Click()
	var/mob/dead/observer/G = usr
	G.register_pai()

/atom/movable/screen/ghost/mafia
	name = "Mafia Signup"
	icon_state = "mafia"

/atom/movable/screen/ghost/mafia/Click()
	var/mob/dead/observer/G = usr
	G.mafia_signup()

/atom/movable/screen/ghost/dm
	name = "Deathmatch Lobby"
	icon_state = "dm"

/atom/movable/screen/ghost/dm/Click()
	var/mob/dead/observer/G = usr
	G.deathmatch_signup()

/atom/movable/screen/ghost/ctf
	name = "Capture-The-Flag"
	icon_state = "ctf"

/atom/movable/screen/ghost/ctf/Click() // Yes, this is ugly, but I don't really care.
	for(var/obj/machinery/capture_the_flag/CTF in GLOB.machines)
		if(CTF.game_id != "centcom")
			continue
		CTF.attack_ghost(usr)
		return

/datum/hud/ghost/New(mob/owner)
	..()
	var/atom/movable/screen/using

	using = new /atom/movable/screen/ghost/orbit()
	using.screen_loc = ui_ghost_orbit
	using.hud = src
	static_inventory += using

	using = new /atom/movable/screen/ghost/reenter_corpse()
	using.screen_loc = ui_ghost_reenter_corpse
	using.hud = src
	static_inventory += using

	using = new /atom/movable/screen/ghost/teleport()
	using.screen_loc = ui_ghost_teleport
	using.hud = src
	static_inventory += using

	using = new /atom/movable/screen/ghost/activities()
	using.screen_loc = ui_ghost_activities
	using.hud = src
	static_inventory += using

	using = new /atom/movable/screen/ghost/pai()
	using.screen_loc = ui_ghost_pai
	using.hud = src
	toggleable_inventory += using

	//Players are currently not allowed to select mafia: remove these comments if/when it's fixed
	/*using = new /atom/movable/screen/ghost/mafia()
	using.screen_loc = ui_ghost_mafia
	using.hud = src
	toggleable_inventory += using*/

	using = new /atom/movable/screen/ghost/dm()
	using.screen_loc = ui_ghost_dm
	using.hud = src
	toggleable_inventory += using

	using = new /atom/movable/screen/ghost/ctf()
	using.screen_loc = ui_ghost_ctf
	using.hud = src
	toggleable_inventory += using

	using = new /atom/movable/screen/ghost/spawners_menu()
	using.screen_loc = ui_ghost_spawners_menu
	using.hud = src
	toggleable_inventory += using

	using = new /atom/movable/screen/language_menu
	using.screen_loc = 	ui_ghost_language_menu
	using.icon = ui_style
	using.hud = src
	static_inventory += using

/datum/hud/ghost/show_hud(version = 0, mob/viewmob)
	// don't show this HUD if observing; show the HUD of the observee
	var/mob/dead/observer/O = mymob
	if (istype(O) && O.observetarget)
		plane_masters_update()
		return FALSE

	. = ..()
	if(!.)
		return
	var/mob/screenmob = viewmob || mymob
	if(!screenmob.client.prefs.ghost_hud)
		screenmob.client.screen -= static_inventory
	else
		screenmob.client.screen += static_inventory

//We should only see observed mob alerts.
/datum/hud/ghost/reorganize_alerts(mob/viewmob)
	var/mob/dead/observer/O = mymob
	if (istype(O) && O.observetarget)
		return
	. = ..()

