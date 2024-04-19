extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass





# when bullet collides with walls
# assuming that area is a bullet
# no long have to this, bc have the signal
# the node
#func _on_left_area_entered(area):
	#area.bounces += 1
	#area.acceleration.z *= -1
#
#func _on_right_area_entered(area):
	#area.bounces += 1
	#area.acceleration.z *= -1
#
#func _on_top_area_entered(area):
	#area.bounces += 1
	#area.acceleration.x *= -1
#
#func _on_bot_area_entered(area):
	#area.bounces += 1
	#area.acceleration.x *= -1
