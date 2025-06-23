extends Node2D

@export var enemy_scene: PackedScene
@export var spawn_delay: float = 5
@onready var timer: Timer = $Timer
@onready var preview_sprite: Sprite2D = $Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#preview_sprite.visible = false
	print("Delay " + str(spawn_delay))
	timer.timeout.connect(_on_timer_timeout)
	timer.set_wait_time(spawn_delay)
	timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func spawn() -> void:
	add_child(enemy_scene.instantiate())
	

func _on_timer_timeout() -> void:
	spawn()
