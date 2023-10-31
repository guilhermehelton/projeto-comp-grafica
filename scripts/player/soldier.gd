extends CharacterBody2D
class_name Soldier

@onready
var move_state: Node = get_node("States/Move");
@onready
var attack_state:Node = get_node("States/Attack");
@onready
var texture:Sprite2D = get_node("Texture");

@onready
var is_attacking: bool = false;

func _physics_process(_delta: float) -> void:
	move_state.move();
	texture.animate(move_state.velocity);
	attack_state.attack();
