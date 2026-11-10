extends Control
@onready var click = $click
@onready var info = $infowindow
@onready var color = $ColorRect2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _on_button_pressed() -> void:
	click.play()
	await get_tree().create_timer(0.30).timeout
	get_tree().change_scene_to_file("res://TSCN/level_1.tscn")


func _on_button_2_pressed() -> void:
	click.play()
	await get_tree().create_timer(0.3).timeout
	color.visible = true
	info.visible = true

func _on_back_pressed() -> void:
	click.play()
	await get_tree().create_timer(0.3).timeout
	info.visible = false
	color.visible = false
