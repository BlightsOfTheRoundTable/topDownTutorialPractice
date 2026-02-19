// player input
key_up = keyboard_check(vk_up);
key_down = keyboard_check(vk_down);
key_left = keyboard_check(vk_left);
key_right = keyboard_check(vk_right);
key_harvest = keyboard_check(vk_space);

// movement direction
input_direction = point_direction(0, 0, (key_right - key_left), (key_down - key_up));

// detect moving
var moving = ((key_right - key_left != 0) || (key_down - key_up != 0))

// calculate movement
hsp = lengthdir_x(walk_speed * moving, input_direction);
vsp = lengthdir_y(walk_speed * moving, input_direction);

// move
x += hsp;
y += vsp;



if (moving) 
{
	switch (round(input_direction)) //point_direction is buggy and will return decimals that dont work, so we round
	{
		case 0: dir_facing = 0; break;	
		case 90: dir_facing = 1; break;	
		case 180: dir_facing = 2; break;	
		case 270: dir_facing = 3; break;	
	}
	
	switch (dir_facing) //assign an animation sprite to each direction
	{
		case 0: sprite_index = s_player_side; break;
		case 1: sprite_index = s_player_up; break;
		case 2: sprite_index = s_player_side; break;
		case 3: sprite_index = s_player_down; break;
	}
}

// set speed
image_speed = moving;

// FLIP LOGIC: -1 for right (dir 2), 1 for left (dir 0) our walk only faces one direction, so we flip for the oposite
if (dir_facing == 2) {
    image_xscale = 1;
} else if (dir_facing == 0) {
    image_xscale = -1;
}

// Reset animation to first frame when idle
if (!moving) image_index = 0;


// harvest ingredient logic

var nearest_resource = instance_nearest(x, y, o_plant);

if (distance_to_object(nearest_resource) < 5) {
    if (key_harvest > 0) {
        instance_destroy(nearest_resource);
        
        // Add to inventory
        global.wood_count += floor(random_range(1, 4)); 
		show_debug_message("keyboard space value");
		show_debug_message("***********************");
		show_debug_message(key_harvest);
		show_debug_message("***********************");
		show_debug_message(global.wood_count);
    }
}