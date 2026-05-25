//NPC
// Horizontal
if !place_meeting(x + hsp, y, Obj_NPC)
{
    x += hsp;
}

// Vertical
if !place_meeting(x, y + vsp, Obj_NPC)
{
    y += vsp;
}
//NPC