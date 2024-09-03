extends RichTextLabel

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#Display time since game started to represent player's time wasted. 
	text = "Time wasted: " + str(Time.get_ticks_usec()/1000000) + " seconds"
