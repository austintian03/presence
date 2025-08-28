
extends State

func enter():
	animations.play("idle_2")

func update(_delta: float) -> void:
	#if Input.get_axis("move_left", "move_right") != 0:
		#transitioned.emit(self, "walk")
	pass

func physics_update(_delta: float) -> void:
	if Input.get_axis("move_left", "move_right") != 0:
		if Input.is_action_pressed("sprint"):
			transitioned.emit(self, "run")
		else:
			transitioned.emit(self, "walk")
	
	if Input.is_action_just_pressed("jump"):
		transitioned.emit(self, "jump")
	
	if Input.is_action_just_pressed("hide"):
		transitioned.emit(self, "hide")
