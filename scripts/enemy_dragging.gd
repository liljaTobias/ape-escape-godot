extends State
class_name EnemyDragging

@onready var enemy: BossEnemy = $"../.."
@onready var nav = $"../../NavigationAgent2D"

@export var speed = 100
var acceleration = 7
var target: CharacterBody2D
var direction = Vector2.ZERO # -1, 0, 1

func enter():
	target = get_tree().get_first_node_in_group("Player")
	target.set_stunned(true)
	nav.target_position = target.spawn

func physics_update(delta):
	if !nav.is_navigation_finished():
		direction = (nav.get_next_path_position() - enemy.global_position).normalized()
		enemy.velocity = enemy.velocity.lerp(direction * speed, acceleration * delta)
		target.velocity = enemy.velocity.lerp(direction * speed, acceleration * delta)
	else:
		target.set_stunned(false)
		transitoned.emit(self, "idle")
