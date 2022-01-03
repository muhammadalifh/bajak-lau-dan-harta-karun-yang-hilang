extends KinematicBody2D

# move_and_slide() Fungsi ini untuk menggerakkan hero , dengan merubah vektor X 

var laju_cepat = 400
var laju_normal = 120
var laju = laju_normal
var kecepatan = Vector2.ZERO
var laju_lompat = -380
var gravitasi = 12
var koin = 0
var sedang_terluka = false
var health_max = 200
var health = 200

var key = 0
var partikel_hero = preload("res://PartikelHero.tscn")

onready var sprite = $Sprite

signal hero_mati
signal hero_menang
signal hero_update_health(value)
signal hero_update_koin(value)

signal hero_update_key(value)

func _physics_process(delta):
	kecepatan.y = kecepatan.y + gravitasi
	
	if(not sedang_terluka and Input.is_action_pressed("gerak_kanan")):
		kecepatan.x = laju
	if(not sedang_terluka and Input.is_action_pressed("gerak_kiri")):
		kecepatan.x = -laju
	
	if(not sedang_terluka and Input.is_action_just_pressed("lari_cepat")):
		lari_cepat()
	
	if(not sedang_terluka and Input.is_action_pressed("lompat") and is_on_floor()):
		keluarkan_partikel("lompat")
		kecepatan.y = laju_lompat
		$EfekLompat.play()
	
	var kecepatan_jatuh = kecepatan.y
	
#	print(kecepatan.y)
	kecepatan.x = lerp(kecepatan.x, 0, 0.2)
	kecepatan = move_and_slide(kecepatan, Vector2.UP)
	
	if kecepatan.y - kecepatan_jatuh < -gravitasi:
		keluarkan_partikel("jatuh")

	if not sedang_terluka:
		update_animasi()

func update_animasi():
	if is_on_floor():
		if kecepatan.x < (laju * 0.5) and kecepatan.x > (-laju * 0.5):
			sprite.play("Diam")
		else:
			if laju == laju_normal:
				sprite.play("Lari")
			elif laju == laju_cepat:
				sprite.play("LariCepat")
	else:
		if kecepatan.y > 0:
			#jatuh
			sprite.play("Jatuh")
		else:
			#lompat
			sprite.play("Lompat")

	sprite.flip_h = false
	if kecepatan.x < 0:
		sprite.flip_h = true


func lari_cepat():
	laju = laju_cepat
	$Timer.start()
	$EfekDash.play()

func _on_Timer_timeout():
	laju = laju_normal

func ambil_koin():
	koin += 1
	$EfekKoin.play()
#	print("KOIN : ", koin)
	emit_signal("hero_update_koin", koin)
	#Cek jumlah koin
	var grup_koin = get_tree().get_nodes_in_group("GrupKoin")
	var jumlah_koin = grup_koin.size()
	print("GRUP KOIN: ", grup_koin)
	print("JUMLAH KOIN: ", jumlah_koin)	
#	Jika habis panggil signal hero_menang
	if jumlah_koin == 0:
		emit_signal("hero_menang")


func terluka():
	sedang_terluka = true
	health -= 75
	$EfekTerkenaMusuh.play()
	emit_signal("hero_update_health", (float(health)/float(health_max)) * 100)
	if kecepatan.x > 0:
		kecepatan.x = -500
	else:
		kecepatan.x = 500
	sprite.play("Terluka")
	yield(get_tree().create_timer(1), "timeout") #func yang memberhentikan fungsi yang berjalan dan kemudian akan melanjutkan fungsi itu apabila dia sudah ada kondisi untuk melanjutkan fungsi itu
	
	if health <= 0:
		mati()
	else:
		sedang_terluka = false

func mati():
	sprite.play("Mati")
	set_collision_layer_bit(0, false)
	set_collision_mask_bit(2, false)
	yield(get_tree().create_timer(1), "timeout")
	emit_signal("hero_mati")
#	get_tree().change_scene("res://Level1.tscn")

func keluarkan_partikel(jenis):
	var _partikel_hero = partikel_hero.instance()
	_partikel_hero.play(jenis)
	_partikel_hero.flip_h = sprite.flip_h
	_partikel_hero.global_position = global_position
	get_tree().current_scene.add_child(_partikel_hero)


func _on_Sprite_frame_changed():
	if sprite.animation == "Lari" and sprite.frame == 2:
		keluarkan_partikel("lari")

func finish():
	var grup_key = get_tree().get_nodes_in_group("GrupKey")
	var jumlah_key = grup_key.size()
	if jumlah_key == 0:
		emit_signal("hero_menang")

func ambil_key():
	key = ("Kunci Ditemukan")
	$EfekKey.play()
	emit_signal("hero_update_key",key)
