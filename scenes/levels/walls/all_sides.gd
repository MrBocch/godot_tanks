extends StaticBody3D

# want to be able to edit its dimensions thrue editor
@export var length: int

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_area_3d_area_entered(bullet):
	bullet.bounces += 1
	bullet.acceleration.z *= -1


func _on_short_sides_area_entered(bullet):
	bullet.bounces += 1
	bullet.acceleration.x *= -1
