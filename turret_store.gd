extends VBoxContainer

signal turret_selected

# TODO: Make aware of the specific turret
func _on_button_pressed() -> void:
	turret_selected.emit()
