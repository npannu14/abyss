// MENU
if (global.show_menu)
{
    draw_set_alpha(0.8);
    draw_rectangle(0, 0, room_width, room_height, false);
    draw_set_alpha(1);

    draw_set_color(c_black);
    draw_text(50, 80, "MECHANICS:");
    draw_text(50, 120, "A/D - Move Left and Right");
    draw_text(50, 150, "W/S - Move Up and Down/Ladder");
    draw_text(50, 180, "SPACE - Jump");
    draw_text(50, 210, "E - Pick up item");
    draw_text(50, 240, "ENTER - Doors");
    draw_text(50, 270, "C - Talk");
  draw_text(50, 340, "-------------------------");
draw_text(50, 400, "R - Restart Level");
draw_text(50, 430, "SHIFT - Dash");
draw_text(50, 460, "Click ESC to Close Menu");

    draw_set_color(c_white);
}