extends Area2D

#@onready var tile = $"../TileMapLayer2"
@onready var death = $AudioStreamPlayer2D

func _ready() -> void:
	pass 

func _on_body_entered(body: Node2D) -> void:
	if body.name == "player":
		body.set_physics_process(false)
		#var anim = body.get_node("AnimatedSprite2D")
		#anim.play("die")
		body.get_node("AnimatedSprite2D").visible = false
		#tile.clear()

		var particles = body.get_node("deathparticles")
		if particles:
			particles.emitting = true
			death.play()
		var current_level = get_tree().current_scene
		if current_level:
			shake_node(current_level, 4.0,0.4)
		await get_tree().create_timer(1.4).timeout
		
		get_tree().reload_current_scene()


func shake_node(target: Node2D, intensity: float, duration: float) -> void:
	var orig_pos = target.position
	var time_elapsed = 0.0
	
	while time_elapsed < duration:
	
		var current_intensity = intensity * (1.0 - (time_elapsed / duration))
		
		target.position.x = orig_pos.x + randf_range(-current_intensity, current_intensity)
		target.position.y = orig_pos.y + randf_range(-current_intensity, current_intensity)
		
		if target.is_inside_tree() and target.get_tree():
			await target.get_tree().process_frame
			time_elapsed += target.get_process_delta_time()
		else:
			break
