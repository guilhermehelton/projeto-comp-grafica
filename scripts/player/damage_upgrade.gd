extends Area2D
class_name DamageUpgrade

var damage_up: int;

func _on_area_entered(area):
	damage_up = 6;
	
	if (area is Ammo) or (area is BaseProjectile):
		return
	if (area is HitBox):
		area.update_damage(damage_up);
		self.queue_free()
