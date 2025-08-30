class_name Perceiver
extends CharacterBody2D

signal player_detected

@onready var f_sight_area: SightArea = $FSightArea
@onready var animations: AnimatedSprite2D = $AnimatedSprite2d
#@onready var state_machine: StateMachine = $StateMachine

@export var patrol_radius: float = 90
@export var speed: float = 30
@export var movement_direction: Vector2 = Vector2.LEFT

var velocity_vector: Vector2
var front_pos: Vector2
var initial_pos: Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animations.play("default")
	apply_scale(Vector2(-1,1))
	
	initial_pos = position
	front_pos = initial_pos + movement_direction * patrol_radius
	f_sight_area.player_detected.connect(on_player_detected)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	velocity_vector = speed * movement_direction * delta
	if position >= initial_pos:
		velocity = velocity_vector
		apply_scale(Vector2(-1,1))
	elif position <= front_pos:
		velocity = -velocity_vector
		apply_scale(Vector2(-1,1))
	position += velocity

func on_player_detected(is_perceiving: bool) -> void:
	player_detected.emit(is_perceiving)
	
