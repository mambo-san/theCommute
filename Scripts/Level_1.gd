extends Node2D

var game_manager = null #It will stay null if you run using F6
var day = 1
var money = 0.0

#Background animation
var morning_color = Color(1, 0.87, 0.73)  # RGB(255, 223, 186)
var night_color = Color(0.1, 0.1, 0.44)   # RGB(25, 25, 112)
var min_x = 0 #Set to the home door location
var max_x = 1000 #Set to the Office door location

var local_pitch_scale = 1.0
var local_player_speed = 1.0

var player_falling = false
var rng

var income_popup

func _ready():
	game_manager = get_tree().root.get_node_or_null("GameManager")
	if game_manager:
		print("Game Manger found")
	else:
		print("Running without GameManger")
	$Player.entered_office.connect(reload_another_day.bind())
	$HUD_Canvas/HUD/DayLabel.text = "Day: " + str(day)
	$HUD_Canvas/HUD/Mission.loadTasks(day)
	min_x = $door_home.position.x
	max_x = $door_office.position.x
	local_player_speed = $Player.NORMAL_SPEED
	rng = RandomNumberGenerator.new()
	income_popup = preload("res://Scenes/MoneyPopup.tscn")

func _process(delta):
	var player = $Player
	var player_progress = (player.position.x - min_x) / (max_x - min_x)
	var background_color = morning_color.lerp(night_color, player_progress)
	$sunlight.color = background_color
	
	if player.position.x < 0:
		$BackgroundMusic.pitch_scale = 0.75
		player.speed = player.NORMAL_SPEED
		$HUD_Canvas/HUD.visible = false
	else:
		$BackgroundMusic.pitch_scale = local_pitch_scale
		player.speed = local_player_speed
		$HUD_Canvas/HUD.visible = true
		
	if player_falling:
		$Player/Marker2D/Camera2D.zoom *= 0.01 * delta
	
func reload_another_day():
	day += 1
	
	var player = $Player
	player.position = $door_home.position
	if player.speed < 1000:
		local_player_speed += 20.0
		local_pitch_scale += 0.01
		
	$HUD_Canvas/HUD/DayLabel.text = "Day: " + str(day)
	$HUD_Canvas/HUD/Mission.loadTasks(day)
	
	if day > 15 and day%6 ==0:
		print("Pay day: " + str(day))
		var random_pay = rng.randf_range(money, money+ 100.0) #promotion
		var popup = income_popup.instantiate()
		popup.set_amount(random_pay)
		$HUD_Canvas/HUD.add_child(popup)
		money += random_pay
		$HUD_Canvas/HUD/SavingsLabel.visible = true
		$HUD_Canvas/HUD/SavingsLabel.text = "$%0.2f" %money

func _on_background_music_finished():
	$BackgroundMusic.play()


func _on_area_2d_body_entered(body):
	#Stop the music and camera
	$BackgroundMusic.stop()
	#Take snapshop of Player's position.
	await get_tree().create_timer(0.3).timeout
	$Player/CameraMarker.reparent(self)
	$HUD_Canvas/HUD.visible = false
	$HUD_Canvas/HUD_gameover.visible = true
	$HUD_Canvas/HUD_gameover.set_number_of_days_label(day)
	$HUD_Canvas/HUD_gameover.set_money_in_bank_label(money)
