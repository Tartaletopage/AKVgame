
extends Node2D

# Ссылка на игрока
@export var player: Node2D
# Префаб снаряда
@export var bullet_scene: PackedScene
# Время между появлениями снарядов
@export var spawn_interval: float = 1.0

# Таймер для появления снарядов
var spawn_timer: float = 0.0

func _process(delta: float) -> void:
	# Увеличиваем таймер
	spawn_timer += delta
	if spawn_timer >= spawn_interval:
		spawn_timer = 0.0
		spawn_bullet()

func spawn_bullet() -> void:
	# Проверяем, что игрок существует
	if not player or not is_instance_valid(player):
		return
	
	# Выбираем случайный край экрана
	var screen_size = get_viewport_rect().size
	var position: Vector2
	var direction: Vector2

	match randi() % 4:
		0:  # Верхний край
			position = Vector2(randi() % int(screen_size.x), 0)
		1:  # Нижний край
			position = Vector2(randi() % int(screen_size.x), screen_size.y)
		2:  # Левый край
			position = Vector2(0, randi() % int(screen_size.y))
		3:  # Правый край
			position = Vector2(screen_size.x, randi() % int(screen_size.y))

	# Создаём снаряд
	var bullet = bullet_scene.instantiate()
	add_child(bullet)
	bullet.position = position

	# Задаём направление к игроку
	direction = (player.global_position - position).normalized()
	bullet.look_at(player.global_position)
	
	# Передаём направление снаряду
	if bullet.has_method("initialize"):
		bullet.initialize(direction)
