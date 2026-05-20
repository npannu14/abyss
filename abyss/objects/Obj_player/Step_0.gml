//MOVEMENT
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
//MOVEMENT