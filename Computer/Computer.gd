extends Node2D

var can_click = false
var combination

export var lock_group = "Unset"

func _ready():
	generate_combination()
	get_tree().call_group("LockedDoors", "set_combination", combination, lock_group)
	$Label.text = lock_group


func _on_Area2D_body_entered(body):
	can_click = true


func _on_Area2D_body_exited(body):
	can_click = false
	$CanvasLayer/ComputerPopup.hide()
	$Light2D.enabled = false


func _on_Area2D_input_event(viewport, event, shape_idx):
	if Input.is_mouse_button_pressed(BUTTON_LEFT) and can_click:
		$CanvasLayer/ComputerPopup.popup_centered()
	$Light2D.enabled = true


func generate_combination():
	combination = CombinationGenerator.generate_combination(4)
	set_popup_text()

func set_popup_text():
	$CanvasLayer/ComputerPopup.set_text(combination)
	

