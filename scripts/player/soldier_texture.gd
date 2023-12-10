extends Sprite2D
class_name SoldierTexture

var last_direction_state: bool;
var spawner_position: float = 6;

var on_action : bool = false;
@export var parent : NodePath;
@onready var parentNode: CharacterBody2D = get_node(parent);

@export var animation: NodePath;
@onready var animationNode: AnimationPlayer = get_node(animation);

@export var projectile_spawner: NodePath;
@onready var projectile_spawnerNode: Marker2D =  get_node(projectile_spawner)

func animate(velocity) -> void:
	flip_h = set_orientation();
	if on_action:
		return
	move_behavior(velocity);


func set_orientation() -> bool:
	var mouse_global_position: Vector2 = get_global_mouse_position();
	if mouse_global_position.x > parentNode.global_position.x:
		projectile_spawnerNode.position.x = spawner_position
		last_direction_state = false
		return false
	if mouse_global_position.x < parentNode.global_position.x:
		projectile_spawnerNode.position.x = -spawner_position
		last_direction_state = true
		return true
	return last_direction_state

func action_behavior(state: String):
	on_action = true
	animationNode.play(state)

func move_behavior(velocity: Vector2) -> void:
	if velocity != Vector2.ZERO:
		animationNode.play("walk")
		return
		
	animationNode.play("idle")


func on_animation_finished(anim_name : String) -> void:
	on_action = false
	if anim_name == "fire" or anim_name == "throw":
		parentNode.is_attacking = false
	if anim_name == "hit":
		parentNode.set_physics_process(true)
	if anim_name == "death":
		get_tree().call_group("interface", "open_death_menu")
