SUBSYSTEM_DEF(security_level)
	name = "Security Level"
	flags = SS_NO_FIRE
	/// Currently set security level
	var/current_level = SEC_LEVEL_GREEN

/**
 * Sets a new security level as our current level
 *
 * Arguments:
 * * new_level The new security level that will become our current level
 */
/datum/controller/subsystem/security_level/proc/set_level(new_level)
	SSsecurity_level.current_level = new_level
	SEND_SIGNAL(src, COMSIG_SECURITY_LEVEL_CHANGED, new_level)
	if(SSnightshift.can_fire && (current_level >= SEC_LEVEL_RED))
		SSnightshift.next_fire = world.time + 7 SECONDS // Fire nightshift after the security level announcement is complete
	SSblackbox.record_feedback("tally", "security_level_changes", 1, get_security_level())
