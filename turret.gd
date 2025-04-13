extends Node2D

var focused_enemy: Node2D
var bullet_scene = preload("res://bullet.tscn")
@onready var fire_rate = $FireRate
@onready var spawn_point = $SpawnPoint

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _physics_process(delta: float) -> void:
	if focused_enemy:
		point_at(focused_enemy.position)

func _on_focus_area_area_exited(area: Area2D) -> void:
	focused_enemy = null
	fire_rate.stop()

func _on_focus_area_area_entered(area: Area2D) -> void:
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
