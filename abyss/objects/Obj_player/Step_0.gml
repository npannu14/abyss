// MOVEMENT

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

    // IDLE BOB
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

// APPLY MOVEMENT
x += hsp;
y += vsp;

// COLLECT ITEM
if keyboard_check_pressed(ord("E"))
{
    var item = instance_place(x, y, Obj_Item);

    if (item != noone)
    {
        pickup_message = "Item Collected!";
        pickup_timer = 60;

        with (item)
        {
            instance_destroy();
        }
    }
}

if (pickup_timer > 0)
{
    pickup_timer--;
}


// RESTART
if keyboard_check_pressed(ord("R"))
{
    room_restart();
}

// wtf man
if place_meeting(x, y, Obj_Door)
{
    if keyboard_check_pressed(vk_enter)
    {
        room_goto(Room2);
    }
}