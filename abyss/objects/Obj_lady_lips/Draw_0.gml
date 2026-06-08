//LADY LIPS

draw_self();

if (npc_timer > 0)
{
    draw_text(x - 20, y - 40, npc_text);
}

if (show_choices)
{
    draw_text(x - 20, y - 20, "1. I'm lost");
    draw_text(x - 20, y, "2. None of your business");
}