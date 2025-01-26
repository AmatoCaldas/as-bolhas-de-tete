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

@onready var main = get_parent()

func _ready():
	# Posicionar o personagem (Tete) no centro do tile inicial
	personagem.position = tilemap.map_to_world(initial_tete_tile) + tile_size / 2

	# Posicionar o inimigo (Enemy) no centro do tile inicial
	enemy.position = tilemap.map_to_world(initial_enemy_tile) + tile_size / 2



# Função chamada ao clicar no mouse
func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		var mouse_pos = get_global_mouse_position()  # Posição global do mouse
		
		# Converte a posição do mouse para o centro do tile
		var tile_center = main.mouse_to_tile(mouse_pos)

		# Verifica se o tile está dentro do grid e se o movimento é válido
		if (personagem.pode_andar):
			if tile_center != Vector2(-1, -1) and main.is_move_valid(personagem.position, tile_center):  # Verifica se o clique está dentro do grid e do movimento permitido
				# Teleporta o personagem para o centro do tile
				personagem.position = tile_center
			
				if main.is_move_valid(enemy.position, personagem.position):
					personagem.hp -= 1
					print("Player ",personagem.hp)
				else:
					enemy.position = main.enemy_to_tile()
		
		if (personagem.pode_bater):
			if(main.is_move_valid(personagem.position, tile_center) and tile_center == enemy.position):
				enemy.hp -= 1;
				print("Inimigo ",enemy.hp)
			
			if main.is_move_valid(enemy.position, personagem.position):
				personagem.hp -= 1
				print("Player ",personagem.hp)
			else:
					enemy.position = main.enemy_to_tile()
