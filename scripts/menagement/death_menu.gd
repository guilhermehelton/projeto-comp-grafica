extends Control
class_name DeathMenu

@onready var pontos_label = get_node("VBoxContainer/Pontos")

func _ready():
	pontos_label.text = "Sua pontuação foi: " + str(Global.score);

func _on_restart_pressed():
	get_tree().change_scene_to_file("res://scenes/menagement/game_level.tscn");
