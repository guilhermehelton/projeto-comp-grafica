extends HitBox
class_name EnemyHitbox

const DEATH_EFFECT: PackedScene = preload("res://scenes/effects/death_effect.tscn")

func _on_area_entered(area):
	if area.name == "Hitbox":
		return
	
	area.kill()
	update_health(area.damage, "")

func update_health(damage: int, _type: String):
	health -= damage
	health_bar.update_value(health)
	if health <= 0:
		spawn_effect();
		get_parent().kill()

func spawn_effect():
	var effect = DEATH_EFFECT.instantiate()
	effect.global_position = global_position
	get_tree().root.call_deferred("add_child", effect)

func _on_body_entered(_body):
	pass
