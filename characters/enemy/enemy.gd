extends  CharacterBody2D
class_name BossEnemy

@onready var animated_sprite = $AnimatedSprite2D

var spawn: Vector2

func _ready():
	spawn = global_position

func _physics_process(delta):
	move_and_slide()
	
	if velocity.y > 0:
		animated_sprite.play("walk_down")
	elif velocity.y < 0:
		animated_sprite.play("walk_up")
	elif velocity.x > 0:
		animated_sprite.play("walk_right")
	elif velocity.x < 0:
		animated_sprite.play("walk_left")
	
#extends CharacterBody2D
#
#@onready var nav: NavigationAgent2D = $NavigationAgent2D
#@onready var animated_sprite = $AnimatedSprite2D
#@onready var detection_area = $DetectionArea
#@onready var collision_shape = $CollisionShape2D
#
#enum State {IDLE, CHASING, DRAGGING}
#
#var previous_position: Vector2
#var SPEED = 100
#var acceleration = 7
#var target: CharacterBody2D
#var state = State.IDLE
#
#func _physics_process(delta):
	#var direction = Vector2.ZERO # -1, 0, 1
	#
	#match state:
		#State.IDLE:
			## Return home
			#nav.target_position = previous_position
		#State.CHASING:
			#nav.target_position = target.global_position
		#State.DRAGGING:
			#nav.target_position = %Spawn.global_position
			#target.position = global_position
			#
	## TODO: Start dragging-state
	#
	## If player found and is currently chasing, update target position
	##if target and state == State.CHASING:
		##nav.target_position = target.global_position
	#
	## Update movement
	#if !nav.is_navigation_finished():
		#direction = (nav.get_next_path_position() - global_position).normalized()
		#velocity = velocity.lerp(direction * SPEED, acceleration * delta)
#
	#var collision = move_and_collide(velocity)
	#print(collision)
	## If player caught drag the player with you 
	##if target and dragging:
		##print("Moving player", dragging)
		##target.position = global_position
	#
	#handle_animations(direction)
#
#func _on_detection_area_body_entered(body):
	## Save the position where chase is started
	#print("Detected!")
	#previous_position = global_position
	#target = body
	#state = State.CHASING
#
#func handle_animations(direction: Vector2):
	#var animation 
	#if direction != Vector2.ZERO:
		#animation = "walk_" + get_direction(direction)
	#else:
		#animation = "idle_" + get_direction(direction)
		#
	#animated_sprite.play(animation)
	#
#func get_direction(direction: Vector2):
	#var normalized_direction = direction.normalized()
	#
	#if normalized_direction.y > 0:
		#return "down"
	#elif normalized_direction.y < 0:
		#return 'up'
	#elif normalized_direction.x > 0:
		#return 'right'
	#elif normalized_direction.x < 0:
		#return 'left'
		#
	#return 'left'
