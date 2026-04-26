class_name Train
extends CharacterBody2D

var running = true

@onready var nav: NavigationAgent2D = $NavigationAgent2D

@export var target: Node2D
@export_range(50, 200) var speed: int = 50

var origin_station_label: String

func _ready() -> void:
	Event.start_trains.connect(_on_train_button_pressed)
	Event.stop_trains.connect(_on_train_button_pressed)

# set le movement target
func set_movement_target(movement_target: Vector2):
	nav.target_position = movement_target

func _physics_process(delta: float) -> void:
	if running:
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
	
	# get the velocity and change frames depending on x direction

	if (abs(velocity.x) < abs(velocity.y)):
		%AnimatedSprite2D.frame = 0
	else:
		%AnimatedSprite2D.frame = 1
		
	# do la movement
	move_and_slide()

func _velocity_computed(safe_velocity: Vector2) -> void:
	velocity = safe_velocity
	
func _on_train_button_pressed() -> void:
	if running:
		queue_free()
	running = !running
