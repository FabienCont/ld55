@tool
extends Node2D

@export var LERP_FACTOR :float = 0.01
@export var node_to_follow: Node2D
@export var offset_follow = Vector2.ZERO
@onready var sprite: AnimatedSprite2D = $wooden_stick

var animations = ["Start_Power", "Power", "End_Power","Idle"]
var current_animation_index = 0

func _ready():
	top_level=true
	
func _physics_process(delta: float): 
	follow_node(delta)
	
func follow_node(delta: float):
	if node_to_follow != null :
		global_position = global_position.lerp(node_to_follow.global_position + offset_follow,delta *LERP_FACTOR) 

func use_power(delta: float,name: String):
	print(name)

func switch_side(direction:Vector2):
	if direction.x < 0:
		offset_follow.x= -16
		sprite.flip_h = true
	elif direction.x > 0:
		sprite.flip_h = false
		offset_follow.x= 16

func play(delta):
	if sprite.animation != "Start_Power":
		sprite.play("Start_Power")

func stop(delta):
	sprite.play("Stop_Power")
func _on_animation_finished():
	if sprite.animation == "Start_Power":
		sprite.play("Power")
	if sprite.animation == "Stop_Power":
		sprite.play("Idle")

func _on_wooden_stick_animation_finished():
	#_on_animation_finished()
	pass # Replace with function body.
