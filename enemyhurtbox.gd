extends Area2D

var vida = 1


func _ready() -> void:
	add_to_group("enemy_hurtbox")


func take_hit() -> void:
	if vida <= 0:
		return

	vida -= 1

	if vida <= 0:
		get_parent().queue_free()
