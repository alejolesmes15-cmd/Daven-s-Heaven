
extends Area2D

func _ready() -> void:
	add_to_group("enemy_hitbox")
	area_entered.connect(_on_area_entered)


func _on_area_entered(area: Area2D) -> void:
	if area is Hurtbox:
		area.take_hit(global_position)

		var enemy = get_parent()

		if enemy.has_method("apply_stun"):
			enemy.apply_stun(1.0)
