extends Area2D
@onready var door = $"../door"
@onready var spike = $"../spikes"
@onready var spike22 = $"../spikes"
@onready var label = $"../Label"
@onready var label3 = $"../Label3"
@onready var sound = $"../AudioStreamPlayer2D"

func _ready() -> void:
	pass # Replace with function body.


func _on_body_entered(body: Node2D) -> void:
	if body.name == "player":
		body.set_physics_process(false) # Stops player from moving
		body.velocity = Vector2.ZERO
		door.can_move = true
		label.visible = true
		label3.visible = true
		sound.play(3.0)
		#body.scale = Vector2(4,0.2)


func _on_spikeshow_body_entered(body: Node2D) -> void:
	if body.name == "player":
		spike22.visible = true
