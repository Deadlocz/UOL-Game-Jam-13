extends CharacterBody2D

var speed = 500.0

@onready var nav: NavigationAgent2D = $NavigationAgent2D
@export var target: Node2D

# set le movement target
func set_movement_target(movement_target: Vector2):
	nav.target_position = movement_target

func _physics_process(delta: float) -> void:
	_move_towards_station() # move towards le station

# move towards la station
func _move_towards_station() -> void:
	# update the station position
	set_movement_target(target.position)
	
	# if we're at the target, stop
	if nav.is_navigation_finished():
		return 
	
	# get pathfinding information
	var current_agent_position: Vector2 = global_position
	var next_path_position: Vector2 = nav.get_next_path_position()
	var new_velocity = current_agent_position.direction_to(next_path_position) * speed

	# calculate the new velocity if avoidance is enabled
	if nav.avoidance_enabled:
		nav.set_velocity(new_velocity)
	else:
		_velocity_computed(new_velocity)
	
	# do la movement
	move_and_slide()

func _velocity_computed(safe_velocity: Vector2) -> void:
	velocity = safe_velocity
