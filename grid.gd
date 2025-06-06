extends Node2D

var turret_scene = preload("res://turret.tscn")
var selected_turret: Turret

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _unhandled_input(event: InputEvent) -> void:
	if should_place_turret(event):
		selected_turret.activate()
		selected_turret = null

func should_place_turret(event: InputEvent) -> bool:
	return event is InputEventMouseButton \
		and event.is_pressed() \
		and event.button_index == MOUSE_BUTTON_LEFT \
		and selected_turret != null

func _on_turret_selector_pressed() -> void:
	selected_turret = turret_scene.instantiate()
	selected_turret.preview()
	add_child(selected_turret)
