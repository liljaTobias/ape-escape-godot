extends State
class_name EnemyFollow

@onready var enemy = $"../.."
@onready var nav = $"../../NavigationAgent2D"

@export var speed = 100
var acceleration = 7
var direction = Vector2.ZERO # -1, 0, 1

var target: CharacterBody2D

func enter():
	target = get_tree().get_first_node_in_group("Player")
	
func physics_update(delta):
	nav.target_position = target.global_position
	
	var distance = enemy.global_position - target.global_position
	
	if distance.length() < 15:
		transitoned.emit(self, "dragging")
	
	if !nav.is_navigation_finished():
		direction = (nav.get_next_path_position() - enemy.global_position).normalized()
		enemy.velocity = enemy.velocity.lerp(direction * speed, acceleration * delta)


func _on_detection_area_body_exited(_body):
	transitoned.emit(self, "idle")
