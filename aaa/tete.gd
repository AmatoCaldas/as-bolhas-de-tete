extends Node2D


# Called when the node enters the scene tree for the first time.

# Called every frame. 'delta' is the elapsed time since the previous frame.

var current_grid_position = Vector2(0, 0)
var pode_andar = false;
var pode_bater = false;
var hp = 10;

func grid_to_world(grid_position: Vector2) -> Vector2:
	var cell_size = Vector2(64, 32)  # Ajuste com base no tamanho do tile
	return Vector2(
		(grid_position.x - grid_position.y) * (cell_size.x / 2),
		(grid_position.x + grid_position.y) * (cell_size.y / 2)
	)

func world_to_grid(world_position: Vector2) -> Vector2:
	var cell_size = Vector2(64, 32)  # Ajuste com base no tamanho do tile
	return Vector2(
		int((world_position.x / (cell_size.x / 2) + world_position.y / (cell_size.y / 2)) / 2),
		int((world_position.y / (cell_size.y / 2) - world_position.x / (cell_size.x / 2)) / 2)
	)

func _ready():
	position = grid_to_world(current_grid_position)

func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		pode_andar = true;
		pode_bater = false;
		print("Anda")
	elif Input.is_action_just_pressed("ui_cancel"):
		pode_andar = false;
		pode_bater = true;
		print("Taca Carta")
