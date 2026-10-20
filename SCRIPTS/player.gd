extends CharacterBody2D

@onready var door = $"../door"
@onready var animated : AnimatedSprite2D = $AnimatedSprite2D
#@onready var timer = $"../AudioStreamPlayer2D"
#@onready var color : ColorRect = $CanvasLayer/ColorRect
@onready var player = $"."
@export var SPEED : float = 300.0
@export var JUMP_VELOCITY : float = -400.0
@export var move_left_action: String = "move_left"
@export var move_right_action: String = "move_right"


var is_dead: bool = false

#LEVEL8
var timer: AudioStreamPlayer2D = null
var Label8level: Label = null
var level8door: Node2D = null
var level8door2: Node2D = null
var level8label: Label = null

func _ready() -> void:
	# #LEVEL8
	if get_tree().current_scene.name.to_lower() == "level_8":
		level8label = get_node_or_null("../Label") as Label
		level8door = get_node_or_null("../door") as Node2D
		level8door2 = get_node_or_null("../door2") as Node2D
		Label8level = get_node_or_null("../Label2") as Label
		timer = get_node_or_null("../AudioStreamPlayer2D") as AudioStreamPlayer2D
		
		if level8door2:
			level8door2.visible = false
		if level8label:
			level8label.visible = false
		if Label8level:
			Label8level.visible = false
		await get_tree().create_timer(5.0).timeout
		if is_instance_valid(level8label):
			level8label.visible = true


func _physics_process(delta: float) -> void:
	if velocity.x> 1 or velocity.x <-1:
		animated.animation = "run"
	#if is_dead:
		#return
	else:
		animated.animation = "idle"
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	if "level_4" in get_tree().current_scene.name.to_lower():
		if Input.is_key_pressed(KEY_S) or Input.is_action_pressed("ui_down"):
			scale = Vector2(0.5, 0.4)
		else:
			scale = Vector2(1.0, 0.9)
	if "level_5" in get_tree().current_scene.name.to_lower():
		if Input.is_key_pressed(KEY_SPACE):
			velocity.y = JUMP_VELOCITY * 0
			door.global_position = Vector2(190,270)
	if "level_8" in get_tree().current_scene.name.to_lower():
		if Input.is_key_pressed(KEY_S) or Input.is_action_pressed("ui_down"):
			scale = Vector2(0.1, 0.1)
		else:
			scale = Vector2(4.0, 0.5)
		if Input.is_key_pressed(KEY_ENTER):
			velocity.y = JUMP_VELOCITY * 0
			if level8door:
				level8door.global_position = Vector2(-3000, 200)
			if level8label:
				level8label.visible = true
			set_physics_process(false)
			timer.play()
			await get_tree().create_timer(3.0).timeout
			if Label8level:
				Label8level.visible = true
			if level8door2:
				level8door2.visible = true
			await get_tree().create_timer(7.0).timeout
			set_physics_process(true)

	if "level_9" in get_tree().current_scene.name.to_lower():
		if Input.is_key_pressed(KEY_SPACE) and Input.is_action_just_pressed("ui_accept"):
			if get_tree().current_scene.name.to_lower() == "level_9":
				velocity.y = -100.0  # Flap/jump in mid-air
			#elif is_on_floor():
				#velocity.y = -900.0  # Standard floor jump



	var direction := Input.get_axis(move_left_action, move_right_action)
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)


	if direction == 1.0:
		animated.flip_h = false
	elif direction == -1.0:
		animated.flip_h = true
		
	#floor_snap_length = 32.0
	#platform_on_leave = 2
	
	move_and_slide()
