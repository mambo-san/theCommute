extends Control

#List labels to be displayed in order
@export var label_list: Array[RichTextLabel] = []
@export var player_sprite: Sprite2D
var label_index = 0
#fade-in animation
var fade_speed = 0.2
var alpha = 0.0
#skip dialog
var skip_pressed = false
# Initial hue value for coloring text
var color_change_speed: float = 0.3
var hue = 0.0
var bbcode_fade_speed: float = 0.4
var wobble_speed: float = 10
var wobble_intensity: float = 10.0
var bbcode_alpha: float = 1.0
var direction: float = -1.0
var time_passed: float = 0.0
#Game control
signal button_start_pressed
signal button_exit_pressed


# Called when the node enters the scene tree for the first time.
func _ready():
	for child in get_children():
		child.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if label_index < label_list.size():
		var currently_displayed = label_list[label_index]
		
		if not currently_displayed.visible:
			currently_displayed.modulate.a = 0
			currently_displayed.visible = true
		
		if skip_pressed:
			print("skip pressed")
			skip_pressed = false
			if alpha < 1.0:
				print("settting alpha to 1")
				alpha = 1.0
				currently_displayed.modulate.a = alpha
			elif label_index == 0:
				print("Skipping label index 0")
				currently_displayed.visible = false
				label_index += 1
				alpha = 0.0
				player_sprite.visible = true
		elif currently_displayed.visible:
			if alpha < 1.0:
				alpha += fade_speed * delta
				alpha = clamp(alpha, 0.0, 1.0)
				currently_displayed.modulate.a = alpha
			else:
				if label_index > 0 and label_index < label_list.size():
					label_index += 1
					alpha = 0.0
	
	#Do you want to play text
	if $DoYouWantToPlayLabel.visible:
		fade_speed = 0.1
		#Rainbow prep
		hue += color_change_speed * delta
		hue = wrapf(hue, 0.0, 1.0)  # Ensure hue stays within 0.0 to 1.0 range
		var rainbow_color = Color.from_hsv(hue, 1, 1)
		#Fading prep
		
		var commute_color = Color(0.5, 0.5, 0.5)  # Gray with fading effect
		#Wobble prep
		

		var bbcode_text = "Do I " +  \
			"[color=" + rainbow_color.to_html(false) + "]quite my job[/color]" + \
			" or do I " + \
			"[color=" + commute_color.to_html(false) + "][shake rate=100.0 level=20.0]commute[/shake][/color]?"
		$DoYouWantToPlayLabel.parse_bbcode(bbcode_text)

func _input(event):
	if Input.is_action_just_pressed("ui_accept") or Input.is_action_just_pressed("pick_up"):
		#Don't let player skip the animation for last question
		#if not $DoYouWantToPlayLabel.visible:
		#	skip_pressed = true
		skip_pressed = true

func _on_game_start_button_pressed():
	emit_signal("button_start_pressed")

func _on_game_over_button_pressed():
	emit_signal("button_exit_pressed")
