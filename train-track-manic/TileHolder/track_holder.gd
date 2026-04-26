class_name Holder 
extends Node2D
@export_file("*.tscn") var tile_path

var childs: Array = []


func _ready() -> void:
	var tile_scene = load("res://TileHolder/SelectTile/Tile.tscn")
	var grid = $ColorRect/GridContainer
	
	for i in range(15):
		var map:Dictionary
		
		var tile_instance = tile_scene.instantiate() as SelectTile
		tile_instance.set_tile(i)
		tile_instance.set_times(2)
		
		map = {
			"key": i,
			"value": tile_instance
		}
		
		var target = grid.get_child(i)
		target.add_child(tile_instance)
		childs.append(map)
	
	#TODO set here the different tile types
	pass





# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
