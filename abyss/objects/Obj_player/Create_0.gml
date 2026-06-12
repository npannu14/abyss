
// MOVEMENT
hsp = 0;
vsp = 0;
accel = 0.2;
friction = 0.98;
maxspd = 5;

// BOB
float_timer = 0;

// ITEM COLLECTED
pickup_message = "";
pickup_timer = 0;

// DASH
dash_timer = 0;
dash_dir = 0;

// MENU
global.show_menu = false;

// QUEST / INVENTORY
if (!variable_global_exists("has_key"))
{
    global.has_key = false;
}

if (!variable_global_exists("has_item"))
{
    global.has_item = false;
}

if (!variable_global_exists("lady_lips_helped"))
{
    global.lady_lips_helped = false;
}