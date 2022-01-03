extends VBoxContainer

func _on_Play_pressed():
	SceneManager.change_scene("res://Dialogue.tscn")
func _process(delta):
	if Input.is_action_just_pressed("Next"):
		SceneManager.change_scene("Dialogue.tscn")
	if Input.is_action_just_pressed("Back"):
		SceneManager.change_scene("About.tscn")

func _on_About_pressed():
	SceneManager.change_scene("res://About.tscn")


func _on_Quit_button_up():
	get_tree().quit()
