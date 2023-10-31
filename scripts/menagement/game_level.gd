extends Node2D
class_name GameLevel

var avaliable_spawn_tiles_list: Array = []
const CELL_SIZE: int = 16;
@onready var enemy_spawn: Node2D = get_node("Node2D");
@onready var soldier: CharacterBody2D = get_node("Character");
@onready var base_terrain: TileMap = get_node("Node2D/BaseTerrain");
var score = 0

func _ready() -> void:
	define_camera_limit();
	set_spawn_tiles();
	
	
func set_spawn_tiles():
	for tile in base_terrain.get_used_cells(0):
		find_edges(tile);
	
	enemy_spawn.avaliable_cells = avaliable_spawn_tiles_list;

func find_edges(current_cell: Vector2):
	var used_rect: Rect2 = base_terrain.get_used_rect();
	var x_size: float = used_rect.size.x;
	var y_size: float = used_rect.size.y;
	
	var x_pos: float = used_rect.position.x;
	var y_pos: float = used_rect.position.y;
	
	if current_cell.x == x_size - 1 or current_cell.x == x_pos:
		avaliable_spawn_tiles_list.append(current_cell);
		
	if current_cell.y == y_size - 1 or current_cell.y == y_pos:
		avaliable_spawn_tiles_list.append(current_cell);

func define_camera_limit() -> void:
	var soldier_camera: Camera2D = soldier.get_node("Camera2D");
	var used_rect_tile: Rect2 = base_terrain.get_used_rect();
	
	soldier_camera.limit_left = int(used_rect_tile.position.x);
	soldier_camera.limit_top = int(used_rect_tile.position.y);
	
	soldier_camera.limit_right = int(used_rect_tile.size.x * CELL_SIZE);
	soldier_camera.limit_bottom = int(used_rect_tile.size.y * CELL_SIZE); 

func _process(_delta):
	if soldier == null:
		return
	send_player();

func send_player():
	get_tree().call_group("enemy", "get_player")

func increase_score():
	score += 100;
	get_tree().call_group("interface", "set_score", score)
