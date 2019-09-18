/obj/item/storage/backpack/assasin/perbag1/industrialp
	name = "industrial persistence backpack lvl 1"
	desc = "It's a tough backpack for persistently stashing items."
	icon_state = "engiepack"
	item_state = "engiepack"
	resistance_flags = FIRE_PROOF
	var/ownerkey = "woops"

/obj/item/storage/backpack/assasin/perbag1/industrialp/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_w_class = WEIGHT_CLASS_GIGANTIC
	STR.max_combined_w_class = 30
	STR.set_holdable(null, list(/obj/item/storage, /obj/item/reagent_containers,)) //muh recursive backpacks)

/obj/item/storage/backpack/assasin/perbag1/industrialp/PopulateContents()
	var/savefile/SS = new("Proof/perbag1/[ownerkey].sav")
	SS["src.contents"] >> src.contents

/obj/item/storage/backpack/assasin/perbag1/industrialp/attack_self(mob/user)
	if(ownerkey == usr.ckey)
		to_chat(user, "<span class='notice'>You saved.</span>")
		var/savefile/SS = new("Proof/perbag1/[ownerkey].sav")
		SS["src.contents"] << src.contents
		updateUsrDialog()
		qdel(src)


/obj/item/stack/perbag1spawner
	name = "persistence backpack lvl 1 Spawner"
	desc = "Used to spawn a persistence backpack lvl 1"
	icon_state = "rods"
	w_class = WEIGHT_CLASS_BULKY
	force = 1.0
	throwforce = 1.0
	throw_speed = 1
	throw_range = 10
	max_amount = 1
	attack_verb = list("hit", "bludgeoned", "whacked")

/obj/item/stack/perbag1spawner/attack_self(mob/user as mob)
	to_chat(usr, "Spawning persistence backpack lvl 1")
	var/obj/item/storage/backpack/assasin/perbag1/industrialp/PS = new /obj/item/storage/backpack/assasin/perbag1/industrialp ( usr.loc )
	PS.ownerkey = usr.ckey
	var/savefile/SS = new("Proof/perbag1/[PS.ownerkey].sav")
	SS["src.contents"] >> PS.contents
	to_chat(usr, "Spawned the persistence backpack lvl 1 with ID = [PS.ownerkey]")
	PS.add_fingerprint(usr)
	use(1)
	return