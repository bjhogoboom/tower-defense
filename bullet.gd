extends CharacterBody2D

@export var speed = 300.0
var spawn_position: Vector2
var spawn_rotation: float
var direction: float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	global_position = spawn_position
	global_rotation = spawn_rotation

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	velocity = Vector2(speed, 0).rotated(direction)
	move_and_slide()
