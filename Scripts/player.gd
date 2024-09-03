extends CharacterBody2D

const NORMAL_SPEED = 100.0
var speed = 100.0
const JUMP_VELOCITY = -100.0 ####This game will not include jumping (unless it's an ability)

var is_touching_door = false
signal entered_office
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("walk_left", "walk_right")
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
				
	move_and_slide()
	


func _input(event):
	if Input.is_action_just_pressed("walk_right"):
		$Sprite.flip_h = false
		$AnimationPlayer.play("walk_right")
	elif Input.is_action_just_pressed("walk_left"):
		$Sprite.flip_h = true
		$AnimationPlayer.play("walk_right")
	
	if not Input.is_anything_pressed():
		$AnimationPlayer.play("stationary")
	
	if event.is_action_pressed("walk_up") and is_touching_door:
		print("Task Complete!")
		entered_door()

func entered_door():
	emit_signal("entered_office")
