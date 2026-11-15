extends Area2D
class_name Hurtboxair

func _ready() -> void:
	print("HURTBOX ACTIVADO")


func take_hit(enemy_position: Vector2) -> void:
	var player = get_parent()

	if player.has_method("apply_knockback"):
		player.apply_knockback(enemy_position)
