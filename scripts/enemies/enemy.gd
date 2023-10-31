extends CharacterBody2D
class_name Enemy

@export var player: Node2D

@onready var navigation: NavigationAgent2D = get_node("NavigationAgent2D")
@onready var texture: Sprite2D = get_node("Texture")
@onready var collision_shape: CollisionShape2D = get_node("Collision")
@onready var monitoring_timer: Timer = get_node("MonitoringTimer")

var distance: float

var items_dict: Dictionary = {
	"Ammo": [
		[1, 70],
		preload("res://scenes/player/ammo/main_weapon_ammo.tscn")
	],
	"Health": [
		[81, 100],
		preload("res://scenes/combat/health.tscn")
	]
}

var path: Array = []
var velocity_speed: Vector2

@export var attack_cooldown: float

@export var damage: int
@export var move_speed: int
@export var distance_threshold: int

func get_player() -> void:
	navigation.target_position = player.global_position
	if navigation.get_target_position().length() == 0:
		return
	
	distance = global_position.distance_to(player.global_position)
	velocity_speed = global_position.direction_to(navigation.get_target_position()) * move_speed
	
func _physics_process(_delta):
	if distance < distance_threshold:
		return
		
	velocity = velocity_speed;
	move_and_slide()
	verify_direction()
	animate()
	
func verify_direction() -> void:
	if velocity.x > 0:
		texture.flip_h = false;
	if velocity.x < 0:
		texture.flip_h = true;

func animate() -> void:
	pass

func set_collision():
	change_monitoring_state(true)
	monitoring_timer.start(attack_cooldown);
	

func _on_monitoring_timer_timeout():
	change_monitoring_state(false)


func change_monitoring_state(state: bool):
	collision_shape.set_deferred("disabled", state);

func kill():
	roll_dice()
	self.queue_free()
	get_parent().increase_score();

func roll_dice():
	var random_number:int = randi() % 100 + 1
	for item in items_dict.keys():
		get_item(item, random_number)

func get_item(item_key: String, random_number: int):
	
	var drop_probability_list: Array = items_dict[item_key][0]
	
	var min_number = drop_probability_list[0]
	var max_number = drop_probability_list[1]
	if random_number >= min_number and random_number <= max_number:
		spawn_item(items_dict[item_key][1])

func spawn_item(item_to_spawn : PackedScene):
	var item = item_to_spawn.instantiate();
	get_tree().root.call_deferred("add_child", item)
	item.global_position = global_position
