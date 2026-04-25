extends Node2D

var tile_type:int

# constructor for 
func _init(type:int) -> void:
	_set_tile(type)
	_set_logic(type)
	pass


func _set_tile(type: int) -> void:
	tile_type = type
	%TrackTypes.frame = tile_type;

func _set_logic(type: int):
	#TODO add logic depending on what is needed
	match(type):
		0:
			pass
		1:
			pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_action_pressed() -> void:
	print("hi")
	#TODO add selection mode or use smt. else
	return
