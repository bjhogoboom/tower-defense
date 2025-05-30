extends Area2D

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
	var velocity = Vector2(speed, 0).rotated(direction)
	position += velocity * delta


func _on_body_entered(body: Node2D) -> void:
	print("bullet body entered")
