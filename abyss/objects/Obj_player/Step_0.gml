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

// BOOST
if keyboard_check_pressed(vk_space)
{
    hsp *= boost_speed;
    vsp *= boost_speed;
}

//DASH
if room == Room2
{
    if keyboard_check_pressed(vk_shift)
    {
        if (hsp != 0 || vsp != 0)
        {
            dash_dir = point_direction(0, 0, hsp, vsp);
            dash_timer = 8;
        }
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
        has_item = true;

        pickup_message = "Lady Lips Eye Collected!";
        pickup_timer = 60;

        with (item)
        {
            instance_destroy();
        }
    }
}

// RESTART
if keyboard_check_pressed(ord("R"))
{
    room_restart();
}

//ENTER DOOR
if place_meeting(x, y, Obj_Door)
{
    if keyboard_check_pressed(vk_enter)
    {
        room_goto(Room2);
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
	
// TALK TO LADY LIPS
if keyboard_check_pressed(ord("C"))
{
    var npc = instance_nearest(x, y, Obj_lady_lips);

    if (npc != noone && point_distance(x, y, npc.x, npc.y) < 80)
    {
        // First greeting
        if (npc.dialogue_stage == 0)
        {
            npc.npc_text = "Who are you?";
            npc.npc_timer = 999;
            npc.show_choices = true;
        }

        // After greeting is finished
        else if (npc.dialogue_stage == 1)
        {
            npc.npc_text = "Find me the Eye of Veyras.";
            npc.npc_timer = 180;
        }
    }
}

// CHOICE 1
if keyboard_check_pressed(ord("1"))
{
    var npc = instance_nearest(x, y, Obj_lady_lips);

    if (npc != noone && npc.show_choices)
    {
        npc.npc_text = "Find me the Eye of Veyras and I'll help you escape.";
        npc.npc_timer = 180;
        npc.show_choices = false;
        npc.dialogue_stage = 1;
    }
}

// CHOICE 2
if keyboard_check_pressed(ord("2"))
{
    var npc = instance_nearest(x, y, Obj_lady_lips);

    if (npc != noone && npc.show_choices)
    {
        npc.npc_text = "How rude.";
        npc.npc_timer = 180;
        npc.show_choices = false;
        npc.dialogue_stage = 1;
    }
}
// GIVE LADY LIPS ITEM
if keyboard_check_pressed(ord("C"))
{
    var npc = instance_nearest(x, y, Obj_lady_lips);

    if (npc != noone && point_distance(x, y, npc.x, npc.y) < 80)
    {
        if (has_item)
        {
            has_item = false;

            npc.npc_text = "You found my eye. Thank you, the exit has been revealed.";
            npc.npc_timer = 300;

            var spawn = instance_find(Obj_DoorSpawn, 0);

            if (spawn != noone)
            {
                instance_create_layer(
                    spawn.x,
                    spawn.y,
                    "Instances",
                    Obj_Door
                );
            }
        }
        else
        {
            npc.npc_text = "Find me my eye.";
            npc.npc_timer = 180;
        }
    }
}