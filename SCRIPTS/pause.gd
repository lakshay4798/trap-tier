extends CanvasLayer
@onready var info = $infowindow
@onready var label = $infowindow/Label
@onready var label2 = $infowindow/Label2

func _ready() -> void:
	visible = false

func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed and not event.echo:
		if event.keycode == KEY_P:
			var current_scene := get_tree().current_scene.scene_file_path
			if current_scene.ends_with("start.tscn") or current_scene.ends_with("endscene.tscn"):
				return
			get_tree().paused = not get_tree().paused
			#info.visible = true
			#label.visible = true
			#label2.visible = false
			visible = get_tree().paused


func _on_button_pressed() -> void:
	info.visible = true
	label.visible = true
	label2.visible = false
	#await get_tree().create_timer(7.0).timeout
	#info.visible = false
	#label.visible = false


func _on_back_pressed() -> void:
	info.visible = false
	label.visible = false
	
