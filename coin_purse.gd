class_name CoinPurse
extends Node

@onready var ui_layer: UILayer = $"../UILayer"

@export var gold: int = 0:
	set(value):
		gold = value
		if not ui_layer: return
		ui_layer.set_gold(gold)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ui_layer.set_gold(gold)
	pass # Replace with function body.

func add_gold(delta: int) -> void:
	gold += delta

func remove_gold(delta: int) -> void:
	gold -= delta
