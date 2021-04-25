extends Node2D

func _ready():
	update_marker_position(0)

func update_marker_position(objective_number):
	var marker = $ObjectiveMarker
	var place = $ObjectivePositions.get_child(objective_number)
	var message = $ObjectiveMessages.get_child(objective_number)
	
	$Tween.interpolate_property(marker, "position", marker.position,
			place.position, 0.5, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	$Tween.start()
	$ObjectiveSound.play()
	$TutorialGUI/AnimationPlayer.play("MessageChange")
	$TutorialGUI/Control/NinePatchRect/Label.text = message.message

func _on_MoveObjective_body_entered(body):
	update_marker_position(0)

func _on_DoorObjective_body_entered(body):
	update_marker_position(1)


func _on_NightvisionObjective_body_entered(body):
	get_tree().call_group("Interface","DARK_mode")
	update_marker_position(2)


func _on_LockedDoorObjective_body_entered(body):
	update_marker_position(3)


func _on_BriefcaseObjective_body_entered(body):
	update_marker_position(4)
