extends Area2D

@onready var tile = $"../TileMapLayer2"
@export var target_layer_name: String = "TileMapLayer"
@export var shrink_to_scale_x: float = 0.5  
@export var collapse_duration: float = 0.3 
@onready var spikes = $"../spikes"
@onready var realdoor = $"../door2"

func _on_body_entered(body: Node2D) -> void:
	if body.name == "player":
		var tile_layer = get_tree().current_scene.find_child(target_layer_name)
		if tile_layer:
			var tween = create_tween().set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
			var screen_width = get_viewport_rect().size.x
			var target_move_x = (screen_width * (1.0 - shrink_to_scale_x)) / 2.0
			tween.tween_property(tile_layer, "scale:x", shrink_to_scale_x, collapse_duration)
			tween.parallel().tween_property(tile_layer, "position:x", tile_layer.position.x + target_move_x, collapse_duration)
			spikes.visible = true
			tile.visible = true
			realdoor.visible = true
			queue_free() 
