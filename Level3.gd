extends Node2D



onready var health_progress = $CanvasLayer/HealthBar/TextureProgress
onready var jumlah_koin = $CanvasLayer/CoinBar/Label

func _on_Zona_Jatuh_body_entered(body):
	if body.name == 'Hero':
		SceneManager.change_scene("res://Level3.tscn")


func _on_Hero_hero_update_health(value):
	health_progress.value = value


func _on_Hero_hero_update_koin(value):
	jumlah_koin.text = String(value)

