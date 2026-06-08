// GREETING

if (npc_timer > 0)
{
    npc_timer--;
}

// LADY LIPS TALKING
if (npc_timer > 0)
{
    sprite_index = Spr_lady_lips_speaking;
}
else
{
    sprite_index = Spr_lady_lips;
}