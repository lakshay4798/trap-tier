extends Control
@onready var click = $click

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.



func _on_button_pressed() -> void:
	click.play()
	await get_tree().create_timer(0.30).timeout
	get_tree().change_scene_to_file("res://TSCN/level_1.tscn")
