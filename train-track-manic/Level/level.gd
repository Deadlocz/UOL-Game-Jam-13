extends Node2D

@onready var grid: GridContainer = $Grid

const OBJECT = preload("res://TileHolder/TrackTile/Tile.tscn")

var object: TrackTile = null
var targetCell: GridCell = null
var objectCells: Array[GridCell] = []
var isValid := false


func _ready() -> void:
	Event.create_new_tile.connect(create_new)
	Event.move_tile.connect(create_new)
	fill_start_cells()

func fill_start_cells():
	var cells = grid.get_children()
	var columns = 5
	# Erste Reihe (Zeile 0) füllen: Indizes 0 bis columns-1
	
	for i in range(columns):
		var cell = cells[i] as GridCell
		if cell:
			cell.full = true
			cell.change_color(Color.RED)

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed and isValid:
			_place_placement()


func create_new(object1):
	if object1.get_parent():
		object1.get_parent().remove_child(object1)
	add_child(object1)
	object1.global_position = get_global_mouse_position()
	object = object1


func _on_grid_gui_input(event):
	if event is InputEventMouseMotion:
		if not object:
			return
		var mouse_pos = get_global_mouse_position()
		var new_cell = _get_target_cell(mouse_pos)
		if new_cell:
			targetCell = new_cell
			object.global_position = targetCell.global_position
			_reset_highlight()
			objectCells = _get_object_cells()
			_check_and_highlight_cells()



func _get_target_cell(pos) -> GridCell:
	for child: GridCell in grid.get_children():
		if child.get_global_rect().has_point(pos):
			return child
	return null



func _get_object_cells() -> Array[GridCell]:
	var cells: Array[GridCell] = []
	if targetCell:
		cells.append(targetCell)
	return cells

func _check_and_highlight_cells():
	if not targetCell:
		isValid = false
		return false
	isValid = not targetCell.full
	if targetCell.full:
		targetCell.change_color(Color.RED)
	else:
		targetCell.change_color(Color.GREEN)
	return isValid



func _reset_highlight():
	for child: GridCell in grid.get_children():
		child.change_color(Color(0.5, 0.5, 0.5, 0.0))



func _place_placement():
	if not object or not targetCell:
		return
	object.set_on_place()
	targetCell.full = true
	object = null
	targetCell = null
	objectCells.clear()
	isValid = false
	_reset_highlight()
