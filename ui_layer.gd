class_name UILayer
extends CanvasLayer

@onready var gold_label: Label = $"UI Margin/UI/GoldLabel"

signal turret_selected(turret: TurretResource)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func set_gold(gold: int) -> void:
	gold_label.set_text("Gold: " + str(gold))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _on_turret_store_turret_selected(turret: TurretResource) -> void:
	print("TURRET STORE TURRET SELECTED")
	turret_selected.emit(turret)
