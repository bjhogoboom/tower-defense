@tool
class_name Indicator
extends Node2D

@onready var mask: Sprite2D = $Mask
@onready var texture: Sprite2D = $Mask/Texture
const MASK_DIAMETER = 1200 # px
const TILE_SCALE = 10
const STARTING_SCALE = 0.1

@export var size: float = 100:
	set(value):
		size = value

# Called when the node enters the scene tree for the first time.
func _process(_delta: float) -> void:
	apply_size()

func apply_size() -> void:
	if not (mask && texture): return
	mask.scale = Vector2(1,1) * size * STARTING_SCALE
	texture.scale = Vector2(1, 1) * TILE_SCALE / size
	texture.region_rect.size = Vector2(MASK_DIAMETER, MASK_DIAMETER) / TILE_SCALE * size
