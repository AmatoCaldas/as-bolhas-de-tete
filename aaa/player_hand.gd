extends Node2D


const CARD_WIDTH = 80  # Largura da carta (considerada no espaço isométrico)
const CARD_HEIGHT = 40  # Altura da carta (considerada no espaço isométrico)
const TILE_SIZE = Vector2(64, 32)  # Tamanho de um tile isométrico (exemplo)
const SCREEN_WIDTH = 52  # Largura fixa da tela
const SCREEN_HEIGHT = 34  # Altura fixa da tela
const MARGIN = 100  # Margem das bordas

var player_hand
var bottom_right_position  # Posição base no canto inferior direito

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Definir a posição inicial no canto inferior direito
	bottom_right_position = Vector2(SCREEN_WIDTH + (MARGIN*3), SCREEN_HEIGHT + MARGIN)
	player_hand = []
	


func add_card_to_hand(card):
	if player_hand == null:
		print("erro")
	player_hand.insert(0, card)
	print(player_hand)
	update_hand_positions()

func update_hand_positions():
	print("Atualizando")
	for i in range(player_hand.size()):
		var new_position = calculate_card_position(i)
		var card = player_hand[i]
		animate_card_to_position(card, new_position)

func calculate_card_position(index):
	# Base no canto inferior direito e ajustando para o grid isométrico
	var base_x = bottom_right_position.x - index * (CARD_WIDTH)
	var base_y = bottom_right_position.y - (index/4) * (CARD_HEIGHT / 2)
	return Vector2(base_x, base_y)

func animate_card_to_position(card, new_position):
	var tween = get_tree().create_tween()
	card.position = new_position
