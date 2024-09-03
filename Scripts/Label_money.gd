extends RichTextLabel

func _ready():
	var rng = RandomNumberGenerator.new()
	var rand_number = rng.randf_range(-500.0, 1000.0)
	text = "Money in my Bank: $" + "%0.2f" %rand_number
