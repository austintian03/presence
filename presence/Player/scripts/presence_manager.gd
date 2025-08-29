class_name PresenceManager
extends Node

@export_group("Presence Values")
@export var max_presence: float = 100
@export var initial_presence: float = 0
@export var base_rate: float = 1.0
var p_rate: float

@onready var parent: Node = get_owner()

func _ready() -> void:
	p_rate = base_rate
	parent.presence_lvl = initial_presence

func _process(delta: float) -> void:
	parent.presence_lvl = min(parent.presence_lvl + p_rate*delta, max_presence)
	
func set_p_rate(val: float) -> void:
	p_rate = val

func update_presence(state_name: String) -> void:
	match state_name:
		"idle":
			set_p_rate(base_rate)
		"walk":
			set_p_rate(2.0)
		"run":
			set_p_rate(5.0)
		"jump":
			set_p_rate(3.0)
		"hide":
			set_p_rate(-5.0)
		
