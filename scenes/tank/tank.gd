extends Node3D

@export var SPEED = 12.0
@export var TURN_RADIUS = deg_to_rad(2.0)

@onready var root = get_tree().get_root()
@onready var barrel_location = $barrel
@onready var timer = $cooldown

var can_shoot = true
var bullets = 4

var bullet

# Called when the node enters the scene tree for the first time.

func _ready():
	bullet = preload("res://scenes/bullet/bullet.tscn")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# also have to multiply by delta correct?
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
	if Input.is_action_just_pressed("fire") and can_shoot and bullets:
		bullets -= 1
		if bullets == 0:
			timer.start()
		
		var bullet_instance = bullet.instantiate()
		bullet_instance.rotation.y = self.rotation.y
		bullet_instance.position.y = 1.249 
		
		bullet_instance.position.x = self.position.x
		bullet_instance.position.z = self.position.z
		
		root.add_child(bullet_instance)
		
		


# were is the gun located?, pointing to? 
func gun_point():
	# x = 0
	# y = 1.249 + (radius of bullet)/2?
	# z = 1.243 
	pass


func _on_timer_timeout():
	can_shoot = true
	bullets = 4
