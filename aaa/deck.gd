extends Node2D

const CARD_SCENE_PATH = "res://aaa/Cenas/carta.tscn"

var player_deck = ["res://aaa/SpritesCartas/Ataque.png", "res://aaa/SpritesCartas/Ataque.png","res://aaa/SpritesCartas/Ataque.png","res://aaa/SpritesCartas/Ataque.png","res://aaa/SpritesCartas/Ataque.png","res://aaa/SpritesCartas/Ataque.png","res://aaa/SpritesCartas/Ataque.png","res://aaa/SpritesCartas/Ataque.png","res://aaa/SpritesCartas/Ataque.png","res://aaa/SpritesCartas/Ataque.png","res://aaa/SpritesCartas/Ataque.png","res://aaa/SpritesCartas/Ataque.png","res://aaa/SpritesCartas/Ataque.png","res://aaa/SpritesCartas/Ataque.png","res://aaa/SpritesCartas/Ataque.png", 
 "res://aaa/SpritesCartas/Defesa.png", "res://aaa/SpritesCartas/Defesa.png", "res://aaa/SpritesCartas/Defesa.png", "res://aaa/SpritesCartas/Defesa.png", "res://aaa/SpritesCartas/Defesa.png", "res://aaa/SpritesCartas/Defesa.png", "res://aaa/SpritesCartas/Defesa.png", 
"res://aaa/SpritesCartas/Utilitario.png", "res://aaa/SpritesCartas/Utilitario.png", "res://aaa/SpritesCartas/Utilitario.png", "res://aaa/SpritesCartas/Utilitario.png", "res://aaa/SpritesCartas/Utilitario.png", "res://aaa/SpritesCartas/Utilitario.png", "res://aaa/SpritesCartas/Utilitario.png", "res://aaa/SpritesCartas/Utilitario.png", 
"res://aaa/SpritesCartas/Movimento.png", "res://aaa/SpritesCartas/Movimento.png", "res://aaa/SpritesCartas/Movimento.png", "res://aaa/SpritesCartas/Movimento.png", "res://aaa/SpritesCartas/Movimento.png"]
var card_database_reference

var card_drawn_name

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player_deck.shuffle()
	$RichTextLabel.text = str(player_deck.size())
	card_database_reference = preload("res://aaa/Scripts/CardDatabase.gd")
	card_drawn_name = player_deck[0]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func draw_card():
	if($"../PlayerHand".player_hand.size() < 3):
		print(player_deck.size())
		var card_drawn_name = player_deck[0]
		player_deck.erase(card_drawn_name)

		if player_deck.size() == 0:
			$Area2D/CollisionShape2D.disabled = true
			$Sprite2D.visible = false
			$RichTextLabel.visible = false
		# Precarregar a cena da carta e instanciar cartas
		$RichTextLabel.text = str(player_deck.size())
		var card_scene = preload(CARD_SCENE_PATH)
		var new_card = card_scene.instantiate()
		var card_image_path = card_drawn_name
		new_card.get_node("cartaSPR").texture = load(card_image_path)
		new_card.get_node("Ataque").text = str(card_database_reference.CARDS[card_drawn_name][0])
		new_card.get_node("Defesa").text = str(card_database_reference.CARDS[card_drawn_name][1])
		$"../Gerenciador".add_child(new_card)
		new_card.name = "Card"
		$"../PlayerHand".add_card_to_hand(new_card)
		
func acao_carta():
	# Verifica se existe uma carta sendo arrastada ou selecionada
	var selected_card = $"../Gerenciador".card_being_dragged
	
	if not selected_card:
		print("Nenhuma carta está selecionada.")
		return
	
	# Obtém o nome da carta sendo arrastada
	var selected_card_name = selected_card.get_node("cartaSPR").texture.resource_path
	print(selected_card_name)
	#basename(selected_card.get_node("cartaSPR").texture.resource_path)
	
	# Verifica se o nome da carta está no banco de dados
	if not card_database_reference.CARDS.has(selected_card_name):
		print("A carta selecionada não está no banco de dados.")
		return
	
	# Recupera os atributos da carta no banco de dados
	var card_data = card_database_reference.CARDS[selected_card_name]
	var id = card_data[0]
	var ataque = card_data[0]
	var defesa = card_data[1]
	
	if id == 1:#ATAQUE
		if $"..".used_card == true: 
			$"../Gerenciador".remove_child(selected_card)
			$"../PlayerHand".remove_card_to_hand(selected_card)
		
		return 1
	if id == 2:
		if $"..".used_card == true: 
			$"../Gerenciador".remove_child(selected_card)
			$"../PlayerHand".remove_card_to_hand(selected_card)
		
		return 2
	if id == 3:
		if $"..".used_card == true: 
			$"../Gerenciador".remove_child(selected_card)
			$"../PlayerHand".remove_card_to_hand(selected_card)
		
		return 3
	if id == 4:
		if $"..".used_card == true: 
			$"../Gerenciador".remove_child(selected_card)
			$"../PlayerHand".remove_card_to_hand(selected_card)
		
		return 4
	
	# Executa a ação com base nos atributos ou tipo da carta
	#if ataque > 0:
		#print("Executando ação de ataque com a carta:", selected_card_name)
		## Aqui você pode implementar a lógica específica do ataque
	#
	#elif defesa > 0:
		#print("Executando ação de defesa com a carta:", selected_card_name)
		## Aqui você pode implementar a lógica específica da defesa
	#
	#else:
		#print("Executando ação padrão para a carta:", selected_card_name)
	
	# Remove a carta da mão e do jogo após usar a ação

func basename(file_path: String) -> String:
	# Substitui separadores Windows (\) por UNIX (/) e divide o caminho
	file_path = file_path.replace("\\", "/")
	var parts = file_path.split("/")
	return parts[parts.size() - 1] if parts.size() > 0 else ""
