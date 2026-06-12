if (mouse_check_button_pressed(mb_left))
{
    if (point_in_rectangle(mouse_x, mouse_y, x - 40, x + 40, y - 15, y + 15))
    {
        global.show_menu = !global.show_menu;
    }
}