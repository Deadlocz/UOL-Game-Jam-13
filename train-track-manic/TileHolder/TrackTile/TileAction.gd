extends Node2D

var tile_type:int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	tile_type = 1
	pass # Replace with function body.

func _set_tile(type: int) -> void:
	%TrackTypes.frame = tile_type;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_action_pressed() -> void:
	print("hi")
	#TODO add selection mode or use smt. else
	return
