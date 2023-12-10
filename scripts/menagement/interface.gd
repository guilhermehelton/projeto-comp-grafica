extends CanvasLayer
class_name Interface

var score;

func set_weapon_ammo(current_ammo: int, max_ammo: int) -> void:
	$Ammo.text = "Munição: " + str(current_ammo) + "/" + str(max_ammo);

func set_score(score):
	score = score;
	$Score.text = "Pontuação: " + str(score);
	
func set_powerUp(powerUpLabel):
	$PowerUp.text = powerUpLabel;

func open_death_menu():
	var _menu: bool = get_tree().change_scene_to_file("res://scenes/menagement/death_menu.tscn")
