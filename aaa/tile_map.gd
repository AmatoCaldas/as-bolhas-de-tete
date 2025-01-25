extends TileMap

# Tamanho do tile (usado para cálculos)
@export var tile_width: int = 64  # Largura do tile
@export var tile_height: int = 32  # Altura do tile

# Função que converte coordenadas do grid (tile_x, tile_y) para o mundo (pixels)
func map_to_world(tile_pos: Vector2) -> Vector2:
	# Calculando a posição no mundo
	var world_x = (tile_pos.x + tile_pos.y) * tile_width / 2
	var world_y = (tile_pos.x - tile_pos.y) * tile_height / 2

	# Retorna a posição calculada no mundo
	return Vector2(world_x, world_y)
