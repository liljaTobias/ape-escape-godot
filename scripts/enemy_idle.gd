extends State
class_name EnemyIdle

@export var enemy: CharacterBody2D
@export var speed = 10
var acceleration = 7

@onready var nav = $"../../NavigationAgent2D"

var direction: Vector2
var wander_time: float


func randomize_wander():
	direction = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
	wander_time = randf_range(1, 3)

func enter():
	nav.target_position = enemy.spawn

func update(delta: float):
	if wander_time > 0:
		wander_time -= delta
	elif nav.is_navigation_finished():
		randomize_wander()

func physics_update(delta):
	if enemy:
		if !nav.is_navigation_finished():
			direction = (nav.get_next_path_position() - enemy.global_position).normalized()
		enemy.velocity = enemy.velocity.lerp(direction * speed, acceleration * delta)

func _on_detection_area_body_entered(body):
	transitoned.emit(self, "follow")
