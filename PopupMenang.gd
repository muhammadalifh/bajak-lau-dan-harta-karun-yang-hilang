extends CenterContainer

onready var tween = $Tween

var sudah_muncul = false
var level_1 = "res://Level1.tscn"
var level_2 = "res://Level2.tscn"
func _ready():
	pass #jika di ganti ke muncul() maka akan langung muncul popup nya
	
func muncul():
	tween.interpolate_property(self, "rect_position:y", -300, 56, 1, Tween.TRANS_ELASTIC, Tween.EASE_OUT)
	yield(get_tree().create_timer(1), "timeout")
	tween.start()


func _on_Hero_hero_menang():
	muncul()

func _on_Exit_pressed():
	SceneManager.change_scene("res://Level" + str(int(get_tree().current_scene.name) + 1) +".tscn")

func _process(delta):
	if Input.is_action_just_pressed("Continue"):
		SceneManager.change_scene("res://Level" + str(int(get_tree().current_scene.name) + 1) +".tscn")


