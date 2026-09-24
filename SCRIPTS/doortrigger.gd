extends Area2D

@onready var tile = $"../TileMapLayer2"
@export var stay_in_trap_position: bool = false
@export var trap_position: Vector2 = Vector2(-500, -30)
@export var reset_position: Vector2 = Vector2(0, -30)

func _on_body_entered(body: Node2D) -> void:
	if body.name == "player":
		var door = get_tree().current_scene.find_child("door")
		if door:
			door.global_position = trap_position
			if stay_in_trap_position:
				await get_tree().create_timer(6.5).timeout
				tile.clear()
				queue_free()
				return
			await get_tree().create_timer(1.5).timeout
			door.global_position = reset_position
