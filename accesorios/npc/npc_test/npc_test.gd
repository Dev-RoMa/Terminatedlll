extends KinematicBody

var move_direction = Vector3()

# Declare member variables here. Examples:
var gravity = 9.8
var hp = 100
var speed = 0.001

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#walk the npc forward
	move_direction -= global_transform.basis.z
	move_and_slide(move_direction * speed)
	
	#dead npc
	if hp <= 0:
		speed = 0
		print("dead")

func _physics_process(delta):
	
	##add gravity lmao
	if not is_on_floor():
		move_and_collide(-global_transform.basis.y.normalized() * gravity * delta)


func _on_Area_body_entered(body):
	print(body.name) #USE THIS TO DEBUG
	#hits the npc lowering its hp
	if body.name =="projectile_bllt":
		hp -= 10
