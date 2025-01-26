extends Area2D

@export var tile_size: Vector2 = Vector2(64, 32)  # Tamanho do tile no seu TileSet (64x32)

# Limites do grid
@export var straight_radius: int = 4  # Limite para direções retas (eixos X e Y)
@export var diagonal_radius: int = 8  # Limite para direções diagonais


# Propriedades para definir as posições iniciais no grid
@export var initial_tete_tile: Vector2i = Vector2i(-3, -3)  # Posição inicial do Tete
@export var initial_enemy_tile: Vector2i = Vector2i(3, 3)  # Posição inicial do Enemy

@onready var grid = get_parent()
@onready var main = get_node(".")
@onready var personagem = get_node("/root/main/Grid/Tete")
@onready var carta_spr: Sprite2D = $carta1spr  # Referência ao sprite

var current_grid_position = Vector2(0, 0)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
