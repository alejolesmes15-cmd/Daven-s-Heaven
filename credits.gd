
extends Control

@onready var texto = $Texto
@onready var musica = $AudioStreamPlayer2D
@onready var imagen = $TextureRect
@onready var imagen2 = $TextureRect2
@onready var texto2 = $Texto2
@onready var imagen3 = $TextureRect3
@onready var imagenbarajas = $barajas
@onready var imagenplush = $TextureRect4

func _ready() -> void:

	var pantalla = get_viewport_rect().size

	musica.play()

	texto.text = """
¡GRACIAS POR JUGAR!

Desarrollado por:
jimmy y sabogal >:3

Programación:
sabogal y jimmy

Diseño:
jimmy

MÚSICA:
Mi primer millón - Bacilos

Interpretada por:
ochoa, izquierdo, cortez, lezmes y reyes

AGRADECIMIENTO ESPECIAL A:

GALINDO Y REM
Y CLARO BARAJAS
"""

	texto.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	texto.vertical_alignment = VERTICAL_ALIGNMENT_TOP
	texto.autowrap_mode = TextServer.AUTOWRAP_OFF
	texto.size = Vector2(pantalla.x, 700)
	texto.position = Vector2(0, pantalla.y)

	imagen.size = Vector2(250, 180)
	imagen.position = Vector2(
		pantalla.x / 2 - 260,
		pantalla.y + 850
	)

	imagen2.size = Vector2(250, 180)
	imagen2.position = Vector2(
		pantalla.x / 2 + 10,
		pantalla.y + 850
	)
	imagenbarajas.size = Vector2(250, 180)
	imagenbarajas.position = Vector2(
		pantalla.x / 2 + 200,
		pantalla.y + 800
		
	)

	texto2.text = """
MENCION HONORIFICA A:

AGNES TACHYON Y
HAKUREI REIMU
"""

	texto2.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	texto2.vertical_alignment = VERTICAL_ALIGNMENT_TOP
	texto2.autowrap_mode = TextServer.AUTOWRAP_OFF
	texto2.size = Vector2(pantalla.x, 400)
	texto2.position = Vector2(0, pantalla.y + 1150)

	imagen3.size = Vector2(250, 180)
	imagen3.position = Vector2(
		(pantalla.x - 250) / 2,
		pantalla.y + 1600
	)
	imagenplush.size = Vector2(250, 180)
	imagenplush.position = Vector2(
		(pantalla.x - 250) / 2,
		pantalla.y + 1400
	)

	var tween = create_tween()

	tween.set_parallel(true)

	tween.tween_property(
		texto,
		"position:y",
		-700.0,
		35.0
	).set_trans(Tween.TRANS_LINEAR)

	tween.tween_property(
		imagen,
		"position:y",
		-700.0,
		35.0
	).set_trans(Tween.TRANS_LINEAR)

	tween.tween_property(
		imagen2,
		"position:y",
		-700.0,
		35.0
	).set_trans(Tween.TRANS_LINEAR)

	tween.tween_property(
		imagenbarajas,
		"position:y",
		-700.0,
		35.0
	).set_trans(Tween.TRANS_LINEAR)

	tween.tween_property(
		texto2,
		"position:y",
		-700.0,
		35.0
	).set_trans(Tween.TRANS_LINEAR)

	tween.tween_property(
		imagen3,
		"position:y",
		-700.0,
		35.0
	).set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(
		imagenplush,
		"position:y",
		-700.0,
		35.0
	).set_trans(Tween.TRANS_LINEAR)
	await get_tree().create_timer(35.0).timeout

	get_tree().quit()
