extends "res://Doors/Door.gd"

export var lock_group = "Unset"

func _ready():
	add_to_group("LockedDoors")

func _on_Door_input_event(viewport, event, shape_idx):
	if Input.is_mouse_button_pressed(BUTTON_LEFT) and can_click:
		$CanvasLayer/Numpad.popup_centered()

func _on_Door_body_exited(body):
	if body.collision_layer == 1:
		can_click = false
		$CanvasLayer/Numpad.hide()
		$CanvasLayer/Numpad.reset_lock()




func _on_Numpad_combination_correct():
	open()
	$CanvasLayer/Numpad.hide()
	
func _on_Computer_combination(numbers, c_lock_group):
	if c_lock_group == lock_group:
		$CanvasLayer/Numpad.combination = numbers
		$Label.text = lock_group

func set_combination(numbers, c_lock_group):	
	if c_lock_group == lock_group:
		$CanvasLayer/Numpad.combination = numbers
		$Label.text = lock_group

	
