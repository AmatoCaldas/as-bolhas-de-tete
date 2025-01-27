extends Node2D

@export var tile_size: Vector2 = Vector2(64, 32)  # Tamanho do tile no seu TileSet (64x32)
@onready var tilemap: TileMap = $TileMap  # Referência ao TileMap
@onready var personagem: Node2D = $Tete  # Referência ao personagem
@onready var enemy: Node2D = $Enemy # Referência ao inimigo
@onready var music_player = $music

# Limites do grid
@export var straight_radius: int = 4  # Limite para direções retas (eixos X e Y)
@export var diagonal_radius: int = 8  # Limite para direções diagonais


# Propriedades para definir as posições iniciais no grid
@export var initial_tete_tile: Vector2i = Vector2i(-3, -3)  # Posição inicial do Tete
@export var initial_enemy_tile: Vector2i = Vector2i(3, 3)  # Posição inicial do Enemy

@onready var main = get_parent()

var used_card
var turno

func _ready():
	turno = 0
	var music = load("res://resources/musica.wav")  # Carregar o arquivo de áudio

	music_player.stream = music  # Definir o stream de áudio

	music_player.play()  # Tocar a música
	# Posicionar o personagem (Tete) no centro do tile inicial
	personagem.position = tilemap.map_to_world(initial_tete_tile) + tile_size / 2

	# Posicionar o inimigo (Enemy) no centro do tile inicial
	enemy.position = tilemap.map_to_world(initial_enemy_tile) + tile_size / 2

func _process(delta):
	if enemy.hp <= 0:
		remove_child(enemy)
		get_tree().change_scene_to_file("res://menu.tscn")

	elif personagem.hp <= 0:
		remove_child(personagem)
		get_tree().change_scene_to_file("res://menu.tscn")

# Função chamada ao clicar no mouse
func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		var mouse_pos = get_global_mouse_position()  # Posição global do mouse
		
		# Converte a posição do mouse para o centro do tile
		var tile_center = main.mouse_to_tile(mouse_pos)
		var tile_center_card = main.mouse_to_tile_card(mouse_pos)

		# Verifica se o tile está dentro do grid e se o movimento é válido
		if (personagem.pode_andar):
			if tile_center != Vector2(-1, -1) and main.is_move_valid(personagem.position, tile_center):  # Verifica se o clique está dentro do grid e do movimento permitido
				# Teleporta o personagem para o centro do tile
				personagem.position = tile_center
			
				if main.is_move_valid(enemy.position, personagem.position):
					personagem.hp -= 1
					print("Player ",personagem.hp)
					turno += 1
				else:
					enemy.position = main.enemy_to_tile()
					turno += 1
		
		if (personagem.pode_bater):
			if ($Gerenciador.card_being_dragged):
				print('1')
				if tile_center_card != Vector2(-1, -1) and main.is_move_valid(personagem.position, tile_center_card):
					print('2')
					if $Deck.acao_carta() == 1:
						print("A")
						print(tile_center_card)
						print(enemy.position)
						if tile_center_card == enemy.position:
							enemy.hp -= 1
							used_card = true
							$Deck.acao_carta()
							used_card = false
							if main.is_move_valid(enemy.position, personagem.position):
								personagem.hp -= 1
								turno += 1
							else:
								enemy.position = main.enemy_to_tile()
								turno += 1
								
								
					elif $Deck.acao_carta() == 2:
						print("D")
						if tile_center_card == personagem.position:
							personagem.hp += 1
							used_card = true
							$Deck.acao_carta()
							used_card = false
							if main.is_move_valid(enemy.position, personagem.position):
								personagem.hp -= 1
								turno += 1
							else:
								enemy.position = main.enemy_to_tile()
								turno += 1
								
					elif $Deck.acao_carta() == 4:
						print("U")
						if tile_center_card == enemy.position:
							enemy.hp -= 3
							used_card = true
							$Deck.acao_carta()
							used_card = false
							if main.is_move_valid(enemy.position, personagem.position):
								personagem.hp -= 1
								turno += 1
							else:
								enemy.position = main.enemy_to_tile()
								turno += 1
								
								
					else:
							used_card = false
				if tile_center != Vector2(-1, -1) and $Deck.acao_carta() == 3:
					print("M")
					personagem.position = tile_center
					used_card = true
					$Deck.acao_carta()
					used_card = false
					if main.is_move_valid(enemy.position, personagem.position):
						personagem.hp -= 1
						turno += 1
						
						
					else:
						enemy.position = main.enemy_to_tile()
						turno += 1
						
						
			#if(main.is_move_valid(personagem.position, tile_center) and tile_center == enemy.position):
				#enemy.hp -= 1;
				#print("Inimigo ",enemy.hp)
					
		
