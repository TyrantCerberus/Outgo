//This proc gives out rewards at roundstart and to latejoiners
/proc/give_achievement_reward(mob/living/L, latejoin = FALSE)
	if(CONFIG_GET(flag/allow_achievement_rewards))
		if(!L.client)
			log_runtime("[latejoin ? "Latejoin" : "Released"] mob [L] lacks a client, skipping reward issuing.")
		if(ishuman(L))
			var/mob/living/carbon/human/H = L
			var/datum/job/J = SSjob.GetJob(H.job)
			var/reward_path_holder
			if(H.client?.prefs.job_reward_path && H.client?.prefs.jobs_reward_is_restricted_to.Find(J.title))
				reward_path_holder = H.client?.prefs.job_reward_path
			else if(H.client?.prefs.general_reward_path)
				reward_path_holder = H.client?.prefs.general_reward_path

			if(reward_path_holder)
				if(!H.equip_to_slot_or_del(new reward_path_holder(H), ITEM_SLOT_BACKPACK, TRUE))
					to_chat(H, "<span class='warning'>Failed to equip reward item. Please contact an admin.</span>")
					log_runtime("Failed to award mob [H] achievement item [reward_path_holder].")
