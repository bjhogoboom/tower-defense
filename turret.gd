class_name Turret
extends Node2D

var bullet_scene = preload("res://bullet.tscn")
@export var turret: TurretResource
@onready var fire_rate: Timer = $FireRate
@onready var bullet_spawn_point = $BulletSpawnPoint
@onready var focus_area: FocusArea = $FocusArea
@onready var sprite: Sprite2D = $Sprite
var mode: Mode = Mode.ACTIVE

enum Mode {PREVIEW, ACTIVE}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	fire_rate.wait_time = turret.fire_delay
	focus_area.size = turret.focus_radius
	sprite.modulate = turret.color
	if mode == Mode.PREVIEW:
		focus_area.preview()
	else:
		focus_area.visible = false

static func new_turret(p_turret: TurretResource = null) -> Turret:
	var scene: PackedScene = load("res://turret.tscn")
	var new_turret_scene = scene.instantiate()
	new_turret_scene.turret = p_turret
	return new_turret_scene

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if mode == Mode.PREVIEW:
		global_position = get_global_mouse_position()
	
func _physics_process(delta: float) -> void:
	if !mode == Mode.ACTIVE: return

	if focus_area.focused_enemy():
		point_at(focus_area.focused_enemy().global_position)
		
func point_at(point: Vector2):
	rotation = point.angle_to_point(position) + Vector2.UP.angle()

func shoot():
	var bullet = bullet_scene.instantiate()
	bullet.direction = rotation + Vector2.UP.angle()
	bullet.spawn_position = bullet_spawn_point.global_position
	bullet.spawn_rotation = global_rotation
	bullet.damage = turret.damage
	get_parent().add_child(bullet)

func preview():
	mode = Mode.PREVIEW
	if !is_node_ready():
		return
	focus_area.preview()

func activate():
	focus_area.activate()
	mode = Mode.ACTIVE

func _on_focus_area_removed_from_queue(enemy: Enemy):
	if focus_area.focus_queue.is_empty():
		fire_rate.stop()
		
func _on_focus_area_added_to_queue(enemy: Enemy) -> void:
	fire_rate.start()

func _on_fire_rate_timeout() -> void:
	if focus_area.focused_enemy():
		shoot()

func _on_turret_area_mouse_entered() -> void:
	focus_area.visible = true
	
func _on_turret_area_mouse_exited() -> void:
	focus_area.visible = false

	
