//0-GRAVITY MOVEMENT
var mx = keyboard_check(ord("D")) - keyboard_check(ord("A"));
var my = keyboard_check(ord("S")) - keyboard_check(ord("W"));

hsp += mx * accel;
vsp += my * accel;

hsp *= friction;
vsp *= friction;


var cur_speed = point_distance(0, 0, hsp, vsp);

if (cur_speed > maxspd)
{
    var dir = point_direction(0, 0, hsp, vsp);

    hsp = lengthdir_x(maxspd, dir);
    vsp = lengthdir_y(maxspd, dir);
}

x += hsp;
y += vsp;
//0-GRAVITY MOVEMENT

//BOB
if room != Room2
{
    var moving = (abs(hsp) > 0.1 || abs(vsp) > 0.1);

    if (moving)
    {
        idle_time = 0;
        idle_y = y;
    }
    else
    {
        idle_time++;

        if (idle_time > 5)
        {
            float_timer += 0.07;
            y = idle_y + sin(float_timer) * 6;
        }
    }
}
//BOB

//BOOST
if keyboard_check_pressed(vk_space)
{
    hsp *= boost_speed;
    vsp *= boost_speed;
}
//BOOST

//REGULAR MOVEMENT
if room != Room2
{
    // Zero gravity friction/bobbing here

    float_timer += 0.07;
    y = idle_y + sin(float_timer) * 6;

    hsp *= 0.98;
    vsp *= 0.98;
}

if room == Room2
{
    // Regular movement
    move_speed = 4;
}
else
{
    // Zero gravity movement
    move_speed = 7;
}
//REGULAR MOVEMENT

//COLLECT
if keyboard_check_pressed(ord("E"))
{
    var item = instance_place(x, y, Obj_Item);

    if (item != noone)
    {
        with (item)
        {
            instance_destroy();
        }
    }
}
//COLLECT
if keyboard_check_pressed(ord("E"))
{
    var item = instance_place(x, y, Obj_Item);

    if (item != noone)
    {
        show_debug_message("Item Collected");

        with (item)
        {
            instance_destroy();
        }
    }
}
//COLLECTED BOX

//COLLECTED BOX

//COUNT

//COUNT

//RESTART
if keyboard_check_pressed(ord("R"))
{
    room_restart();
}
//RESTART

//CHAT
if global.chat_open
{
    if keyboard_check_pressed(vk_enter)
    {
        global.chat_open = false;
    }
}
//