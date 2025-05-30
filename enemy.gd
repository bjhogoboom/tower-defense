class_name Enemy
extends Node2D

@export var max_health: float = 50.0
@export var speed: float = 30.0
@onready var progress_bar: ProgressBar = $ProgressBar
var health: float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	health = max_health
	progress_bar.max_value = health
	on_health_changed()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	position += Vector2.RIGHT * speed * delta

func _on_area_entered(area: Area2D) -> void:
	print("AREA ENTERED")
	area.queue_free()
	take_damage(10.0)

func take_damage(damage: float) -> void:
	health -= damage
	on_health_changed()

func on_health_changed():
	progress_bar.value = health
	if health <= 0.0:
		queue_free()
