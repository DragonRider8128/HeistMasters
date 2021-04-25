extends ColorRect

export var lose_without_loot = true

func _on_Area2D_body_entered(body):
	if body.has_node("Briefcase"):
		get_tree().change_scene("res://Levels/Win.tscn")
	elif lose_without_loot:
		get_tree().change_scene("res://Levels/GameOver.tscn")
