extends Control

@export var label_list: Array[RichTextLabel] = []
var label_index = 0
#fade-in animation
var fade_speed = 0.3
var alpha = 0.0
var color_change_speed: float = 0.3
var hue = 0.0


# Called when the node enters the scene tree for the first time.
func _ready():
	for child in get_children():
		child.visible = false
		child.modulate.a = 0
		print(child)

func set_number_of_days_label(days_in_office):
	days_in_office -= 1 #Exclude the day of jump 
	$Label_days.text = "I went to the office: " + str(days_in_office) + "days"

func set_money_in_bank_label(money_in_bank):
	$Label_money.text = "Money in my bank: $" + "%0.2f" %money_in_bank	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if visible:
		if label_index < label_list.size():
			
			var currently_displayed = label_list[label_index]
			if not currently_displayed.visible:
				currently_displayed.modulate.a = 0
				currently_displayed.visible = true
			elif currently_displayed.visible:
				if alpha < 1.0:
					alpha += fade_speed * delta
					alpha = clamp(alpha, 0.0, 1.0)
					currently_displayed.modulate.a = alpha	
				else:
					label_index += 1
					alpha = 0.0
		#Rainbow prep
		hue += color_change_speed * delta
		hue = wrapf(hue, 0.0, 1.0)  # Ensure hue stays within 0.0 to 1.0 range
		var rainbow_color = Color.from_hsv(hue, 1, 1)
		var bbcode_text = "[color=" + rainbow_color.to_html(false) + "]Commute Over[/color]"
		$Label_congrats.parse_bbcode(bbcode_text)
		
