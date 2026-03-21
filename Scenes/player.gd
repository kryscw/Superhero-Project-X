extends CharacterBody2D

const ACCELERATION: float = 50.0
const FRICTION: float = 25.0
const GRAVITY: float = 20.0
var currentSpeed: float = 300.0

@export var jumpHeight : float = 50.0
@export var jumpTimeToPeak : float = 0.2
@export var jumpTimeToDescent : float = 0.1
@onready var jumpVelocity: float = ((2.0 * jumpHeight) / jumpTimeToPeak) * -1

var health: int = 100

func _physics_process(delta: float) -> void:
	
	var input_dir : Vector2 = getInput()
	
	calcJump()
	
	if input_dir != Vector2.ZERO:
		addAcceleration(input_dir)
	else:
		addFriction()
	
	move_and_slide()

func calcJump():
	if Input.is_action_just_pressed("jump") && is_on_floor():
		velocity.y = jumpVelocity
		#$jump.play()
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
