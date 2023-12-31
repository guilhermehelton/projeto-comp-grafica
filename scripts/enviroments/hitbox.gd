extends Area2D
class_name HitBox

var on_hit:bool = false
var on_death:bool = false

var max_health_value: int

@export var health: int;

@export var texturePath: NodePath;
@export var healthBarPath: NodePath;
@export var moveStatePath: NodePath;
@export var attackStatePath: NodePath;

@onready var texture: Sprite2D = get_node(texturePath) as Sprite2D
@onready var health_bar: TextureProgressBar = get_node(healthBarPath)
@onready var moveState: Node = get_node(moveStatePath)
@onready var attackState: Node = get_node(attackStatePath)

func _ready():
	max_health_value = health;
	health_bar.init_bar(health);

func _on_area_entered(_area):
	pass # Replace with function body.

func _on_body_entered(body):
	if body is Enemy:
		update_health(body.damage, "decrease");
		body.set_collision()
	
func update_health(value: int, type: String):
	if type == "decrease":
		health -= value
	
	if type == "increase":
		health = clamp(health + value, 0, max_health_value)
		health_bar.update_value(health)
		return
	
	health_bar.update_value(health)
	if health <= 0:
		texture.action_behavior("death")
		return
	
	texture.action_behavior("hit")

func update_speed(value: int):
	moveState.timer.start(10);
	Global.currentPowerUp = '+70% de velocidade'
	get_tree().call_group("interface", "set_powerUp", Global.currentPowerUp)
	moveState.walk_speed = value;

func update_damage(value: int):
	attackState.timer.start(10);
	Global.currentPowerUp = '2x Dano'
	get_tree().call_group("interface", "set_powerUp", Global.currentPowerUp)
	attackState.projectile_damage = value;
