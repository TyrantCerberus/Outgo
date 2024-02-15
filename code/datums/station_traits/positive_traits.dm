/datum/station_trait/galactic_grant
	name = "Galactic grant"
	trait_type = STATION_TRAIT_POSITIVE
	weight = 5
	show_in_report = TRUE
	report_message = "Your station has been selected for a special grant. Some extra funds has been made available to your cargo department."

/datum/station_trait/galactic_grant/on_round_start()
	var/datum/bank_account/cargo_bank = SSeconomy.get_dep_account(ACCOUNT_CAR)
	cargo_bank.adjust_money(rand(2000, 5000))

/datum/station_trait/premium_internals_box
	name = "Premium internals boxes"
	trait_type = STATION_TRAIT_POSITIVE
	weight = 10
	show_in_report = TRUE
	report_message = "The internals boxes for your crew have been filled with bonus equipment."
	trait_to_give = STATION_TRAIT_PREMIUM_INTERNALS

/datum/station_trait/bountiful_bounties
	name = "Bountiful bounties"
	trait_type = STATION_TRAIT_POSITIVE
	weight = 5
	show_in_report = TRUE
	report_message = "It seems collectors in this system are extra keen to on bounties, and will pay more to see their completion."

/datum/station_trait/bountiful_bounties/on_round_start()
	SSeconomy.bounty_modifier *= 1.2

/datum/station_trait/strong_supply_lines
	name = "Strong supply lines"
	trait_type = STATION_TRAIT_POSITIVE
	weight = 5
	show_in_report = TRUE
	report_message = "Prices are low in this system, BUY BUY BUY!"
	blacklist = list(/datum/station_trait/distant_supply_lines)

/datum/station_trait/strong_supply_lines/on_round_start()
	SSeconomy.pack_price_modifier *= 0.8

/datum/station_trait/filled_maint
	name = "Filled up maintenance"
	trait_type = STATION_TRAIT_POSITIVE
	weight = 5
	show_in_report = TRUE
	report_message = "Our workers accidentaly forgot more of their personal belongings in the maintenace areas."
	blacklist = list(/datum/station_trait/empty_maint)
	trait_to_give = STATION_TRAIT_FILLED_MAINT

/datum/station_trait/quick_shuttle
	name = "Quick Shuttle"
	trait_type = STATION_TRAIT_POSITIVE
	weight = 5
	show_in_report = TRUE
	report_message = "Due to proximity to our supply station, the cargo shuttle will have a quicker flight time to your cargo department."
	blacklist = list(/datum/station_trait/slow_shuttle)

/datum/station_trait/quick_shuttle/on_round_start()
	. = ..()
	SSshuttle.supply.callTime *= 0.5

/datum/station_trait/deathrattle_department
	name = "deathrattled department"
	trait_type = STATION_TRAIT_POSITIVE
	show_in_report = TRUE
	trait_flags = STATION_TRAIT_ABSTRACT
	blacklist = list(/datum/station_trait/deathrattle_all)

	var/department_to_apply_to
	var/department_name = "department"
	var/datum/deathrattle_group/crew/deathrattle_group

/datum/station_trait/deathrattle_department/New()
	. = ..()
	deathrattle_group = new("[department_name] group")
	blacklist += subtypesof(/datum/station_trait/deathrattle_department) - type //All but ourselves
	name = "deathrattled [department_name]"
	report_message = "All members of [department_name] have received an implant to notify each other if one of them dies. This should help improve job-safety!"
	RegisterSignal(SSdcs, COMSIG_GLOB_JOB_AFTER_SPAWN, PROC_REF(on_job_after_spawn))

/datum/station_trait/deathrattle_department/proc/on_job_after_spawn(datum/source, datum/job/job, mob/living/spawned, client/player_client)
	SIGNAL_HANDLER

	if(!(job.departments & department_to_apply_to))
		return

	var/obj/item/implant/deathrattle/implant_to_give = new()
	deathrattle_group.register(implant_to_give)
	implant_to_give.implant(spawned, spawned, TRUE, TRUE)

/datum/station_trait/deathrattle_department/service
	trait_flags = NONE
	weight = 1
	department_to_apply_to = DEPARTMENT_SERVICE
	department_name = "Service"

/datum/station_trait/deathrattle_department/cargo
	trait_flags = NONE
	weight = 1
	department_to_apply_to = DEPARTMENT_CARGO
	department_name = "Cargo"

/datum/station_trait/deathrattle_department/engineering
	trait_flags = NONE
	weight = 1
	department_to_apply_to = DEPARTMENT_ENGINEERING
	department_name = "Engineering"

/datum/station_trait/deathrattle_department/command
	trait_flags = NONE
	weight = 1
	department_to_apply_to = DEPARTMENT_COMMAND
	department_name = "Command"

/datum/station_trait/deathrattle_department/science
	trait_flags = NONE
	weight = 1
	department_to_apply_to = DEPARTMENT_SCIENCE
	department_name = "Science"

/datum/station_trait/deathrattle_department/security
	trait_flags = NONE
	weight = 1
	department_to_apply_to = DEPARTMENT_SECURITY
	department_name = "Security"

/datum/station_trait/deathrattle_department/medical
	trait_flags = NONE
	weight = 1
	department_to_apply_to = DEPARTMENT_MEDICAL
	department_name = "Medical"

/datum/station_trait/deathrattle_all
	name = "deathrattled station"
	trait_type = STATION_TRAIT_POSITIVE
	show_in_report = TRUE
	weight = 1
	report_message = "All members of the station have received an implant to notify each other if one of them dies. This should help improve job-safety!"
	var/datum/deathrattle_group/crew/deathrattle_group

/datum/station_trait/deathrattle_all/New()
	. = ..()
	deathrattle_group = new("station group")
	blacklist = subtypesof(/datum/station_trait/deathrattle_department)
	RegisterSignal(SSdcs, COMSIG_GLOB_JOB_AFTER_SPAWN, PROC_REF(on_job_after_spawn))

/datum/station_trait/deathrattle_all/proc/on_job_after_spawn(datum/source, datum/job/job, mob/living/spawned, client/player_client)
	SIGNAL_HANDLER

	var/obj/item/implant/deathrattle/implant_to_give = new()
	deathrattle_group.register(implant_to_give)
	implant_to_give.implant(spawned, spawned, TRUE, TRUE)
