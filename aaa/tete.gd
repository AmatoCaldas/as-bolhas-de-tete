extends Node2D


# Called when the node enters the scene tree for the first time.

# Called every frame. 'delta' is the elapsed time since the previous frame.

var current_grid_position = Vector2(0, 0)

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

#func _process(delta):
	#if Input.is_action_just_pressed("ui_up"):
		#current_grid_position.y -= 1
	#elif Input.is_action_just_pressed("ui_down"):
		#current_grid_position.y += 1
	#elif Input.is_action_just_pressed("ui_left"):
		#current_grid_position.x -= 1
	#elif Input.is_action_just_pressed("ui_right"):
		#current_grid_position.x += 1
	#position = grid_to_world(current_grid_position)
