extends Area2D


func _on_Key_body_entered(body):

	var _efekkey = preload("res://KeyEfek.tscn")
	var efekkey = _efekkey.instance()
	efekkey.transform = self.transform
	get_tree().current_scene.add_child(efekkey)
	
	remove_from_group("GrupKey")
	if body.name == 'Hero':
		body.ambil_key()
	queue_free()
