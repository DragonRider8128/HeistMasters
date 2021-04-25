extends "res://Characters/ArmedGuard.gd"

func _process(delta):
	update_texture()

func update_texture():
	if Player_in_FOV() and Player_in_LOS():
		$Sprite.texture = load("res://GFX/PNG/Man Red/manRed_silencer.png")
	else:
		$Sprite.texture = load("res://GFX/PNG/Man Red/manRed_reload.png")
