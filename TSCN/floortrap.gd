extends Area2D

@onready var fake : TileMapLayer = $"../TileMapLayer2"


func _ready() -> void:
	pass

func _on_body_entered(body: Node2D) -> void:
	if body.name == "player":
		fake.collision_enabled = false
	
