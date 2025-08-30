class_name Player
extends CharacterBody2D

@export_group("Movement Values")
@export var SPEED: float = 100
@export var AIR_SPEED: float = 125
@export var JUMP_VELOCITY: float = -300
var is_hidable: bool = true

@onready var animations: AnimatedSprite2D = $AnimatedSprite2D
@onready var state_machine: PlayerStateMachine = $StateMachine
@onready var presence_manager: PresenceManager = $PresenceManager
@onready var presence_label: Label = $PresenceLabel

func _ready() -> void:
	state_machine.state_entered.connect(on_state_entered)
	

func _process(_delta: float) -> void:
	#presence_manager._process(delta)
	presence_label.text = str(int(presence_manager.presence_lvl))

func _physics_process(delta: float) -> void:
	velocity += get_gravity() * delta
	
	state_machine._physics_process(delta)
	
	# flip animation depending on horizontal velocity
	if velocity.x > 0:
		animations.flip_h = false
	elif velocity.x < 0:
		animations.flip_h = true

	move_and_slide()

func on_state_entered(state_name: String) -> void:
	presence_manager.update_presence(state_name)
