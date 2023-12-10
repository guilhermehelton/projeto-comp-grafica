extends Area2D
class_name SpeedUp

var speed_up: int;

func _on_area_entered(area):
	speed_up = 100;
	
	if (area is Ammo) or (area is BaseProjectile):
		return
	if (area is HitBox):
		area.update_speed(speed_up)
		self.queue_free()
