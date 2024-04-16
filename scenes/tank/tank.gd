extends Node3D

@export var SPEED = 5.0
@export var TURN_RADIUS = deg_to_rad(2.0)

@onready var root = get_tree().get_root()

var bullet
# Called when the node enters the scene tree for the first time.

func _ready():
	bullet = preload("res://scenes/bullet/bullet.tscn").instantiate()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("ui_left"):
		self.rotation.y += TURN_RADIUS
	elif Input.is_action_pressed("ui_right"):
		self.rotation.y -= TURN_RADIUS 
	
	# trigonometry is my friend
	if Input.is_action_pressed("ui_up"):
		self.position.x += sin(self.rotation.y) * SPEED * delta
		self.position.z += cos(self.rotation.y) * SPEED * delta
	if Input.is_action_pressed("ui_down"):
		self.position.x -= sin(self.rotation.y) * SPEED * delta
		self.position.z -= cos(self.rotation.y) * SPEED * delta

	# add count down, not let people shoot tomuch
	if Input.is_action_just_pressed("fire"):
		root.add_child(bullet)
	

