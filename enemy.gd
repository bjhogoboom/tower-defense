class_name Enemy
extends Area2D

@export var max_health: float = 50.0
@export var speed: float = 30.0
@onready var progress_bar: ProgressBar = $HealthBar
@onready var navigation_agent: NavigationAgent2D = $NavigationAgent
var movement_target_position: Vector2 = Vector2(60.0,180.0)

var health: float

signal died(enemy: Enemy)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	health = max_health
	progress_bar.max_value = health
	navigation_agent.path_desired_distance = 4.0
	navigation_agent.target_desired_distance = 4.0
	on_health_changed()
	
	# Make sure to not await during _ready.
	actor_setup.call_deferred()
	
func actor_setup():
	# Wait for the first physics frame so the NavigationServer can sync.
	await get_tree().physics_frame

	# Now that the navigation map is no longer empty, set the movement target.
	set_movement_target(movement_target_position)
	
func set_movement_target(movement_target: Vector2):
	navigation_agent.target_position = movement_target

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	#position += Vector2.RIGHT * speed * delta
	if navigation_agent.is_navigation_finished():
		return

	var current_agent_position: Vector2 = global_position
	var next_path_position: Vector2 = navigation_agent.get_next_path_position()

	var direction = navigation_direction(current_agent_position, next_path_position)
	position += direction * speed * delta

func navigation_direction(current_agent_position: Vector2, next_path_position: Vector2) -> Vector2:
	return current_agent_position.direction_to(next_path_position)

func _on_area_entered(area: Area2D) -> void:
	area.queue_free()
	if area is Bullet:
		take_damage(area.damage)

func take_damage(damage: float) -> void:
	health -= damage
	on_health_changed()

func on_health_changed():
	progress_bar.value = health
	if health <= 0.0:
		died.emit(self)
		queue_free()
