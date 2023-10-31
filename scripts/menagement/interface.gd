extends CanvasLayer
class_name Interface

func set_weapon_ammo(current_ammo: int, max_ammo: int) -> void:
	$Ammo.text = "Munição: " + str(current_ammo) + "/" + str(max_ammo);

func set_score(score):
	$Score.text = "Pontuação: " + str(score);
	
func reload_game():
	var _reload: bool = get_tree().change_scene_to_file("res://scenes/menagement/game_level.tscn")
