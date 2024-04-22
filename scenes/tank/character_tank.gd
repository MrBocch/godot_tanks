extends CharacterBody3D

@onready var root = get_tree().get_root()
@onready var barrel_end = $Marker3D
var bullet

const SPEED = 7.0
const TURN_RADIUS = 2.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	bullet = preload("res://scenes/bullet/bullet.tscn")

func _physics_process(delta):
	

	# tanks cant jump
	if not is_on_floor():
		velocity.y -= gravity * delta
		

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	if is_on_floor():
		if Input.is_action_just_pressed("fire"):
			
			var bullet_instance = bullet.instantiate()
			bullet_instance.rotation.y = self.rotation.y

			bullet_instance.position = barrel_end.global_position
			root.add_child(bullet_instance)

		
		var input_dir = Input.get_vector("","","ui_down", "ui_up")
		var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
		if direction:
			velocity.x = direction.x * SPEED
			velocity.z = direction.z * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			velocity.z = move_toward(velocity.z, 0, SPEED)
	
		if Input.is_action_pressed("ui_left"):
			self.rotation.y += TURN_RADIUS * delta
		elif Input.is_action_pressed("ui_right"):
			self.rotation.y -= TURN_RADIUS * delta
	
	move_and_slide()


func _on_area_3d_area_entered(area):
	print("shoot by a bullet?")
	area.free_bullet()
