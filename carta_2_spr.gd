extends Sprite2D

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		if get_rect().has_point(event.position):  # Checa se o mouse está dentro da área
			#personagem.position = personagem.grid_to_world(current_grid_position)
			print("AAAA")
