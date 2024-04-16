extends Area3D

@export var SPEED = 15.0

var BOUNCES = 0
var BOUNCE_LIMIT = 3

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.position.x += sin(self.rotation.y) * SPEED * delta
	self.position.z += cos(self.rotation.y) * SPEED * delta

