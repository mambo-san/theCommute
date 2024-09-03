extends Container

var task_list = []
# Called when the node enters the scene tree for the first time.
func _ready():
	task_list = [
		"Go to the office.",
		"Don't be late.",
		"Don't smell like dog poop.",
		"Bring your A-game!",
		"Show commitment.",
		"Survive till pay day.", # day 6
		"", "", "", "", "","", "", "", "", "", # day 16
		"Save Money",
		"", "", "", "", "", #day 22
		"Get Promoted",
		"", "", "", "", "", #day 28
		"Win the rat race", # day 30
		"", "", "", "", "", #day 35
	]
	print("YOLO HUD ready")

func loadTasks(num_day):
	for child in get_children():
		child.queue_free()
	var pos_y = 0
	var max_task = clampi(num_day, 0, task_list.size())
	for task_index in range(max_task):
		var task_checkbox = CheckBox.new()
		var new_mission_text = task_list[task_index]
		if new_mission_text:
			task_checkbox.text = task_list[task_index]
			task_checkbox.set_position(Vector2(0,pos_y))
			task_checkbox.mouse_filter = Control.MOUSE_FILTER_IGNORE
			add_child(task_checkbox)
			pos_y += 25 
	if num_day > 50:
		task_list.append("What's left is what's right...")
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
