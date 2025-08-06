extends Node2D

var turret_scene = preload("res://turret.tscn")
var selected_turret: Turret
var turret_cost: int = 25
@onready var coin_purse: CoinPurse = $CoinPurse

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _unhandled_input(event: InputEvent) -> void:
	if should_place_turret(event):
		coin_purse.remove_gold(turret_cost)
		selected_turret.activate()
		selected_turret = null
	if should_clear_turret(event):
		selected_turret.queue_free()
		selected_turret = null

func should_clear_turret(event: InputEvent) -> bool:
	return selected_turret != null && event.is_action_pressed("ui_cancel")

func should_place_turret(event: InputEvent) -> bool:
	return event is InputEventMouseButton \
		and event.is_pressed() \
		and event.button_index == MOUSE_BUTTON_LEFT \
		and selected_turret != null \
		and coin_purse.gold >= turret_cost

func _on_ui_layer_turret_selected() -> void:
	if selected_turret != null:
		return
	selected_turret = turret_scene.instantiate()
	selected_turret.request_ready()
	selected_turret.preview()
	add_child(selected_turret)
