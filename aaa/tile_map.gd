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

func world_to_map(world_pos: Vector2) -> Vector2:
	# Calculando a posição no mapa a partir da posição no mundo
	var map_x = (world_pos.x / tile_width + world_pos.y / tile_height) / 2
	var map_y = (world_pos.y / tile_height - world_pos.x / tile_width) / 2

	# Retorna a posição calculada no mapa
	return Vector2(map_x, map_y)
