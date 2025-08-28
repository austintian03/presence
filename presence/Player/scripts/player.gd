extends CharacterBody2D

const SPEED = 100
const JUMP_VELOCITY = -200

@onready var animations: AnimatedSprite2D = $AnimatedSprite2D
@onready var state_machine: Node = $StateMachine

func _physics_process(delta: float) -> void:
	velocity += get_gravity() * delta
	
	state_machine._physics_process(delta)
	
	# flip animation depending on horizontal velocity
	if velocity.x > 0:
		animations.flip_h = false
	elif velocity.x < 0:
		animations.flip_h = true

	move_and_slide()
