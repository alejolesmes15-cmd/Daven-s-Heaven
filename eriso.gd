
extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -300.0

@export var velocidad_giro: float = 3.5
@export var fuerza_rebote_pared: float = 650.0
@export var impulso_vertical_rebote: float = 180.0
@export var cooldown_rebote: float = 0.4

var tiempo_cooldown_rebote = 0.0

var knockback_velocity = Vector2.ZERO
var knockback_strength = 850.0
var knockback_friction = 1800.0

var vidas = 3
var tiempo_invulnerable = 0.0
var duracion_invulnerable = 1.0
var game_over = false

@onready var sprite = $AnimatedSprite2D
@onready var vidas_texto = $"../CanvasLayer/Vidas"

@onready var colision_suelo = $CollisionShape2D
@onready var hurtbox_suelo = $hurtbox/CollisionShape2D

@onready var colision_aire = $Collision
@onready var hitbox_aire = $hitbox/hitbox
@onready var hurtbox_aire = $"hurtbox aerea"/CollisionShape2D3


func _ready() -> void:
	add_to_group("player")
	actualizar_vidas()
	actualizar_colisiones()


func actualizar_vidas() -> void:
	var corazones = ""

	for i in range(vidas):
		corazones += "♥ "

	vidas_texto.text = corazones
	vidas_texto.add_theme_color_override("font_color", Color.RED)


func actualizar_colisiones() -> void:
	var en_suelo = is_on_floor()

	colision_suelo.disabled = not en_suelo
	hurtbox_suelo.disabled = not en_suelo

	colision_aire.disabled = en_suelo
	hitbox_aire.disabled = en_suelo
	hurtbox_aire.disabled = en_suelo


func revisar_rebote_pared(velocidad_anterior: Vector2) -> void:
	if is_on_floor() or tiempo_cooldown_rebote > 0:
		return

	for i in range(get_slide_collision_count()):
		var collision = get_slide_collision(i)
		var normal = collision.get_normal()

		if abs(normal.x) > 0.8 and velocidad_anterior.x * normal.x < 0:
			velocity.x = normal.x * fuerza_rebote_pared
			velocity.y = -impulso_vertical_rebote
			tiempo_cooldown_rebote = cooldown_rebote
			return


func apply_knockback(enemy_position: Vector2) -> void:
	if tiempo_invulnerable > 0 or game_over:
		return

	vidas -= 1
	actualizar_vidas()

	var direction = (global_position - enemy_position).normalized()
	knockback_velocity = direction * knockback_strength

	tiempo_invulnerable = duracion_invulnerable

	if vidas <= 0:
		game_over = true
		call_deferred("ir_a_game_over")


func ir_a_game_over() -> void:
	get_tree().change_scene_to_file("res://game_over.tscn")


func _physics_process(delta: float) -> void:

	if game_over:
		return

	if tiempo_cooldown_rebote > 0:
		tiempo_cooldown_rebote -= delta

	if tiempo_invulnerable > 0:
		tiempo_invulnerable -= delta

	var direction := Input.get_axis("izquierda", "derecha")

	# KNOCKBACK
	if knockback_velocity.length() > 0:
		sprite.play("hurt")
		velocity = knockback_velocity

		knockback_velocity = knockback_velocity.move_toward(
			Vector2.ZERO,
			knockback_friction * delta
		)

		if not is_on_floor():
			velocity += get_gravity() * delta

		var velocidad_knockback = velocity

		move_and_slide()

		revisar_rebote_pared(velocidad_knockback)
		actualizar_colisiones()
		return

	# GIRO EN EL AIRE
	if not is_on_floor():
		var direccion_giro := Input.get_axis(
			"giro izquierda",
            "giro derecha"
		)

		rotation += direccion_giro * velocidad_giro * delta

	# ENDEREZAR AL TOCAR EL SUELO
	if is_on_floor():
		rotation -= rotation * delta * 6

	# GRAVEDAD
	if not is_on_floor():
		velocity += get_gravity() * delta

	# SALTO
	if Input.is_action_just_pressed("salto") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# MOVIMIENTO CON ACELERACION
	if direction:
		velocity.x += direction * SPEED * delta * (300 - pow(direction, 2)) / 200
		sprite.flip_h = direction < 0
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED * delta)

	# REBOTE MANUAL
	if Input.is_action_just_pressed("rebote") and abs(velocity.y)>30:
		velocity = Vector2(-velocity.x * 1.2, velocity.y * 2)

	# ANIMACIONES
	if not is_on_floor():
		sprite.play("jump")
	elif direction != 0:
		sprite.play("run")
	else:
		sprite.play("idle")

	# FISICAS Y REBOTE DE PARED
	var velocidad_anterior = velocity

	move_and_slide()

	revisar_rebote_pared(velocidad_anterior)
	actualizar_colisiones()
