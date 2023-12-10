extends Node
class_name MoveState

var velocity: Vector2

@export var walk_speed: int

@export var soldier: NodePath;
@onready var soldierNode: CharacterBody2D = get_node(soldier) as CharacterBody2D;
@onready var timer: Timer = get_node("Timer");

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

func _on_timer_timeout():
	walk_speed = 60;
	Global.currentPowerUp = '';
	get_tree().call_group("interface", "set_powerUp", Global.currentPowerUp)
