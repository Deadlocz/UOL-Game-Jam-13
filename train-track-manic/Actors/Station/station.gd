class_name Station
extends Node2D

@export var label: String = "A"

## Assign targets here, each target spawns a train
@export var trains: Array[TrainSchedule]


func _ready() -> void:
	Event.start_trains.connect(on_start_trains)


func on_start_trains() -> void:
	pass
