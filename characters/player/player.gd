extends CharacterBody2D

@onready var animation_sprite = $AnimatedSprite2D

@export var SPEED = 150.0

var new_direction = Vector2(0,1)
var animation
var spawn
var stunned = false

func _ready():
	position = %Spawn.global_position
	spawn = position

func _physics_process(delta):
	# Get the input direction and handle the movement/deceleration.
	var direction: Vector2
	direction.x = Input.get_axis("ui_left", "ui_right")
	direction.y = Input.get_axis("ui_up", "ui_down")
	
	# Normalize diagonal input
	if abs(direction.x) == 1 and abs(direction.y) == 1:
		direction = direction.normalized()
	
	# Do movement
	var movement = SPEED * direction * delta
	if !stunned:
		move_and_collide(movement)
	else:
		move_and_slide()
	
	# Play animations
	player_animations(direction)

func set_stunned(val: bool):
	stunned = val

func player_animations(direction: Vector2):
	if direction != Vector2.ZERO:
		new_direction = direction
		animation = "walk_" + get_direction(new_direction)
	else:
		animation = "idle_" + get_direction(new_direction)
		
	animation_sprite.play(animation)
	
func get_direction(direction: Vector2):
	var normalized_direction = direction.normalized()
	
	if normalized_direction.y > 0:
		return "down"
	elif normalized_direction.y < 0:
		return 'up'
	elif normalized_direction.x > 0:
		return 'right'
	elif normalized_direction.x < 0:
		return 'left'
		
	return 'left'
