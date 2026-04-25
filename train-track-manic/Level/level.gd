extends Node2D

@onready var grid: GridContainer = $Grid

const OBJECT = preload("res://TileHolder/TrackTile/Tile.tscn")

var gridSize: Vector2
var object: TrackTile
var targetCell
var objectCells: Array[GridCell]
var isValid = false

func _ready() -> void:
	gridSize = Vector2(grid.cellWidth, grid.cellHeight)
	Event.create_new_tile.connect(create_new)
	Event.move_tile.connect(create_new)

func _input(event):
	# showcase only
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed and isValid:
			_place_placement()


func create_new(object1):
	var newPlacement = object1
	add_child(newPlacement)
	newPlacement.global_position = get_global_mouse_position()
	object = newPlacement

func _on_grid_gui_input(event):
	if event is InputEventMouseMotion:
		if not object: return
		
		var mousePosition = get_global_mouse_position()
		var newTargetCell = _get_target_cell(mousePosition)
		
		if newTargetCell and newTargetCell != targetCell:
			targetCell = newTargetCell
			object.global_position = targetCell.global_position + object.rect.size/2
			
			_reset_highlight()
			objectCells = _get_object_cells()
			isValid = _check_and_hightlight_cells()

func _get_target_cell(targetPosition) -> GridCell:
	for child:Control in grid.get_children():
		if child.get_global_rect().has_point(targetPosition):
			return child
	return null

func _reset_highlight():
	for child:Control in grid.get_children():
		child.change_color(Color(0.502, 0.502, 0.502, 0.0))

func _get_object_cells() -> Array[GridCell]:
	var cells: Array[GridCell] = []

	for child:GridCell in grid.get_children():
		if child.get_global_rect().intersects(object.get_global_rect()):
			cells.append(child)
			
	return cells

func _check_and_hightlight_cells():
	isValid = true
	var objectCellCount = (object.rect.size.x / gridSize.x) * (object.rect.size.y / gridSize.y)
	
	if objectCellCount != objectCells.size(): 
		isValid = false
	
	for cell in objectCells:
		if cell.full: 
			isValid = false
			cell.change_color(Color.RED)
		else:
			cell.change_color(Color.GREEN)
	
	return isValid

# komment
func _place_placement():
	object.set_on_place()
	object = null
	isValid = false
	
	for cell in objectCells:
		cell.full = true
	
	_reset_highlight()
