extends CharacterBody3D

@onready var root = get_tree().get_root()
@onready var barrel_end = $Marker3D

@export_group("controlls")
@export var turn_right = "ui_right"
@export var turn_left = "ui_left"
@export var forward = "ui_up"
@export var backward = "ui_down"
@export var fire = "fire"

@onready var materials = {
	"red": load("res://scenes/tank/red.tres"),
	"blue": load("res://scenes/tank/blue.tres"),
	"grey": load("res://scenes/tank/grey.tres"),
	"green": load("res://scenes/tank/green.tres")
}
@onready var meshes = {
	"body": $body,
	"head": $head,
	"barrel": $head/barrel
}
@export_group("color")
@export_enum("red", "green", "blue", "grey") var color: String


const SPEED = 7.0
const TURN_RADIUS = 2.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

var bullet
func _ready():
	bullet = preload("res://scenes/bullet/bullet.tscn")
	meshes["body"].set_material_override(materials[color])
	meshes["head"].set_material_override(materials[color])
	meshes["barrel"].set_material_override(materials[color])

func _physics_process(delta):

	# tanks cant jump
	if not is_on_floor():
		velocity.y -= gravity * delta
		

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	if is_on_floor():
		if Input.is_action_just_pressed(fire):
			
			var bullet_instance = bullet.instantiate()
			bullet_instance.rotation.y = self.rotation.y

			bullet_instance.position = barrel_end.global_position
			root.add_child(bullet_instance)

		
		var input_dir = Input.get_vector("","",backward, forward)
		var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
		if direction:
			velocity.x = direction.x * SPEED
			velocity.z = direction.z * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			velocity.z = move_toward(velocity.z, 0, SPEED)
	
		if Input.is_action_pressed(turn_left):
			self.rotation.y += TURN_RADIUS * delta
		elif Input.is_action_pressed(turn_right):
			self.rotation.y -= TURN_RADIUS * delta
	
	move_and_slide()


func _on_area_3d_area_entered(area):
	area.free_bullet()
