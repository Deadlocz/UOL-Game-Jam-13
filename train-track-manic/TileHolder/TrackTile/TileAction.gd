class_name TrackTile
extends Sprite2D

var tile_type: int
@export var rect: Rect2
@export var level: Node2D
@export var is_placed2: bool = false

const SOURCE_ID := 0

func set_tile(type: int) -> void:
	tile_type = type
	var y := type / 4
	var x := type % 4
	%TileMapLayer.set_cell(Vector2i(0, 0), SOURCE_ID, Vector2i(x, y), 0)

func get_global_rect() -> Rect2:
	return Rect2(
		global_position - rect.size / 2,
		rect.size
	)

func set_on_place():
	is_placed2 = true
	modulate.a = 1
	set_as_top_level(false)

	if has_node("Area2D"):
		$Area2D.input_pickable = false
		$Area2D.monitoring = false
		$Area2D.monitorable = false

func _on_area_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if is_placed2:
		return

	if event is InputEventMouseButton \
	and event.button_index == MOUSE_BUTTON_LEFT \
	and event.is_pressed():
		is_placed2 = true
		Event.create_new_tile.emit(self)
