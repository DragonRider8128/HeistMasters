extends CanvasModulate

const DARK = Color("111111")
const NIGHTVISION = Color("a3b935")

var cooldown = false

signal vision_mode_changed


func _ready():
	visible = true
	color = DARK
	get_tree().call_group("Label","hide")
	get_tree().call_group("Lights","show")
	
	
func cycle_vision_mode():
	if not cooldown:
		if color == NIGHTVISION:
			DARK_mode()
			
		else:
			NIGHTVISION_mode()
			
	if $Timer.is_stopped():
		$Timer.start()	


func DARK_mode():
	cooldown = true
	color = DARK
	$AudioStreamPlayer2D.stream = load("res://SFX/nightvision_off.wav")
	$AudioStreamPlayer2D.play()
	get_tree().call_group("Label","hide")
	get_tree().call_group("Lights","show")
	emit_signal("vision_mode_changed","DARK")
	
func NIGHTVISION_mode():
	cooldown = true
	color = NIGHTVISION
	$AudioStreamPlayer2D.stream = load("res://SFX/nightvision.wav")
	$AudioStreamPlayer2D.play()
	get_tree().call_group("Label","show")
	get_tree().call_group("Lights","hide")
	emit_signal("vision_mode_changed","NIGHTVISION")


func _on_Timer_timeout():
	cooldown = false
