// MENU
if (keyboard_check_pressed(vk_escape))
{
    global.show_menu = false;
}

if room == Room2
{
    // NORMAL MOVEMENT
    hsp = (keyboard_check(ord("D")) - keyboard_check(ord("A"))) * 4;
    vsp = (keyboard_check(ord("S")) - keyboard_check(ord("W"))) * 4;
}
else
{
    // 0 GRAVITY MOVEMENT
    var mx = keyboard_check(ord("D")) - keyboard_check(ord("A"));
    var my = keyboard_check(ord("S")) - keyboard_check(ord("W"));

    hsp += mx * accel;
    vsp += my * accel;

    hsp *= friction;
    vsp *= friction;

    var spd = point_distance(0, 0, hsp, vsp);

    if (spd > maxspd)
    {
        var dir = point_direction(0, 0, hsp, vsp);

        hsp = lengthdir_x(maxspd, dir);
        vsp = lengthdir_y(maxspd, dir);
    }

    var moving = (abs(hsp) > 0.1 || abs(vsp) > 0.1);

    if (!moving)
    {
        float_timer += 0.07;
        y += sin(float_timer) * 0.5;
    }
}



//DASH

    if keyboard_check_pressed(vk_shift)
    {
        if (hsp != 0 || vsp != 0)
        {
            dash_dir = point_direction(0, 0, hsp, vsp);
            dash_timer = 8;
        }
    }

if dash_timer > 0
{
    dash_timer--;

    x += lengthdir_x(12, dash_dir);
    y += lengthdir_y(12, dash_dir);
}

// APPLY MOVEMENT
x += hsp;
y += vsp;

// COLLECT ITEM
if keyboard_check_pressed(ord("E"))
{
    var item = instance_place(x, y, Obj_Item);

    if (item != noone)
    {
        global.has_item = true; 

        pickup_message = "Item Collected!";
        pickup_timer = 60;

        with (item)
        {
            instance_destroy();
        }
    }
}

// PICKUP MESSAGE TIMER
if (pickup_timer > 0)
{
    pickup_timer--;
}
else
{
    pickup_message = "";
}


// RESTART
if keyboard_check_pressed(ord("R"))
{
    room_restart();
}

// ENTER DOOR
if place_meeting(x, y, Obj_Door)
{
    if keyboard_check_pressed(vk_enter)
    {
        room_goto_next();
    }
}


// SPRITES FOR MOVING
if room == Room2
{
    if keyboard_check(ord("W"))
    {
        sprite_index = Spr_player_walk_up;
    }
    else if keyboard_check(ord("S"))
    {
        sprite_index = Spr_player_walk_down;
    }
    else if keyboard_check(ord("A"))
    {
        sprite_index = Spr_player_walk_left;
    }
    else if keyboard_check(ord("D"))
    {
        sprite_index = Spr_player_walk_right;
    }
    else
    {
        if sprite_index == Spr_player_walk_up
            sprite_index = Spr_player_up_idle;

        else if sprite_index == Spr_player_walk_down
            sprite_index = Spr_player_down_idle;

        else if sprite_index == Spr_player_walk_left
            sprite_index = Spr_player_left_idle;

        else if sprite_index == Spr_player_walk_right
            sprite_index = Spr_player_right_idle;
    }
}
else
{
    if keyboard_check(ord("W"))
    {
        sprite_index = Spr_player_up;
    }
    else if keyboard_check(ord("S"))
    {
        sprite_index = Spr_player_down;
    }
    else if keyboard_check(ord("A"))
    {
        sprite_index = Spr_player_left;
    }
    else if keyboard_check(ord("D"))
    {
        sprite_index = Spr_player_right;
    }
	
}

// ENTER DOOR
if place_meeting(x, y, Obj_backtoroom2)
{
    if keyboard_check_pressed(vk_enter)
    {
        room_goto(Room2);
    }
}

// ENTER DOOREND
if place_meeting(x, y, Obj_doorend)
{
    if keyboard_check_pressed(vk_enter)
    {
        room_goto(End);
    }
}


// TALK / GIVE ITEM TO LADY LIPS
if keyboard_check_pressed(ord("C"))
{
    var npc = instance_nearest(x, y, Obj_lady_lips);

    if (npc != noone && point_distance(x, y, npc.x, npc.y) < 200)
    {
        // GIVE ITEM FIRST
        if (global.has_item)
        {
            global.has_item = false;

            npc.sprite_index = Spr_lady_lips_happy;
            npc.dialogue_stage = 2;

            npc.npc_text = "You found my eye. Thank you, the exit has been revealed.";
            npc.npc_timer = 300;
            npc.show_choices = false;

            // SPAWN DOOR ONLY HERE
            var spawn = instance_find(Obj_DoorSpawn, 0);

            if (spawn != noone)
            {
                instance_create_layer(spawn.x, spawn.y, "Instances", Obj_doorend);
            }
        }
        else
        {
            // NORMAL DIALOGUE ONLY
            if (npc.dialogue_stage == 0)
            {
                npc.npc_text = "Who are you?";
                npc.npc_timer = 999;
                npc.show_choices = true;
            }
            else if (npc.dialogue_stage == 1)
            {
                npc.npc_text = "Find me my eye.";
                npc.npc_timer = 180;
            }
            else if (npc.dialogue_stage == 2)
            {
                npc.npc_text = "The exit is open. Hurry.";
                npc.npc_timer = 180;
            }
        }
    }
}
// CHOICE 1
if keyboard_check_pressed(ord("1"))
{
    var npc = instance_nearest(x, y, Obj_lady_lips);

    if (npc != noone && npc.show_choices == true && point_distance(x, y, npc.x, npc.y) < 200)
    {
        npc.npc_text = "Find me my eye and I'll help you escape.";
        npc.npc_timer = 180;
        npc.show_choices = false;
        npc.dialogue_stage = 1;
    }
}

// CHOICE 2
if keyboard_check_pressed(ord("2"))
{
    var npc = instance_nearest(x, y, Obj_lady_lips);

    if (npc != noone && npc.show_choices == true && point_distance(x, y, npc.x, npc.y) < 200)
    {
        npc.npc_text = "How rude.";
        npc.npc_timer = 180;
        npc.show_choices = false;
        npc.dialogue_stage = 1;
    }
}

// ENTER TONGUE DOOR
if place_meeting(x, y, Obj_tongue_door)
{
    if keyboard_check_pressed(vk_enter)
    {
        room_goto(tonguelevel);
	}
}

// ENTER TOOTH DOOR
if place_meeting(x, y, Obj_tooth_door)
{
    if keyboard_check_pressed(vk_enter)
    {
        if (global.has_key)
        {
            room_goto(toothlevel);
        }
        else
        {
            pickup_message = "The door is locked.";
            pickup_timer = 120;
        }
    }
}

// TUTORIAL
if (tutorial_timer > 0)
{
    tutorial_timer--;
}