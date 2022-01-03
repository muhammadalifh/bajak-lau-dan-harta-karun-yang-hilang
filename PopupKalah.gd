extends CenterContainer

onready var tween = $Tween

var sudah_muncul = false

func _ready():
	pass #jika di ganti ke muncul() maka akan langung muncul popup nya
	
func muncul():
	tween.interpolate_property(self, "rect_position:y", -300, 56, 1, Tween.TRANS_ELASTIC, Tween.EASE_OUT)
	tween.start()

func _on_Restart_pressed():
	SceneManager.change_scene("res://Level" + str(int(get_tree().current_scene.name)) +".tscn")


func _on_Hero_hero_mati():
	if not sudah_muncul:
		sudah_muncul = true
		muncul()


func _on_Exit_pressed():
	SceneManager.change_scene("res://Title.tscn")
