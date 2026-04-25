extends Node

@onready var label = $Label

var toggle = false

# Niklas sagt der Code seie perfekt und er liebe ihn <3
func _pressed() -> void:
	toggle = !toggle
	if toggle:
		label.text = str("Stop Train")
	else:
		label.text = str("Start Train")
