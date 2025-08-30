extends State

var jump_was_released: bool

func enter(prev_state: String):
	jump_was_released = false
	parent.velocity.y = parent.JUMP_VELOCITY
	animations.play("jump")

func physics_update(delta: float):
	var movement = Input.get_axis("move_left", "move_right") * parent.AIR_SPEED
	parent.velocity.x = movement
	
	# add more velocity at peak of jump 
	if parent.velocity.y >= 0 and not parent.is_on_floor():
		parent.velocity.y += 100*delta
	
	
	if Input.is_action_just_released("jump") and not jump_was_released:
		jump_was_released = true
		if parent.velocity.y < 0:
			parent.velocity.y = parent.velocity.y/2
		
	# transition back to floor
	if parent.is_on_floor() and parent.velocity.y > 0:
		transitioned.emit(self, "idle")
