// GREETING

if (npc_timer > 0)
{
    npc_timer--;
}



// LADY LIPS TALKING
if (dialogue_stage == 2)
{
    sprite_index = sprite_happy;
}
else if (npc_timer > 0)
{
    sprite_index = sprite_talking;
}
else
{
    sprite_index = sprite_normal;
}