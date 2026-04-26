@tool
class_name Station
extends Node2D


const SLOW_TRAIN_SCENE = preload("res://Actors/Train/SlowTrain.tscn")
const NORMAL_TRAIN_SCENE = preload("res://Actors/Train/TrainYellow.tscn") # Das macht sinn
const FAST_TRAIN_SCENE = preload("res://Actors/Train/FastTrain.tscn")


## Label is used to find this station as a target
@export var label: String = "A":
	get:
		return label
	set(value):
		label = value
		%Label.text = label

## Assign targets here, each target spawns a train
@export var trains: Array[TrainSchedule]


func _ready() -> void:
	Event.start_trains.connect(on_start_trains)

## main function that spawns trains
func on_start_trains() -> void:
	for schedule: TrainSchedule in trains:
		var target := get_target_station(schedule.target)
		if not target:
			push_error("target station not found")
			continue
		
		await get_tree().create_timer(schedule.start_delay).timeout
		var train = create_train(schedule.train_type)
		train.target = target
		add_child(train)

func create_train(type: Enum.TrainType) -> Train:
	var train: Train
	match type:
		Enum.TrainType.SLOW:
			train = SLOW_TRAIN_SCENE.instantiate()
		
		Enum.TrainType.NORMAL:
			train = NORMAL_TRAIN_SCENE.instantiate()
		
		Enum.TrainType.FAST:
			train = FAST_TRAIN_SCENE.instantiate()
		
		_:
			push_error("Wrong train type")
			return null
	
	train.origin_station_label = label
	return train


## finds station by looking up every station in group
func get_target_station(target_label: String) -> Station:
	var stations := get_tree().get_nodes_in_group("Station")
	for station: Station in stations:
		if station.label == target_label:
			return station
	
	return null


func _on_train_detection_area_body_entered(body: Node2D) -> void:
	if body is Train:
		var train := body as Train
		if train.origin_station_label == label:
			return
		body.queue_free()
