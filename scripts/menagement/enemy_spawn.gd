extends Node2D
class_name EnemySpawn

const CELL_SIZE:int = 16

@onready var parent: Node2D = get_parent();
@onready var timer: Timer = get_node("Timer");

var avaliable_cells: Array = [];
var spawn_cooldown:float = 3

@export var enemies_list: Array[PackedScene];

func _ready():
	randomize()
	

func _on_timer_timeout():
	spawn()
	timer.start(spawn_cooldown)
	
func spawn():
	var random_spawn_index:int = randi() % avaliable_cells.size()
	var spawn_position:Vector2 = avaliable_cells[random_spawn_index] * CELL_SIZE
	
	var random_enemy_index:int = randi() % enemies_list.size()
	var enemy:Enemy = enemies_list[random_enemy_index].instantiate()
	enemy.player = parent.get_node("Character")
	enemy.global_position = spawn_position
	parent.add_child(enemy)
