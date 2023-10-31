extends Area2D
class_name Ammo

@export var type: String
@export var amount:int

func _ready():
	randomize()
	if type == "throw":
		return
	amount = randi() % 20 - 1


func _on_body_entered(body):
	if body is Soldier:
		body.attack_state.update_ammo(type, "increase", amount)
		queue_free()
