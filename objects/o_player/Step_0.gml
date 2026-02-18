// player input
key_up = keyboard_check(vk_up);
key_down = keyboard_check(vk_down);
key_left = keyboard_check(vk_left);
key_right = keyboard_check(vk_right);

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
	switch (round(input_direction))
	{
		case 0: dir_facing = 0; break;	
		case 90: dir_facing = 1; break;	
		case 180: dir_facing = 2; break;	
		case 270: dir_facing = 3; break;	
	}
	
	switch (dir_facing)
	{
		case 0: sprite_index = s_player_side; break;
		case 1: sprite_index = s_player_up; break;
		case 2: sprite_index = s_player_side; break;
		case 3: sprite_index = s_player_down; break;
	}
}

// set speed
image_speed = moving;

if (input_direction > 0) show_debug_message(dir_facing);

// FLIP LOGIC: 1 for right (dir 0), -1 for left (dir 2)
if (dir_facing == 2) {
    image_xscale = 1;
} else if (dir_facing == 0) {
    image_xscale = -1;
}

// Reset animation to first frame when idle
if (!moving) image_index = 0;
