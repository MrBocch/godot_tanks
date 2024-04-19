extends StaticBody3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_3d_area_entered(bullet):
	# sometimes the tank could rub on it the wrong way
	if typeof(bullet) == 24:
		bullet.bounces += 1
		bullet.acceleration.z *= -1
	
