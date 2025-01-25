extends Node2D

var position_in_grid = Vector2()
@export var move_range = 3 # Número de células que a unidade pode se mover

func can_move_to(target_position: Vector2) -> bool:
	# Calcula a distância de Manhattan (número de células)
	var distance = abs(target_position.x - position_in_grid.x) + abs(target_position.y - position_in_grid.y)
	return distance <= move_range
