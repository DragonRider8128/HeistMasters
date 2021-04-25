extends "res://Characters/CharacterTemplate.gd"

var motion = Vector2()
var disguised = false
var velocity_multiplier = 1
var in_dark_mode = true

export var disguise_slowdown = 0.5
export var disguise_duration = 5
export var disguise_amount = 3

const PLAYER_SPRITE = "res://GFX/PNG/Hitman 1/hitman1_stand.png"
const BOX_SPRITE = "res://GFX/PNG/Tiles/tile_130.png"
const HUMAN_OCCLUDER = "res://Characters/HumanOccluder.tres"
const BOX_OCCLUDER = "res://Characters/BoxOccluder.tres"
const PLAYER_LIGHT = "res://GFX/PNG/Hitman 1/hitman1_stand.png"
const BOX_LIGHT = "res://GFX/PNG/Tiles/tile_130.png"

func _ready():
	reveal()
	in_dark_mode = true
	$Timer.wait_time = disguise_duration
	get_tree().call_group("DisguiseDisplay","update_disguises",disguise_amount)

func _physics_process(delta):
	update_movement()
	move_and_slide(motion * velocity_multiplier)
	if disguised:
		$DisguiseLabel.text = str($Timer.time_left).pad_decimals(2)
		$DisguiseLabel.rect_rotation = -rotation_degrees
		
func _input(event):
	if Input.is_action_just_pressed("toggle_vision_mode"):
		get_tree().call_group("Interface","cycle_vision_mode")
	if Input.is_action_just_pressed("toggle_disguise"):
		toggle_disguise()


func update_movement():
	look_at(get_global_mouse_position())
	if Input.is_action_pressed("move_down") and not Input.is_action_pressed("move_up"):
		motion.y = clamp(motion.y + SPEED, 0, MAX_SPEED)
	elif Input.is_action_pressed("move_up") and not Input.is_action_pressed("move_down"):
		motion.y = clamp(motion.y - SPEED, -MAX_SPEED, 0)
	else:
		motion.y = lerp(motion.y, 0, DECELERATION)
		
	if Input.is_action_pressed("move_right") and not Input.is_action_pressed("move_left"):
		motion.x = clamp(motion.x + SPEED, 0, MAX_SPEED)
	elif Input.is_action_pressed("move_left") and not Input.is_action_pressed("move_right"):
		motion.x = clamp(motion.x - SPEED, -MAX_SPEED, 0)
	else:
		motion.x = lerp(motion.x, 0, DECELERATION)


func toggle_disguise():
	if disguised:
		reveal()
	elif disguise_amount > 0 and in_dark_mode:
		disguise()

func reveal():
	$Sprite.texture = load(PLAYER_SPRITE)
	$LightOccluder2D.occluder = load(HUMAN_OCCLUDER)
	$Light2D.texture = load(PLAYER_LIGHT)
	$DisguiseLabel.hide()
	velocity_multiplier = 1
	disguised = false
	collision_layer = 1

func disguise():
	$Timer.start()
	$Sprite.texture = load(BOX_SPRITE)
	$LightOccluder2D.occluder = load(BOX_OCCLUDER)
	$Light2D.texture = load(BOX_LIGHT)
	$DisguiseLabel.show()
	velocity_multiplier = disguise_slowdown
	disguised = true
	collision_layer = 16
	disguise_amount -= 1
	get_tree().call_group("DisguiseDisplay","update_disguises",disguise_amount)


func collect_briefcase():
	var loot = Node.new()
	loot.set_name("Briefcase")
	add_child(loot)
	get_tree().call_group("Loot","collect_loot")


func _on_VisionMode_vision_mode_changed(mode):
	if mode == "DARK":
		in_dark_mode = true
	else:
		in_dark_mode = false
