extends Area2D
class_name Health

var heal: int

func _ready():
	randomize()
	heal = randi() % 10 + 1


func _on_area_entered(area):
	if (area is Ammo) or (area is BaseProjectile):
		return
	if (area is HitBox):
		area.update_health(heal, "increase")
		self.queue_free()
