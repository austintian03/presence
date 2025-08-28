extends State

@onready var timer: Timer = $Timer

func enter() -> void:
	# TODO: add code to "hide presence"
	timer.start()
	animations.play("hide")

func exit() -> void:
	# TODO: add code to undo "hide presence"
	timer.stop()
	
func update(_delta: float) -> void:
	pass

func physics_update(_delta: float) -> void:
	if Input.get_axis("move_left", "move_right"):
		if Input.is_action_pressed("sprint"):
			transitioned.emit(self, "run")
		else:
			transitioned.emit(self, "walk")
	
	if Input.is_action_just_pressed("jump"):
		transitioned.emit(self, "jump")


func _on_timer_timeout() -> void:
	transitioned.emit(self, "idle")
