class_name TurretResource
extends Resource

@export var damage: int
@export var fire_delay: float
@export var price: int
@export var color: Color


# Make sure that every parameter has a default value.
# Otherwise, there will be problems with creating and editing
# your resource via the inspector.
func _init(p_damage = 10, p_fire_delay = 0.5, p_price = 50, p_color = null):
	damage = p_damage
	fire_delay = p_fire_delay
	price = p_price
	color = p_color
