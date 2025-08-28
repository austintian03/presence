extends State

func enter():
	parent.velocity.y = parent.JUMP_VELOCITY
	animations.play("jump")

func physics_update(_delta: float):
	
	var movement = Input.get_axis("move_left", "move_right") * parent.SPEED
	parent.velocity.x = movement
	
	if parent.is_on_floor() and parent.velocity.y > 0:
		transitioned.emit(self, "idle")
