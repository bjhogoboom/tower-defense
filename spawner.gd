extends Node2D

@export var enemy_scene: PackedScene
@export var spawn_delay: float = 5
@export var coin_purse: CoinPurse
@export var goal: Node2D
@export var spawn_on_ready = true
@onready var timer: Timer = $Timer
@onready var preview_sprite: Sprite2D = $Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#preview_sprite.visible = false
	print("Delay " + str(spawn_delay))
	if spawn_on_ready:
		spawn()
	timer.timeout.connect(_on_timer_timeout)
	timer.set_wait_time(spawn_delay)
	timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func spawn() -> void:
	var enemy: Enemy = enemy_scene.instantiate()
	enemy.movement_target_position = goal.position
	add_child(enemy)
	enemy.died.connect(_on_enemy_died)
	
func _on_enemy_died(enemy: Enemy) -> void:
	coin_purse.add_gold(10)

func _on_timer_timeout() -> void:
	spawn()
