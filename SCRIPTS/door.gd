extends Area2D

@export var next_level_scene : PackedScene

func _ready() -> void:
	pass

func _on_body_entered(body: Node2D) -> void:
	if body.name == "player":
		body.set_physics_process(false)
		if next_level_scene:
			#get_tree().change_scene_to_packed(next_level_scene)
			get_tree().call_deferred("change_scene_to_packed", next_level_scene)
		else:
			print("level not loaded")
