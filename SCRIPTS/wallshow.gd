extends Area2D
@onready var tile = $"../TileMap"
@onready var spike = $"../spikes"

func _ready() -> void:
	pass # Replace with function body.

func _on_body_entered(body: Node2D) -> void:
	if body.name == "player":
		tile.visible = false
		await get_tree().create_timer(2.0).timeout
		spike.visible = true
