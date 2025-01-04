extends CharacterBody2D

@export var speed = 80
@onready var animations = $AnimationPlayer
@onready var previousDirection: String = "down"
@onready var actionable_finder: Area2D = $direction/ActionableFinder
@export var shield_node: NodePath = "shield"
@export var attack_cost: int = 100  


func _ready():
	return
	



func handleInput():
	if Input.is_action_just_pressed("interact"):
		var actionables = actionable_finder.get_overlapping_areas()
		if actionables.size() > 0:
			actionables[0].action()
			return
	
	var moveDirection = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = moveDirection * speed
	
func updateAnimation():
	var direction = "down"
	if velocity.x < 0: direction = "left"
	elif velocity.x > 0: direction = "right"
	elif velocity.y < 0: direction = "up"
	elif velocity.y > 0: direction = "down"
	if velocity.length() == 0:
		animations.play("idle_" + previousDirection)
	else:
		animations.play("walk_" + direction)
		previousDirection = direction


func _physics_process(_delta):
	handleInput()
	move_and_slide()
	updateAnimation()
	
