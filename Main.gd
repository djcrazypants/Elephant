extends Node2D

# Joypads demo, written by Dana Olson <dana@shineuponthee.com>
#
# This is a demo of joypad support, and doubles as a testing application
# inspired by and similar to jstest-gtk.
#
# Licensed under the MIT license

# Member variables
var joy_num
var cur_joy
var axis_value

const DEADZONE = 0.2

func _fixed_process(delta):
	# Get theA joypad device number from the spinbox
	joy_num = get_node("device_info/joy_num").get_value()

	# Display the name of the joypad if we haven't already
	if joy_num != cur_joy:
		cur_joy = joy_num
		get_node("device_info/joy_name").set_text(Input.get_joy_name(joy_num))


func _ready():
	set_fixed_process(true)
	Input.connect("joy_connection_changed", self, "_on_joy_connection_changed")

#Called whenever a joypad has been connected or disconnected.
func _on_joy_connection_changed(device_id, connected):
	if device_id == cur_joy:
		if connected:
			get_node("device_info/joy_name").set_text(Input.get_joy_name(device_id))
		else:
			get_node("device_info/joy_name").set_text("")

func _on_start_vibration_pressed():
	var weak = get_node("vibration/vibration_weak_value").get_value()
	var strong = get_node("vibration/vibration_strong_value").get_value()
	var duration = get_node("vibration/vibration_duration_value").get_value()

	Input.start_joy_vibration(cur_joy, weak, strong, duration)

func _on_stop_vibration_pressed():
	Input.stop_joy_vibration(cur_joy)
