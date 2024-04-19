extends CharacterBody3D

@onready var root = get_tree().get_root()
var bullet

const SPEED = 5.0
const JUMP_VELOCITY = 4.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	bullet = preload("res://scenes/bullet/bullet.tscn")

func _physics_process(delta):
	# tanks cant jump
	if not is_on_floor():
		velocity.y -= gravity * delta
		
	if Input.is_action_just_pressed("fire"):
		var bullet_instance = bullet.instantiate()
		bullet_instance.rotation.y = self.rotation.y
		bullet_instance.position.y = 1.249 
		
		bullet_instance.position.x = self.position.x
		bullet_instance.position.z = self.position.z
		
		root.add_child(bullet_instance)

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
