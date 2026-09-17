extends Area2D

@onready var fake : TileMapLayer = $"../TileMapLayer2"
#@onready var anim : AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	if body.name == "player":
		#anim.animation = "die"
		fake.collision_enabled = false
	
