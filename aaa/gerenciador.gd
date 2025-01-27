extends Node2D

var card_being_dragged

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if card_being_dragged:
		pass
		#var mouse_pos = get_global_mouse_position()
		#card_being_dragged.position = mouse_pos

#func _input(event):
	#if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		#if event.pressed:
			#var card = raycast_check_for_card()
			#if card:
				#card_being_dragged = card
		#else:
			#card_being_dragged = null
			
func connect_card_signals(card):
	card.connect("hovered", on_hovered_over_card)
	card.connect("hovered_off", on_hovered_off_card)
	

func on_hovered_over_card(card):
	highlight_card(card, true)
	
func on_hovered_off_card(card):
	highlight_card(card, false)
	
func highlight_card(card, hovered):
	if hovered:
		card.scale = Vector2(1.05, 1.05)
		card.z_index = 2
	else: 
		card.scale = Vector2(1, 1)
		card.z_index = 1

func  raycast_check_for_card():
	var space_state = get_world_2d().direct_space_state
	var parameters = PhysicsPointQueryParameters2D.new()
	parameters.position = get_global_mouse_position()
	parameters.collide_with_areas = true
	parameters.collision_mask = 1
	var result = space_state.intersect_point(parameters)
	if result.size() > 0:
		return result[0].collider.get_parent()
	return null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$"../InputManager".connect("left_mouse_button_clicked", on_left_click_clicked) # Replace with function body.

func on_left_click_clicked():
	if card_being_dragged:
		finish_drag()
	
func start_drag(card):
	card_being_dragged = card
	card.scale = Vector2(1,1)
	card_being_dragged.modulate = Color(0,1,0)
	
func finish_drag():
	card_being_dragged.scale = Vector2(1.05, 1.05)
	card_being_dragged.modulate = Color(1,1,1)
