@tool
class_name FocusArea
extends Area2D

@export var size: float = 1

var focus_queue: Array[Node2D]
var mode: Mode = Mode.ACTIVE

enum Mode {PREVIEW, ACTIVE}

signal added_to_queue(enemy: Enemy)
signal removed_from_queue(enemy: Enemy)

@onready var indicator: Indicator = $Indicator
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
const BASE_COLLISION_SHAPE_RADIUS = 60

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func focused_enemy() -> Node2D:
	if focus_queue.is_empty(): return null
	return focus_queue.front()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	indicator.size = size
	collision_shape_2d.shape.radius = BASE_COLLISION_SHAPE_RADIUS * size
	
func _physics_process(delta: float) -> void:
	pass

func _on_area_exited(area: Area2D) -> void:
	remove_from_focus_queue(area)
	#fire_rate.stop()

func _on_area_entered(area: Area2D) -> void:
	if !mode == Mode.ACTIVE: return
	add_to_focus_queue(area)

func add_to_focus_queue(area: Area2D) -> void:
	if area is Enemy:
		added_to_queue.emit(area)
		area.died.connect(_on_enemy_died)
	focus_queue.push_back(area)

func preview():
	mode = Mode.PREVIEW

func activate():
	var enemies_in_area = get_overlapping_areas()
	for enemy in enemies_in_area:
		add_to_focus_queue(enemy)
	mode = Mode.ACTIVE

func remove_from_focus_queue(enemy: Node2D):
	focus_queue.erase(enemy)
	removed_from_queue.emit(enemy)

func _on_enemy_died(enemy: Node2D):
	remove_from_focus_queue(enemy)
	
