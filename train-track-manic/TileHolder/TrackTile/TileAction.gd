extends Node2D


# constructor for setting the tile type
# func _init(type:int) -> void:
func _init() -> void:
	pass
	
func _ready() -> void:
	_set_logic(1)
	_set_tile(1)

func _set_tile(type: int) -> void:
	%TrackTypes.frame = type;
	_set_logic(type)

func _set_logic(type: int):
	#TODO add logic depending on what is needed
	match(type):
		0:
			pass
		1:
			pass


func _on_action_pressed() -> void:
	print("hi")
	#TODO add selection mode or use smt. else
	return
