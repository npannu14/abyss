// INPUT (LEFT / RIGHT ONLY)
move_x = keyboard_check(ord("D")) - keyboard_check(ord("A"));
move_x *= move_speed;

var jump_pressed = keyboard_check_pressed(vk_space);

// COLLISION CHECKS
is_grounded = place_meeting(x, y - 2, ground_object);
is_climbing = place_meeting(x, y, ladder_object);

// MOVEMENT

if (is_climbing)
{
    // LADDER MOVEMENT (NORMAL)
    move_y = keyboard_check(ord("S")) - keyboard_check(ord("W"));
    move_y *= climb_speed;
}
else
{
    // JUMP (SPACE)
    if (is_grounded && jump_pressed)
    {
        move_y = jump_speed;
    }
    else
    {
        // UPSIDE-DOWN GRAVITY (pulls UP toward ceiling)
        move_y -= gravity_force;

        if (move_y < -max_fall_speed)
        {
            move_y = -max_fall_speed;
        }
    }
}

// MOVE PLAYER
move_and_collide(move_x, move_y, ground_object);

// OUT OF BOUNDS RESET
if (x < -20 || x > room_width + 20 || y < -20 || y > room_height + 20)
{
    room_restart();
}