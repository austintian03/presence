class_name PlayerStateMachine
extends StateMachine

var jump_buffer: float = 3.0

func _ready():
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.parent = parent
			child.animations = animations
			child.transitioned.connect(on_child_transition)
			
	if initial_state:
		initial_state.enter('')
		current_state = initial_state
		
func on_child_transition(state: State, new_state_name: String):
	if state != current_state:
		return
	
	var new_state = states.get(new_state_name.to_lower())
	if !new_state:
		return
	
	if current_state:
		current_state.exit()
	
	new_state.enter(state.name.to_lower())
	current_state = new_state
	
	state_entered.emit(new_state_name)
