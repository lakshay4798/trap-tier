extends CharacterBody2D

@onready var animated : AnimatedSprite2D = $AnimatedSprite2D
@onready var color : ColorRect = $CanvasLayer/ColorRect
@onready var player = $"."
@export var SPEED : float = 300.0
@export var JUMP_VELOCITY : float = -400.0
@export var move_left_action: String = "move_left"
@export var move_right_action: String = "move_right"

var is_dead: bool = false

#
#func _input(event: InputEvent) -> void:
	#if Input.is_key_pressed(KEY_S):
		#player.scale()

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
			
	var direction := Input.get_axis(move_left_action, move_right_action)
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		


	if direction == 1.0:
		animated.flip_h = false
	elif direction == -1.0:
		animated.flip_h = true
	move_and_slide()
