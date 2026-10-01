extends Area2D


@onready var doorsound = $AudioStreamPlayer2D
@onready var panel = $Panel
@export var close_speed : float = 2
@export var next_level_scene : PackedScene
@export var wrong_door : bool = false


func _ready() -> void:
	pass

func _on_body_entered(body: Node2D) -> void:
	if body.name == "player":
		body.set_physics_process(false)
		
		var door_art = find_child("Panel")
		if not door_art:
			door_art = find_child("DoorArch")
		if door_art and door_art is Control:
			body.global_position.x = door_art.global_position.x + (door_art.size.x / 2.0)
			
		var fade_layer = CanvasLayer.new()
		var fade_rect = ColorRect.new()
		fade_rect.color = Color.BLACK
		fade_rect.set_anchors_preset(Control.PRESET_FULL_RECT)
		fade_rect.modulate.a = 0.0 
		fade_layer.add_child(fade_rect)
		add_child(fade_layer)
		
		var tween = create_tween().set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
		if door_art:
			door_art.pivot_offset = Vector2(door_art.size.x / 2.0, door_art.size.y)
			tween.tween_property(door_art, "scale:y", 0.0, close_speed)
			
		var player_sprite = body.get_node_or_null("AnimatedSprite2D")
		if player_sprite:
			tween.parallel().tween_property(player_sprite, "scale:y", 0.0, close_speed)
			tween.parallel().tween_property(body, "global_position:y", body.global_position.y + 32, close_speed)
			doorsound.play()
			
		# ─── 🫨 THE PERFECT OFFSET-BASED SCREEN SHAKE ───
		var cam = get_tree().current_scene.find_child("Camera2D")
		if cam:
			var shake = create_tween().set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
			# Rapidly bounce the visual secondary offset layer back and forth
			for i in 8:
				var rand_offset = Vector2(randf_range(-10, 10), randf_range(-10, 10))
				shake.tween_property(cam, "offset", rand_offset, 0.03)
			# Instantly snap the offset back to (0, 0) so the screen resets perfectly
			shake.tween_property(cam, "offset", Vector2.ZERO, 0.03)

		tween.parallel().tween_property(fade_rect, "modulate:a", 1.0, close_speed)
			
		if next_level_scene:
			await get_tree().create_timer(2.0).timeout
			get_tree().call_deferred("change_scene_to_packed", next_level_scene)
		else:
			print("level not loaded")
