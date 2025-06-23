class_name Turret
extends Node2D

var focus_queue: Array[Node2D]
var bullet_scene = preload("res://bullet.tscn")
@onready var fire_rate: Timer = $FireRate
@onready var spawn_point = $SpawnPoint
@onready var focus_area: Area2D = $FocusArea
var mode: Mode = Mode.ACTIVE

enum Mode {PREVIEW, ACTIVE}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func focused_enemy() -> Node2D:
	if focus_queue.is_empty(): return null
	return focus_queue.front()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if mode == Mode.PREVIEW:
		global_position = get_global_mouse_position()
	
func _physics_process(delta: float) -> void:
	if !mode == Mode.ACTIVE: return

	if focused_enemy():
		point_at(focused_enemy().global_position)

func _on_focus_area_area_exited(area: Area2D) -> void:
	remove_from_focus_queue(area)
	fire_rate.stop()

func _on_focus_area_area_entered(area: Area2D) -> void:
	if !mode == Mode.ACTIVE: return
	add_to_focus_queue(area)

func add_to_focus_queue(area: Area2D) -> void:
	if area is Enemy:
		area.died.connect(_on_enemy_died)
	focus_queue.push_back(area)
	fire_rate.start()

func _on_fire_rate_timeout() -> void:
	if focused_enemy():
		shoot()

func point_at(point: Vector2):
	rotation = point.angle_to_point(position) + Vector2.UP.angle()

func shoot():
	var bullet = bullet_scene.instantiate()
	bullet.direction = rotation + Vector2.UP.angle()
	bullet.spawn_position = spawn_point.global_position
	bullet.spawn_rotation = global_rotation
	get_parent().add_child(bullet)

func preview():
	mode = Mode.PREVIEW

func activate():
	var enemies_in_area = focus_area.get_overlapping_areas()
	for enemy in enemies_in_area:
		add_to_focus_queue(enemy)
	mode = Mode.ACTIVE

func remove_from_focus_queue(enemy: Node2D):
	focus_queue.erase(enemy)
	if focus_queue.is_empty():
		fire_rate.stop()
	
func _on_enemy_died(enemy: Node2D):
	remove_from_focus_queue(enemy)
	
