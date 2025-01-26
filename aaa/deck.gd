extends Node2D

const CARD_SCENE_PATH = "res://Cenas/carta.tscn"

var player_deck = ["Ataque", "Ataque", "Ataque"]


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func draw_card():
	var card_drawn = player_deck[0]
	player_deck.erase(card_drawn)
	
	if player_deck.size() == 0:
		$Area2D/CollisionShape2D.disabled = true
		$Sprite2D.visible = false
	
	# Precarregar a cena da carta e instanciar cartas
	var card_scene = preload(CARD_SCENE_PATH)
	
	for i in range(player_deck.size()):
		var new_card = card_scene.instantiate()
		$"../Gerenciador".add_child(new_card)
		new_card.name = "Card"
		$"../PlayerHand".add_card_to_hand(new_card)
