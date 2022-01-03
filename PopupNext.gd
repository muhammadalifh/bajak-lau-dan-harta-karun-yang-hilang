extends CenterContainer

onready var tween = $Tween

var sudah_muncul = false
var level_1 = "res://Level1.tscn"
var level_2 = "res://Level2.tscn"
func _ready():
	muncul() #jika di ganti ke muncul() maka akan langung muncul popup nya
	
func muncul():
	tween.interpolate_property(self, "rect_position:y", -300, 56, 1, Tween.TRANS_ELASTIC, Tween.EASE_OUT)
	tween.start()


func _on_Hero_hero_menang():
	muncul()

func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		SceneManager.change_scene("Level1.tscn")
