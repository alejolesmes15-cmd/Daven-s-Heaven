extends Button

func _ready() -> void:
	pressed.connect(_on_pressed)


func _on_pressed() -> void:
	print("EL BOTON FUNCIONA")
	get_tree().change_scene_to_file("res://level_one.tscn")
