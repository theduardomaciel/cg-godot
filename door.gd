extends Node3D

@export var open_distance: float = 1.5
@export var speed: float = 3.0

var is_open = false
var left_closed_pos: Vector3
var right_closed_pos: Vector3
var left_open_pos: Vector3
var right_open_pos: Vector3

@onready var left_door: Node3D = $Door_glass/DoorLeft_glass
@onready var right_door: Node3D = $Door_glass/DoorRight_glass

func _ready():
	left_closed_pos = left_door.transform.origin
	right_closed_pos = right_door.transform.origin

	left_open_pos = left_closed_pos + Vector3(-open_distance, 0, 0)
	right_open_pos = right_closed_pos + Vector3(open_distance, 0, 0)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("interact"):
		is_open = not is_open

	var target_left = left_open_pos if is_open else left_closed_pos
	var target_right = right_open_pos if is_open else right_closed_pos

	# Movimento suave (lerp) das portas
	left_door.transform.origin = left_door.transform.origin.lerp(target_left, clamp(delta * speed, 0, 1))
	right_door.transform.origin = right_door.transform.origin.lerp(target_right, clamp(delta * speed, 0, 1))
