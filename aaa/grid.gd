extends Node2D

@export var tile_size: Vector2 = Vector2(64, 32)  # Tamanho do tile no seu TileSet (64x32)
@onready var tilemap: TileMap = $TileMap  # Referência ao TileMap
@onready var personagem: Node2D = $Tete  # Referência ao personagem

# Função para calcular a posição do tile baseado na posição do mouse
func mouse_to_tile(mouse_pos: Vector2) -> Vector2:
	# Posição relativa do mouse em relação ao TileMap
	var rel_mouse_pos = mouse_pos - tilemap.global_position

	# Convertendo as coordenadas do mundo para o sistema isométrico
	var iso_y = (rel_mouse_pos.x / tile_size.x - rel_mouse_pos.y / tile_size.y)
	var iso_x = (rel_mouse_pos.y / tile_size.y + rel_mouse_pos.x / tile_size.x)

	# Arredondar para obter a coordenada do tile mais próximo
	var tile_pos = Vector2(round(iso_x), round(iso_y))
	
	# Converter a coordenada de volta para a posição no mundo (centro do tile)
	var world_pos = tilemap.map_to_world(tile_pos)
	world_pos += tile_size / 2  # Ajusta para o centro do tile
	return world_pos

# Função chamada ao clicar no mouse
func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		var mouse_pos = get_global_mouse_position()  # Posição global do mouse
		
		# Converte a posição do mouse para o centro do tile
		var tile_center = mouse_to_tile(mouse_pos)

		# Teleporta o personagem para o centro do tile
		personagem.position = tile_center
