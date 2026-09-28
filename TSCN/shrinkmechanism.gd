extends Area2D

# 🎮 Inspector Configurations: Set these uniquely for any level!
@export var target_layer_name: String = "TileMapLayer"
@export var shrink_to_scale_x: float = 0.5  # Slices the moving space in half!
@export var collapse_duration: float = 0.3   # Fast, surprising slam speed

func _on_body_entered(body: Node2D) -> void:
	if body.name == "player":
		# Find the exact tile layer in whatever level is currently active
		var tile_layer = get_tree().current_scene.find_child(target_layer_name)
		if tile_layer:
			# Create a smooth, physics-locked animator tween
			var tween = create_tween().set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
			
			# Smoothly crush the tilemap's vertical height over your duration
			tween.tween_property(tile_layer, "scale:x", shrink_to_scale_x, collapse_duration)
			
			# Delete this trigger zone so it only trolls them once!
			queue_free()
