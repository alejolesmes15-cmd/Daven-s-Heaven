extends Button

func _ready() -> void:
	pressed.connect(_on_pressed)


func _on_pressed() -> void:
	print("ABRIENDO CREDITOS")
	get_tree().change_scene_to_file("res://credits.tscn")
