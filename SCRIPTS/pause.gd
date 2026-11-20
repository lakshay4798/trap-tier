extends CanvasLayer


func _ready() -> void:
	visible = false


func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed and not event.echo:
		if event.keycode == KEY_P:
			var current_scene := get_tree().current_scene.scene_file_path
			if current_scene.ends_with("start.tscn") or current_scene.ends_with("endscene.tscn"):
				return
			get_tree().paused = not get_tree().paused
			visible = get_tree().paused
			
