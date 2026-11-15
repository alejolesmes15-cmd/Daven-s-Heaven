extends CharacterBody2D

@export var speed: float = 300.0

var player: CharacterBody2D
var stun_time: float = 0.0

@onready var sprite = $AnimatedSprite2D


func _ready() -> void:
	player = get_tree().get_first_node_in_group("player") as CharacterBody2D


func apply_stun(duration: float) -> void:
	stun_time = duration


func _physics_process(delta: float) -> void:

	if not is_on_floor():
		velocity += get_gravity() * delta

	if stun_time > 0:
		stun_time -= delta
		velocity.x = 0
		move_and_slide()
		return

	if player == null:
		player = get_tree().get_first_node_in_group("player") as CharacterBody2D

	if player != null:
		var direccion = sign(player.global_position.x - global_position.x)
		velocity.x = direccion * speed

		if direccion != 0:
			sprite.flip_h = direccion < 0
	else:
		velocity.x = 0

	move_and_slide()
