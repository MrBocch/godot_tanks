extends Area3D

@export var SPEED = 16.0

var bounces = 0
var BOUNCE_LIMIT = 3
var acceleration = {"x": 1, "z": 1}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.position.x +=  acceleration.x * sin(self.rotation.y) * SPEED * delta
	self.position.z += acceleration.z * cos(self.rotation.y) * SPEED * delta
	
	if bounces > BOUNCE_LIMIT:
		free_bullet()

func free_bullet():
	queue_free()
