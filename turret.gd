extends Node2D

var focused_enemy: Node2D

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

func _on_focus_area_area_entered(area: Area2D) -> void:
	focused_enemy = area
	print("Hey there" + str(area))

func point_at(point: Vector2):
	rotation = point.angle_to_point(position) + Vector2.UP.angle()
