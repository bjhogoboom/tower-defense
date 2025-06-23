class_name Turret
extends Node2D

var focused_enemy: Node2D
var bullet_scene = preload("res://bullet.tscn")
@onready var fire_rate = $FireRate
@onready var spawn_point = $SpawnPoint
@onready var focus_area: Area2D = $FocusArea
var mode: Mode = Mode.ACTIVE

enum Mode {PREVIEW, ACTIVE}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if mode == Mode.PREVIEW:
		global_position = get_global_mouse_position()
	
func _physics_process(delta: float) -> void:
	if !mode == Mode.ACTIVE: return

	if focused_enemy:
		point_at(focused_enemy.position)

func _on_focus_area_area_exited(area: Area2D) -> void:
	focused_enemy = null
	fire_rate.stop()

func _on_focus_area_area_entered(area: Area2D) -> void:
	if !mode == Mode.ACTIVE: return
	focus_on(area)

func focus_on(area: Area2D) -> void:
	focused_enemy = area
	fire_rate.start()

func _on_fire_rate_timeout() -> void:
	if focused_enemy:
		shoot_at(focused_enemy.position)

func point_at(point: Vector2):
	rotation = point.angle_to_point(position) + Vector2.UP.angle()

func shoot_at(point: Vector2):
	var bullet = bullet_scene.instantiate()
	bullet.direction = rotation + Vector2.UP.angle()
	bullet.spawn_position = spawn_point.global_position
	bullet.spawn_rotation = global_rotation
	get_parent().add_child(bullet)

func preview():
	mode = Mode.PREVIEW

func activate():
	var enemies_in_area = focus_area.get_overlapping_areas()
	if not enemies_in_area.is_empty():
		focus_on(enemies_in_area[0])
	mode = Mode.ACTIVE
