/datum/job/junior_engineer
	title = "Junior Engineer"
	trainee_role = TRUE
	department_head = list("Chief Engineer")
	faction = FACTION_STATION
	total_positions = 1
	spawn_positions = 1
	supervisors = "the chief engineer and senior engineers"
	selection_color = "#fff5cc"

	outfit = /datum/outfit/job/engineer/junior
	plasmaman_outfit = /datum/outfit/plasmaman/engineering

	paycheck = PAYCHECK_EASY
	paycheck_department = ACCOUNT_ENG

	liver_traits = list(TRAIT_ENGINEER_METABOLISM)

	display_order = JOB_DISPLAY_ORDER_JUNIOR_ENGINEER
	bounty_types = CIV_JOB_ENG
	departments = DEPARTMENT_ENGINEERING

	family_heirlooms = list(/obj/item/clothing/head/hardhat, /obj/item/screwdriver, /obj/item/wrench, /obj/item/weldingtool, /obj/item/crowbar, /obj/item/wirecutters)

	mail_goodies = list(
		/obj/item/storage/box/lights/mixed = 20,
		/obj/item/lightreplacer = 10,
		/obj/item/holosign_creator/engineering = 8,
		/obj/item/clothing/head/hardhat/red/upgraded = 1
	)

	job_flags = JOB_ANNOUNCE_ARRIVAL | JOB_CREW_MANIFEST | JOB_EQUIP_RANK | JOB_CREW_MEMBER | JOB_NEW_PLAYER_JOINABLE


/datum/outfit/job/engineer/junior
	name = "Junior Engineer"
	jobtype = /datum/job/junior_engineer
	card_access = /datum/card_access/job/junior_engineer

	belt = /obj/item/storage/belt/utility/full/engi
	l_pocket = /obj/item/pda/engineering
	ears = /obj/item/radio/headset/headset_eng
	uniform = /obj/item/clothing/under/rank/engineering/engineer
	shoes = /obj/item/clothing/shoes/workboots
	head = /obj/item/clothing/head/hardhat
	r_pocket = /obj/item/t_scanner

	backpack = /obj/item/storage/backpack/industrial
	satchel = /obj/item/storage/backpack/satchel/eng
	duffelbag = /obj/item/storage/backpack/duffelbag/engineering
	box = /obj/item/storage/box/survival/engineer
	pda_slot = ITEM_SLOT_LPOCKET
	backpack_contents = list(/obj/item/modular_computer/tablet/preset/advanced/engineering=1)

	skillchips = list(/obj/item/skillchip/job/engineer)
