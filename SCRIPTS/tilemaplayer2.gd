extends TileMapLayer

@export var press_speed = 80.0
@export var max_crush_distance : float = 210.0

var original_position:Vector2
var target_player : CharacterBody2D
var current_state:String = "idle"
var wait_timer: float = 0.0

func _ready() -> void:
	original_position = position
	target_player = get_parent().find_child("player", true,false)
	
func _physics_process(delta: float) -> void:
	if not target_player:
		return
	match current_state:
		"idle":
			if abs(target_player.velocity.x) > 0.1:
				current_state = "down"
		"down":
			if position.y < original_position.y +max_crush_distance:
				position.y += press_speed *delta
			else:
				current_state = "waiting"
				wait_timer = 4.0
		"waiting":
			if wait_timer > 0:
				wait_timer -=delta
			else:
				current_state = "up"
		"up":
			if position.y > original_position.y:
				position.y -=press_speed *delta
			else:
				position = original_position
				current_state = "idle"
