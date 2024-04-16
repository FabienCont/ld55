@tool
extends ColorRect

@export var max_pull_value :float= 20.0
@export var min_pull_value :float= -20.0
@export var based_pull_value: float =0.0:
	set(value):
		based_pull_value =clamp(value, min_pull_value, max_pull_value)
		pull_value_applied = based_pull_value
		position.y += pull_value_applied

@onready var pull_value_applied: float = 0.0

@onready var collision_shape = $Area2D/CollisionShape2D
@onready var area = $Area2D
@onready var ice_static_body = $StaticBody2D
@onready var pos_y_temp: = position.y
var water_tint:Vector4 = Vector4(0.18,.28,0.63,0.1)
var frozen_tint:Vector4 =  Vector4(0.03,1.,1.,0.80)
var actual_tint:Vector4 =  Vector4(0.18,.28,0.63,0.1):
	set(value):
		actual_tint = value
		set_color_shader(value)

var percent_frozen:float =0.0:
	set(value):
		percent_frozen = value
		
		material.set_shader_parameter("percent",1.0-percent_frozen)
		update_color()

@export var is_frozen:bool=false

func _process(delta):
	if position.y != pos_y_temp:
		position.y = lerp(position.y,pos_y_temp,delta)

func _onready():
	if is_frozen == true:
		start_froze()
	else:
		start_unfroze()

func get_diff_pull_value() -> float:
	return pull_value_applied - based_pull_value

func add_pull_value(value:float):
	var new_pull_value_applied = pull_value_applied + value
	new_pull_value_applied = clamp(new_pull_value_applied, min_pull_value, max_pull_value)
	update_pos(new_pull_value_applied - pull_value_applied)
	pull_value_applied = new_pull_value_applied

func update_pos(translate_value):
	pos_y_temp = position.y + translate_value
	#position.y += translate_value

func pull(_delta):
	add_pull_value(30)
	
func push(_delta):
	add_pull_value(-30)
	
func froze(_delta:float):
	start_froze()

func unfroze(_delta:float):
	start_unfroze()
	
func set_color_shader(tint:Vector4):
	material.set_shader_parameter("tint",tint)

func mix_colors(color1: Vector4, color2: Vector4, percent: float) -> Vector4:
	return color1.lerp(color2, clamp(percent, 0.0, 1.0))

func update_color():
	actual_tint = mix_colors(water_tint,frozen_tint,percent_frozen);
func start_froze():
	area.froze()
	ice_static_body.froze()
	createTweenEffect(true)

func start_unfroze():
	createTweenEffect(false)
	area.unfroze()
	ice_static_body.unfroze()

func end_froze():
	is_frozen = true
	
func end_unfroze():
	is_frozen = false
	
func createTweenEffect(is_froze:bool):
	var tween := self.create_tween()
	var final_value = 1.0
	if is_froze == false:
		final_value =0.0
		tween.finished.connect(end_unfroze)
	else:
		tween.finished.connect(end_froze)
	
	tween.tween_property(self,"percent_frozen",final_value,0.4).from_current()
	tween.play()
