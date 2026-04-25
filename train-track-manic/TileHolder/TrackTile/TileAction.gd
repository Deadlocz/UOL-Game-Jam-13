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
	%TrackTypes.frame = type;
	set_logic(type)

func set_logic(type: int):
	#TODO add logic depending on what is needed
	match(type):
		0:
			pass
		1:
			pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func get_global_rect():
	return Rect2(
		global_position - rect.size / 2,
		rect.size
	)
	
func set_on_place():
	modulate.a = 1


func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		print("clicked")
		Event.create_new_tile.emit(preload("res://TileHolder/TrackTile/Tile.tscn"))
