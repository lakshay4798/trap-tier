extends Area2D

@onready var panel = $Panel
@export var close_speed : float = 2
@export var next_level_scene : PackedScene

func _ready() -> void:
	pass

func _on_body_entered(body: Node2D) -> void:
	if body.name == "player":
		# 1. Freeze player inputs and movement instantly
		body.set_physics_process(false)
		
		# 2. Find the visual door artwork to locate the true center
		var door_art = find_child("Panel")
		if not door_art:
			door_art = find_child("DoorArch")
			
		# 3. LEVEL DEVIL PERFECT SNAP: Teleport player to the absolute visual center of the door panel
		if door_art and door_art is Control:
			body.global_position.x = door_art.global_position.x + (door_art.size.x / 2.0)
		
		# 4. Create your synchronized physics-locked tween layout
		var tween = create_tween().set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
		
		# 5. Shrink the door artwork flat to the floor
		if door_art:
			door_art.pivot_offset = Vector2(door_art.size.x / 2.0, door_art.size.y)
			tween.tween_property(door_art, "scale:y", 0.0, close_speed)
			
		# 6. Force the player's sprite to shrink and sink downward on that perfect center line
		var player_sprite = body.get_node_or_null("AnimatedSprite2D")
		if player_sprite:
			tween.parallel().tween_property(player_sprite, "scale:y", 0.0, close_speed)
			tween.parallel().tween_property(body, "global_position:y", body.global_position.y + 32, close_speed)
			
		if next_level_scene:
			await get_tree().create_timer(2.0).timeout
			get_tree().call_deferred("change_scene_to_packed", next_level_scene)
		else:
			print("level not loaded")
