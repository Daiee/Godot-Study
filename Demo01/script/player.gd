extends Area2D

signal hit

@export var speed: int = 400

var screen_size: Vector2

func _ready() -> void:
	screen_size = get_viewport_rect().size
	hide()


func _process(delta: float) -> void:
	#var velocity = Vector2.ZERO
	#if Input.is_action_pressed("move_right"):
		#velocity.x += 1
	#if Input.is_action_pressed("move_left"):
		#velocity.x -= 1
	#if Input.is_action_pressed("move_down"):
		#velocity.y += 1
	#if Input.is_action_pressed("move_up"):
		#velocity.y -= 1
	
	# NOTICE 优化
	var x_vector: float = Input.get_axis("move_left", "move_right")
	var y_vector: float = Input.get_axis("move_up", "move_down")
	var velocity := Vector2(x_vector, y_vector) 

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
		
	self.position += velocity * delta
	self.position = position.clamp(Vector2.ZERO, screen_size)
	
	if velocity.x != 0:
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_v = false
		$AnimatedSprite2D.flip_h = velocity.x < 0
	else:
		$AnimatedSprite2D.animation = "up"
		$AnimatedSprite2D.flip_v = velocity.y < 0


func _on_body_entered(_body) -> void:
	hide()
	hit.emit()
	$CollisionShape2D.set_deferred("disabled", true)


func start(pos: Vector2) -> void:
	self.position = pos
	show()
	$CollisionShape2D.disabled = false
	
	
	
