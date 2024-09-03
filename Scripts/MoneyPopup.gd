extends RichTextLabel

var alpha = 1.0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if visible:
		position.y -= 20 * delta
		
		if alpha > 0.0:
			alpha -= 0.5 * delta
			modulate.a = alpha
		else:
			queue_free()

func set_amount(amount):
	var bbcode_text = "[color=#0AD232]++$" + "%0.2f" %amount + "[/color]"
	parse_bbcode(bbcode_text)
