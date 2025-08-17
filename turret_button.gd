class_name TurretButton
extends Button

signal turret_button_pressed

@export var turret: TurretResource
@onready var price_tag: PriceTag = $PriceTag
@onready var turret_icon: TextureRect = $TurretIcon

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	price_tag.price = turret.price
	turret_icon.texture = turret.sprite
	turret_icon.modulate = turret.color
	pressed.connect(_on_button_pressed)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _on_button_pressed():
	print("BUTTON PRESSED")
	turret_button_pressed.emit(turret)
