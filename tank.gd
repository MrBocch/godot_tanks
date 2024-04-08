extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	print("hi")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("ui_left"):
		self.rotation.y += 0.1
	elif Input.is_action_pressed("ui_right"):
		self.rotation.y -= 0.1
		
	# how do i make it so that the tank 
	# only "moves forward" as in, the 
	# place its facing in?
	var forward = global_transform.basis.z.normalized()
	translate(forward * 0.01)
