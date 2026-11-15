extends Node2D

@onready var imagen = $ImagenSorpresa
@onready var musica = $MusicaSorpresa


func _ready() -> void:
	imagen.hide()
	sorpresa()


func sorpresa() -> void:
	await get_tree().create_timer(30.0).timeout

	imagen.show()
	musica.play()

	await get_tree().create_timer(10.0).timeout

	get_tree().quit()
