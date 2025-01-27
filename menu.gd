extends Control
class_name MainMenu
@onready var music_player =  $musica # Referência ao nó AudioStreamPlayer

func _ready() -> void:
	var music = load("res://resources/musica.wav")  # Carregar o arquivo de áudio
	music_player.stream = music  # Definir o stream de áudio
	music_player.play()  # Tocar a música
	for _button in get_tree().get_nodes_in_group("Buttons"):
		_button.pressed.connect(_on_button_pressed.bind(_button))

func _on_button_pressed(_button: Button) -> void:
	match _button.name:
		"NewGame":
			get_tree().change_scene_to_file("res://aaa/main.tscn")
