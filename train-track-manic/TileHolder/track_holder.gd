extends Node2D
@export_file("*.tscn") var tile_path

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var tile_scene = load("res://TileHolder/TrackTile/Tile.tscn")
	var tile_instance = tile_scene.instantiate()
	var tile_instance2 = tile_scene.instantiate()
	$ColorRect/Tile1.add_child(tile_instance)
	$ColorRect/Tile2.add_child(tile_instance2)
	
	pass
	 # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
