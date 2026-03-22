extends CharacterBody2D

const ACCELERATION: float = 50.0
const FRICTION: float = 25.0
const GRAVITY: float = 20.0
var currentSpeed: float = 300.0
var damageDealing: int = 25

@export var jumpHeight : float = 50.0
@export var jumpTimeToPeak : float = 0.2
@export var jumpTimeToDescent : float = 0.1
@onready var jumpVelocity: float = ((2.0 * jumpHeight) / jumpTimeToPeak) * -1

var health: int = 100
var dash: int = 100

@onready var main = get_tree().current_scene

func _physics_process(_delta: float) -> void:
	
	if health <= 0:
		$"../CanvasLayer/deathbeUponYe".show()
		queue_free()
	
	$CanvasLayer/healthBar.value = health
	
	var input_dir : Vector2 = getInput()
	
	calcJump()
	
	if input_dir != Vector2.ZERO:
		addAcceleration(input_dir)
	else:
		addFriction()
	
	if Input.is_action_just_pressed("dash") && self.get_collision_layer_value(2) == true && dash == 100:
		velocity.x += input_dir.x * 1800
		self.set_collision_layer_value(2, false)
		self.set_collision_mask_value(2, false)
		$Area2D/CollisionShape2D.disabled = true
		$afterImage.emitting = true
		$CanvasLayer/dashTimer.start()
		dash = 0
		$CanvasLayer/dashBar.value = dash
		await get_tree().create_timer(0.5).timeout
		self.set_collision_layer_value(2, true)
		self.set_collision_mask_value(2, true)
		$Area2D/CollisionShape2D.disabled = false
		$afterImage.emitting = false
	
	if main.gameStarted:
		move_and_slide()
	


func calcJump():
	if Input.is_action_just_pressed("jump") && is_on_floor():
		velocity.y = jumpVelocity
	else:
		velocity.y += GRAVITY

func getInput() -> Vector2:
	return Vector2(Input.get_axis("left", "right"), 0.0).normalized()

## Apply acceleration to body.
func addAcceleration(dir) -> void:
	velocity.x = velocity.move_toward(currentSpeed * dir, ACCELERATION).x

## Apply friction to body.
func addFriction() -> void:
	velocity.x = velocity.move_toward(Vector2.ZERO, FRICTION).x


func damage_area_entered(_body_rid: RID, body: Node2D, _body_shape_index: int, _local_shape_index: int) -> void:
	if body.name.contains("Enemy"): health -= body.damageDealing
	if body.is_in_group("evil bullets"): body.queue_free(); health -= 25


func _on_dash_timer_timeout() -> void:
	dash += 5
	$CanvasLayer/dashBar.value = dash
	if dash == 100:
		$CanvasLayer/dashTimer.stop()
