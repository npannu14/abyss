
//COLLECT ITEM
draw_self();

if (pickup_timer > 0)
{
    draw_text(x - 30, y - 32, pickup_message);
}

//LADY LIPS
draw_self();

if (talk_timer > 0)
{
    draw_text(x - 20, y - 40, talk_text);
}