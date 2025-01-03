extends Control

@export var timer_limit: float = 5.0
var balls_clicked: int = 0
var timer : Timer


func _ready():
	timer = $TimerMG
	
	timer.timeout.connect(_lose_game())
	
	for child in $PanelMG.get_children():
		if child is TextureButton:
			child.pressed.connect(_on_ball_pressed)
	
	_start_game()


func _on_ball_pressed():
	balls_clicked += 1
	if balls_clicked >= 3:
		timer.stop()
		finish_game()

func _lose_game():
	$LabelMG.text = "LOSER"
	$LabelMG.visible = true
	_start_game()
	

func _start_game():
	balls_clicked = 0
	randomize_ball_positions()
	timer.start(timer_limit)
	
	for child in $PanelMG.get_children():
		if child is TextureButton:
			child.visible = true
	

func randomize_ball_positions():
	var panel_rect = $PanelMG.get_rect
	for child in $PanelMG.get_children():
		if child is TextureButton:
			child.global_position = Vector2(
			randi_range(panel_rect.position.x + 50, panel_rect.position.x + panel_rect.size.x - 50),
			randi_range(panel_rect.position.y + 50, panel_rect.position.y + panel_rect.size.y - 50)
			)


func finish_game():
	$LabelMG.text = "WIN"
	$LabelMG.visible = true
	
	for child in $PanelMG.get_children():
		if child is TextureButton:
			child.visible = false
