extends VBoxContainer

func _on_About_pressed():
	SceneManager.change_scene("res://Title.tscn")
func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		SceneManager.change_scene("Title.tscn")
