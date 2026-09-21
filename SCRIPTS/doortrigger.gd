extends Area2D

@onready var door = $"../door"
#@onready var hack= $"../door"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _on_body_entered(body: Node2D) -> void:
	if body.name == "player":
		door.global_position = Vector2(-500,-30)
		await get_tree().create_timer(1).timeout
		door.global_position = Vector2(0,-30)
		
