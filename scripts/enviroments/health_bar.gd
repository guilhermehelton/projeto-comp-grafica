extends TextureProgressBar
class_name HealthBar

var current_health: int

func init_bar(bar_max_value: int) -> void:
	min_value = 0;
	max_value = bar_max_value;
	value = bar_max_value;
	current_health = bar_max_value;
	
func update_value(new_value: int):
	update_bar(current_health, new_value)
	current_health = new_value
	
func update_bar(old_value: int, new_value:int):
	var tween = create_tween();
	tween.tween_property(self, "value", new_value, 0.2);
