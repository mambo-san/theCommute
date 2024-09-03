extends Node2D

var player;

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_node("../Player")
	if player == null:
		print("Error - Game having existential crisis: Can't find player")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_body_exited(body):
	player.is_touching_door = false


func _on_area_2d_body_entered(body):
	player.is_touching_door = true
	if player.speed > 200:
		player.entered_door()
