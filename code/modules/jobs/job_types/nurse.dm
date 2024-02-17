/datum/job/nurse
	title = "Nurse"
	department_head = list("Chief Medical Officer")
	faction = FACTION_STATION
	total_positions = 1
	spawn_positions = 1
	supervisors = "the chief medical officer and senior doctors"
	selection_color = "#ffeef0"

	outfit = /datum/outfit/job/nurse
	plasmaman_outfit = /datum/outfit/plasmaman/medical

	paycheck = PAYCHECK_EASY
	paycheck_department = ACCOUNT_MED

	liver_traits = list(TRAIT_MEDICAL_METABOLISM)

	display_order = JOB_DISPLAY_ORDER_NURSE
	bounty_types = CIV_JOB_MED
	departments = DEPARTMENT_MEDICAL

	family_heirlooms = list(/obj/item/storage/firstaid/ancient/heirloom)

	mail_goodies = list(
		/obj/item/reagent_containers/pill/patch/colpisbital = 20,
		/obj/item/reagent_containers/pill/patch/cremiisuri = 20,
		/obj/item/reagent_containers/pill/patch/libital = 10,
		/obj/item/reagent_containers/pill/patch/aiuri = 10
	)

	job_flags = JOB_ANNOUNCE_ARRIVAL | JOB_CREW_MANIFEST | JOB_EQUIP_RANK | JOB_CREW_MEMBER | JOB_NEW_PLAYER_JOINABLE


/datum/outfit/job/nurse
	name = "Nurse"
	jobtype = /datum/job/nurse
	card_access = /datum/card_access/job/nurse

	belt = /obj/item/pda/medical
	head = /obj/item/clothing/head/nursehat
	ears = /obj/item/radio/headset/headset_med
	uniform = /obj/item/clothing/under/rank/medical/doctor/blue
	gloves = /obj/item/clothing/gloves/color/latex
	shoes = /obj/item/clothing/shoes/sneakers/white

	backpack = /obj/item/storage/backpack/medic
	satchel = /obj/item/storage/backpack/satchel/med
	duffelbag = /obj/item/storage/backpack/duffelbag/med
	box = /obj/item/storage/box/survival/medical

	skillchips = list(/obj/item/skillchip/quicker_carry)

	chameleon_extras = /obj/item/gun/syringe
