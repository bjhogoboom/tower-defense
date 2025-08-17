@tool
class_name PriceTag
extends TextureRect

@onready var price_text: RichTextLabel = $CenterContainer/PriceText
@export var price: int = 100

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	price_text.text = str(price)
