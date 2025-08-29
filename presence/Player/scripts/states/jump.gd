extends State

func enter():
	parent.velocity.y = parent.JUMP_VELOCITY
	animations.play("jump")

func physics_update(delta: float):
	var movement = Input.get_axis("move_left", "move_right") * parent.SPEED
	parent.velocity.x = movement
	
	# add more velocity at peak of jump 
	if parent.velocity.y > 0 and not parent.is_on_floor():
		parent.velocity.y += 50*delta
	
	# transition back to floor
	if parent.is_on_floor():
		transitioned.emit(self, "idle")
