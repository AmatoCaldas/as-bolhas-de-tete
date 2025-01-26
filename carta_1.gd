extends Node2D


@onready var personagem = get_node("Grid/Tete")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		var mouse_pos = get_global_mouse_position()
		print("Deu")
		
func is_mouse_over(mouse_pos: Vector2, collision: CollisionShape2D) -> bool:
	if(collision.get_rect().has_point(mouse_pos)):
		return true
