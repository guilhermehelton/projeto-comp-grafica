extends Node
class_name AttackState

# const GRANADE: PackedScene = preload("");

@onready var weapons_dict: Dictionary = {
	"throw": "Granade",
	"fire": class_weapon
}

var weapons_list: Array = [
	"fire",
	"throw"
]

var weapon_index = 0

var granade_amount: int = 5
var max_granade_amount: int = 5

var projectile_amount: int
@export var projectile_max_amount : int
@export var class_weapon : String
@export var fire_projectile: PackedScene

@export var texturePath: NodePath;
@onready var texture: Sprite2D = get_node(texturePath) as Sprite2D;

@export var cameraPath: NodePath;
@onready var camera: Camera2D = get_node(cameraPath) as Camera2D;

@export var soldierPath: NodePath;
@onready var soldier: CharacterBody2D = get_node(soldierPath) as CharacterBody2D;

@export var projectileSpawnerPath: NodePath;
@onready var projectile_spawner: Marker2D = get_node(projectileSpawnerPath) as Marker2D;

func _ready():
	projectile_amount = projectile_max_amount;

func attack():
	if not can_shoot(weapons_list[weapon_index]):
		return
	if Input.is_action_just_pressed("attack") and not soldier.is_attacking:
		soldier.is_attacking = true;
		update_ammo(weapons_list[weapon_index], "decrease", 1);
		texture.action_behavior(weapons_list[weapon_index])

func can_shoot(type: String) -> bool:
	if type == "fire" and projectile_amount > 0:
		return true
	if type == "throw" and granade_amount > 0:
		return true
		
	return false

func update_ammo(weapon_type: String, type: String, value: int) -> void:
	if weapon_type == "throw" and type == "increase":
		granade_amount += value
	
	if weapon_type == "throw" and type == "decrease":
		granade_amount -= value
		
	if weapon_type == "fire" and type == "increase":
		projectile_amount += value
		
	if weapon_type == "fire" and type == "decrease":
		projectile_amount -= value
	
	verify_ammo_amount(weapon_type);	

func verify_ammo_amount(weapon_type: String):
	if weapon_type == "throw" and granade_amount > max_granade_amount:
		granade_amount = max_granade_amount;
		
	if weapon_type == "fire" and projectile_amount > projectile_max_amount:
		projectile_amount = projectile_max_amount;
		
func spawn_projectile(type: String) -> void:
	var projectile_direction: Vector2 = (soldier.get_global_mouse_position() - soldier.global_position).normalized()
	var projectile = null
	match type:
		"fire":
			projectile = fire_projectile.instantiate();
		"throw":
			pass
	get_tree().root.call_deferred("add_child", projectile)
	projectile.global_position = projectile_spawner.global_position
	projectile.direction = projectile_direction
