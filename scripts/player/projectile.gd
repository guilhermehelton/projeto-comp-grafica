extends Area2D
class_name BaseProjectile

signal camera_shake

var already_destroyed:bool = false

var direction: Vector2 = Vector2.ZERO

@export var damage: int
@export var move_speed: int
@export var shake_lifetime: float
@export var shake_strength: float
@export var explosion_effect: PackedScene

func _physics_process(delta: float) -> void:
	translate(direction * move_speed * delta);

func _on_screen_exited() -> void:
	if not already_destroyed:
		kill()

func on_body_entered(body):
	if body is TileMap:
		kill()

func kill():
	emit_signal("camera_shake", shake_lifetime, shake_strength)
	already_destroyed = true
	#spawn_explosion
	queue_free()


