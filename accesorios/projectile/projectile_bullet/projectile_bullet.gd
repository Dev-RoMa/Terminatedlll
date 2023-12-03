extends RigidBody

# Declare member variables here. Examples:

# Called when the node enters the scene tree for the first time.
#func _ready():
#	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.gravity_scale = 9.8

func _physics_process(delta):
	translation += get_transform().basis.z*-100*delta


func _on_Area_body_entered(body):
	#if body.name == "player":
		#queue_free()
	if body.is_in_group("col"):
		#print("collided!", body)
		queue_free()
