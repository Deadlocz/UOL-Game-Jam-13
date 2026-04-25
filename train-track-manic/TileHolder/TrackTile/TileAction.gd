extends Sprite2D

var tile_type:int
@export var rect: Rect2
@export var level: Node2D

# constructor for setting the tile type
# func _init(type:int) -> void:
func _init() -> void:
	pass
	
func _ready() -> void:
	pass

func set_tile(type: int) -> void:
	tile_type = type
	%TrackTypes.frame = type;
	set_logic(type)

func set_logic(type: int):
	#TODO add logic depending on what is needed
	match(type):
		0:
			pass
		1:
			pass

func get_global_rect():
	return Rect2(
		global_position - rect.size / 2,
		rect.size
	)
	
func set_on_place():
	modulate.a = 1


func _on_area_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
			var Tile = preload("res://TileHolder/TrackTile/Tile.tscn").instantiate()
			Tile.set_tile(tile_type)
			Event.create_new_tile.emit(Tile)
