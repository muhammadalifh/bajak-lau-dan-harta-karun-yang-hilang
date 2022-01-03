extends Area2D

func _on_Cest_body_entered(body):
	if body.name == 'Hero':
		body.finish()
	var _cestefek = preload("res://CestEfek.tscn")
	var cestefek  = _cestefek.instance()
	cestefek.transform = self.transform
	get_tree().current_scene.add_child(cestefek)
