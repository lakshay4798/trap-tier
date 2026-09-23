extends Area2D

@onready var tile = $"../TileMapLayer2"
func _ready() -> void:
	pass 

func _on_body_entered(body: Node2D) -> void:
	if body.name == "player":
		body.set_physics_process(false)
		#var anim = body.get_node("AnimatedSprite2D")
		#anim.play("die")
		body.get_node("AnimatedSprite2D").visible = false
		tile.clear()
		# Find the particle node and trigger the explosion burst
		var particles = body.get_node("deathparticles")
		if particles:
			particles.emitting = true
		await get_tree().create_timer(2.0).timeout
		get_tree().reload_current_scene()
