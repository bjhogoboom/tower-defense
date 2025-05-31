extends Node2D

var turret_scene = preload("res://turret.tscn")
var picked_up: Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT:
		var new_turret = turret_scene.instantiate()
		new_turret.position = get_global_mouse_position()
		add_child(new_turret)
