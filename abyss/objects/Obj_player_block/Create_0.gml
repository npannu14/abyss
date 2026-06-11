// MOVEMENT VARIABLES
move_speed = 3;
jump_speed = 14;        // POSITIVE now (important)
climb_speed = 3;

gravity_force = 0.5;   // keep small, smooth
max_fall_speed = 6;

move_x = 0;
move_y = 0;

// STATE VARIABLES
is_grounded = false;
is_climbing = false;

// OBJECTS
ground_object = Obj_ground;
ladder_object = Obj_ladder;

//KEY
global.has_key = false;

// ITEM COLLECTED
pickup_message = "";
pickup_timer = 0;