extends VBoxContainer

signal turret_selected(turret: TurretResource)

func _ready() -> void:
	for child in get_children():
		print("CHILD")
		if child is TurretButton:
			child.turret_button_pressed.connect(_on_turret_button_pressed)

func _on_turret_button_pressed(turret: TurretResource) -> void:
	print("TURRET BUTTON PRESSED")
	turret_selected.emit(turret)
