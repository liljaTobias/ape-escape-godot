extends CharacterBody2D

@onready var animation_sprite = $AnimatedSprite2D
@onready var player: CollisionObject2D = get_tree().root.get_node("Main/Player")
@onready var nav: NavigationAgent2D = $NavigationAgent2D

@export var SPEED = 150

var direction: Vector2
var new_direction = Vector2(0,1)

func  _ready():
	nav.max_speed = SPEED

func _physics_process(delta):
	nav.target_position = player.global_position
	
	var next_pos = nav.get_next_path_position()
	var new_vel = (next_pos - global_position).normalized()
	
	nav.velocity = new_vel
	move_and_collide(nav.velocity)
