extends CanvasLayer
class_name Interface

func set_weapon_ammo(current_ammo: int, max_ammo: int) -> void:
	$Ammo.text = "Munição: " + str(current_ammo) + "/" + str(max_ammo);
