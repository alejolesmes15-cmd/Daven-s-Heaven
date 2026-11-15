extends Area2D
class_name Hurtbox

func _ready() -> void:
	print("HURTBOX ACTIVADO")

func take_hit(enemy_position: Vector2) -> void:
	print("¡ERISO RECIBIÓ UN GOLPE!")

	var player = get_parent()

	if player.has_method("apply_knockback"):
		player.apply_knockback(enemy_position)
