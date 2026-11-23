extends Area2D
@onready var spike = $"../spikes"
@onready var spike2 = $"../spikes2"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _on_body_entered(body: Node2D) -> void:
	if body.name == "player":
		#await  get_tree().create_timer(0.3).timeout
		spike.visible = true
		await get_tree().create_timer(0.9).timeout
		spike2.visible = true
		
