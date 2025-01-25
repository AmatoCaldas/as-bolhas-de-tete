extends Node2D

@export var tile_size: Vector2 = Vector2(32, 32)  # Tamanho de cada tile
@export var grid_width: int = 10  # Largura do grid (em tiles)
@export var grid_height: int = 10  # Altura do grid (em tiles)
@onready var personagem: CharacterBody2D = $Personagem  # Referência ao personagem

# Função chamada ao clicar no mouse
func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		var mouse_pos = get_global_mouse_position()
		
		# Converte a posição do mouse para a posição do tile
		var tile_pos = floor(mouse_pos / tile_size) * tile_size
		
		# Verifica se o tile está dentro dos limites do grid
		if tile_pos.x >= 0 and tile_pos.x < grid_width * tile_size.x and tile_pos.y >= 0 and tile_pos.y < grid_height * tile_size.y:
			# Teleporta o personagem para a posição do tile
			personagem.position = tile_pos
