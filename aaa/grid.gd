extends Node2D

@export var tile_size: Vector2 = Vector2(64, 32)  # Tamanho do tile no seu TileSet (64x32)
@onready var tilemap: TileMap = $TileMap  # Referência ao TileMap
@onready var personagem: Node2D = $Tete  # Referência ao personagem
@onready var enemy: Node2D = $Enemy # Referência ao inimigo

# Limites do grid
@export var straight_radius: int = 4  # Limite para direções retas (eixos X e Y)
@export var diagonal_radius: int = 8  # Limite para direções diagonais


# Propriedades para definir as posições iniciais no grid
@export var initial_tete_tile: Vector2i = Vector2i(-3, -3)  # Posição inicial do Tete
@export var initial_enemy_tile: Vector2i = Vector2i(3, 3)  # Posição inicial do Enemy

func _ready():
	# Posicionar o personagem (Tete) no centro do tile inicial
	personagem.position = tilemap.map_to_world(initial_tete_tile) + tile_size / 2

	# Posicionar o inimigo (Enemy) no centro do tile inicial
	enemy.position = tilemap.map_to_world(initial_enemy_tile) + tile_size / 2


# Função para calcular a posição do tile baseado na posição do mouse
func mouse_to_tile(mouse_pos: Vector2) -> Vector2:
	# Posição relativa do mouse em relação ao TileMap
	var rel_mouse_pos = mouse_pos - tilemap.global_position

	# Convertendo as coordenadas do mundo para o sistema isométrico
	var iso_y = (rel_mouse_pos.x / tile_size.x - rel_mouse_pos.y / tile_size.y)
	var iso_x = (rel_mouse_pos.y / tile_size.y + rel_mouse_pos.x / tile_size.x)

	# Arredondar para obter a coordenada do tile mais próximo
	var tile_pos = Vector2(round(iso_x), round(iso_y))

	# Verificar se o tile está dentro dos limites do grid losangular
	# Distância reta (eixo X ou Y) deve estar dentro de straight_radius
	# Distância diagonal (soma de |x| + |y|) deve estar dentro de diagonal_radius
	if abs(tile_pos.x) > straight_radius or abs(tile_pos.y) > straight_radius or abs(tile_pos.x) + abs(tile_pos.y) > diagonal_radius:
		return Vector2(-1, -1)  # Retorna um valor inválido para indicar fora do grid

	# Converter a coordenada de volta para a posição no mundo (centro do tile)
	var world_pos = tilemap.map_to_world(tile_pos)
	#world_pos += tile_size / 2 # Ajusta para o centro do tile
	return world_pos
	
	

func enemy_to_tile():
	# Posição relativa do personagem principal em relação ao TileMap
	var rel_char_pos = personagem.position - tilemap.global_position

	# Posição relativa do inimigo em relação ao TileMap
	var rel_enemy_pos = enemy.position - tilemap.global_position

	# Convertendo as coordenadas do mundo para o sistema isométrico (personagem principal)
	var char_iso_y = (rel_char_pos.x / tile_size.x - rel_char_pos.y / tile_size.y)
	var char_iso_x = (rel_char_pos.y / tile_size.y + rel_char_pos.x / tile_size.x)
	
	# Convertendo as coordenadas do mundo para o sistema isométrico (inimigo)
	var enemy_iso_y = (rel_enemy_pos.x / tile_size.x - rel_enemy_pos.y / tile_size.y)
	var enemy_iso_x = (rel_enemy_pos.y / tile_size.y + rel_enemy_pos.x / tile_size.x)

	# Posições do personagem e do inimigo no grid
	var char_tile_pos = Vector2(round(char_iso_x), round(char_iso_y))
	var enemy_tile_pos = Vector2(round(enemy_iso_x), round(enemy_iso_y))

	# Calcular a direção para o personagem principal
	var direction = char_tile_pos - enemy_tile_pos

	# Limitar o movimento para no máximo 1 tile em qualquer direção
	var move_delta = Vector2(
		clamp(direction.x, -2, 2),
		clamp(direction.y, -2, 2)
	)

	# Nova posição do tile ajustada
	var new_tile_pos = enemy_tile_pos + move_delta

	# Verificar se o novo tile está dentro dos limites do grid isométrico
	if abs(new_tile_pos.x) > straight_radius or abs(new_tile_pos.y) > straight_radius or (abs(new_tile_pos.x) + abs(new_tile_pos.y)) > diagonal_radius:
		return Vector2(-1, -1)  # Retorna um valor inválido para indicar fora do grid

	# Converter a coordenada do tile de volta para a posição no mundo (centro do tile)
	var world_pos = tilemap.map_to_world(new_tile_pos)
	
	# Ajusta para o centro do tile (caso queira o centro do tile)
	world_pos += tile_size / 2

	return world_pos



# Função que calcula a próxima posição do inimigo
func calculate_enemy_move():
	# Posição atual do inimigo e do jogador
	var enemy_pos = enemy.position
	var player_pos = personagem.position

	# Converter posições para o grid
	var grid_enemy = enemy_pos
	var grid_player = player_pos

	# Depuração: Exibir posições no grid
	print("Posição do inimigo no mundo: ", enemy_pos)
	print("Posição do jogador no mundo: ", player_pos)
	print("Posição do inimigo no grid: ", grid_enemy)
	print("Posição do jogador no grid: ", grid_player)

	# Calcular a direção para o jogador
	var delta = grid_player - grid_enemy

	# Depuração: Exibir o delta entre o inimigo e o jogador
	print("Delta (direção para o jogador): ", delta)

	# Escolher o próximo movimento (prioridade para diagonais, depois retas)
	var next_move = grid_enemy  # Inicia sem movimento
	if abs(delta.x) == 2 and abs(delta.y) == 2:  # Movimento diagonal
		next_move = grid_enemy + Vector2(sign(delta.x), sign(delta.y)) * 2
		print("Movimento diagonal escolhido: ", next_move)
	elif abs(delta.x) > abs(delta.y):  # Movimento reto no eixo X
		next_move = grid_enemy + Vector2(sign(delta.x), 0)
		print("Movimento reto no eixo X escolhido: ", next_move)
	elif abs(delta.y) > abs(delta.x):  # Movimento reto no eixo Y
		next_move = grid_enemy + Vector2(0, sign(delta.y))
		print("Movimento reto no eixo Y escolhido: ", next_move)

	# Verificar se o movimento é válido
	var world_next_move = tilemap.map_to_world(next_move)
	
	# Depuração: Exibir a posição de destino no mundo
	print("Posição de destino no mundo: ", world_next_move)

	if is_move_valid(enemy_pos, world_next_move):
		print("Movimento válido!")
		enemy.position = world_next_move
	else:
		print("Movimento inválido!")

# Função que verifica se o movimento está dentro das restrições de 2 tiles diagonais e 1 tile reto
func is_move_valid(current_pos: Vector2, target_pos: Vector2) -> bool:
	# Converter a posição do personagem para o grid
	var grid_personagem = tilemap.world_to_map(current_pos)
	var grid_moveto = tilemap.world_to_map(target_pos)

	# Calcular a diferença entre o tile destino e a posição atual
	var delta = grid_moveto - grid_personagem

	# Verificar se o movimento é uma direção reta (1 tile em X ou Y)
	if abs(delta.x) == 1 and delta.y == 0:  # Movimento reto em X
		return true
	if abs(delta.y) == 1 and delta.x == 0:  # Movimento reto em Y
		return true
	
	# Verificar se o movimento é uma direção diagonal (2 tiles em ambos os eixos)
	if abs(delta.x) <= 0.5 and abs(delta.y) <= 0.5:  # Movimento diagonal
		return true

	# Se não for reta ou diagonal válida, retorna falso
	return false

# Função chamada ao clicar no mouse
func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		var mouse_pos = get_global_mouse_position()  # Posição global do mouse
		
		# Converte a posição do mouse para o centro do tile
		var tile_center = mouse_to_tile(mouse_pos)

		# Verifica se o tile está dentro do grid e se o movimento é válido
		if (personagem.pode_andar):
			if tile_center != Vector2(-1, -1) and is_move_valid(personagem.position, tile_center):  # Verifica se o clique está dentro do grid e do movimento permitido
				# Teleporta o personagem para o centro do tile
				personagem.position = tile_center
			
				enemy.position = enemy_to_tile()
