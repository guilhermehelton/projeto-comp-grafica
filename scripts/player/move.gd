extends Node
class_name MoveState

var velocity: Vector2

@export var walk_speed: int

@export var soldier: NodePath;
@onready var soldierNode: CharacterBody2D = get_node(soldier) as CharacterBody2D;

func move()->void:
	if soldierNode.is_attacking:
		return
	
	velocity = get_direction() * move_state();
	soldierNode.velocity = velocity;
	soldierNode.move_and_slide();


func get_direction() -> Vector2:
	return Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	).normalized();

func move_state():
	return walk_speed
