#define MED_SKILLCHIP_MULTIPLIER 0.5
///multiplies the time of do_mob by MED_SKILLCHIP_MULTIPLIER if the user has the TRAIT_FASTMED
#define CHEM_INTERACT_DELAY(delay, user) HAS_TRAIT(user, TRAIT_FASTMED) ? (delay * MED_SKILLCHIP_MULTIPLIER) : delay
