extends State

func enter():
	animations.play("walk")
	
func physics_update(delta):
	# read player's current velocity
	var velocity = parent.velocity
	var input_direction = Vector2(Input.get_axis("move_left", "move_right"), 0)
	
	# apply changes to velocity
	velocity = velocity.move_toward(input_direction*parent.SPEED/2, 50 * delta * parent.SPEED/2)
	
	if input_direction.x && sign(input_direction.x) != sign(velocity.x):
		velocity.x *= 0.75
	
	parent.velocity.x = velocity.x
	
	# check for any state changes
	if velocity.x == 0 and !(Input.is_action_just_pressed("move_left") or Input.is_action_just_pressed("move_right")):
		transitioned.emit(self, "idle")
	
	if Input.is_action_pressed("sprint"):
		transitioned.emit(self, "run")
		
	if Input.is_action_just_pressed("jump"):
		transitioned.emit(self, "jump")
	
	if Input.is_action_just_pressed("hide") and parent.is_hidable:
		transitioned.emit(self, "hide")
