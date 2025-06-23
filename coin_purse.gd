class_name CoinPurse
extends Node

@onready var ui_layer: UILayer = $"../UILayer"

var gold: int = 0:
	set(value):
		gold = value
		ui_layer.set_gold(gold)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func add_gold(delta: int) -> void:
	gold += delta

func remove_gold(delta: int) -> void:
	gold -= delta
