extends Area2D

@onready var panel = $Panel
@export var close_speed : float = 2
@export var next_level_scene : PackedScene

func _ready() -> void:
	pass

func _on_body_entered(body: Node2D) -> void:
	if body.name == "player":
		#body.set_physics_process(false)
		var tween = create_tween()
		tween.tween_property(self, "position:y", position.y + 100, close_speed)
		#tween.parallel().tween_property(body, "global_position:y", body.global_position.y + 100, close_speed)
		var player_sprite = body.get_node_or_null("AnimatedSprite2D")
		if player_sprite:
			# Shrink the sprite's height to 0
			tween.parallel().tween_property(player_sprite, "scale:y", 0.0, close_speed)
			# Simultaneously pull the player's body downward by 20 pixels so they sink into the slot
			tween.parallel().tween_property(body, "global_position:y", body.global_position.y + 20, close_speed)

		if next_level_scene:
			await get_tree().create_timer(2.0).timeout
			get_tree().call_deferred("change_scene_to_packed", next_level_scene)
		else:
			print("level not loaded")
