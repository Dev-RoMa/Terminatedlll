extends KinematicBody

var move_direction = Vector3()

# Declare member variables here. Examples:
var gravity = 9.8
var hp = 100
var speed = 0.001
var sprite_1
var sprite_2
var sprite_3
var sprite_4
var raycast


# Called when the node enters the scene tree for the first time.
func _ready():
	sprite_1 = get_node("sprite_1")
	sprite_1.visible = true
	sprite_2 = get_node("sprite_2")
	sprite_2.visible = false
	sprite_3 = get_node("sprite_3")
	sprite_3.visible = false
	sprite_4 = get_node("sprite_4")
	sprite_4.visible = false
	##raycast will be the "face" of the npc
	raycast = get_node("RayCast")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#walk the npc forward
	move_direction -= global_transform.basis.z
	move_and_slide(move_direction * speed)
	
	#dead npc
	if hp <= 0:
		speed = 0
		#print("dead") #TO DEBUG
	_change_color()
func _physics_process(delta):
	
	##add gravity lmao
	if not is_on_floor():
		move_and_collide(-global_transform.basis.y.normalized() * gravity * delta)

##TO DETECT HITS
func _on_Area_body_entered(body):
	#print(body.name) #USE THIS TO DEBUG
	#hits the npc lowering its hp
	if body.name =="projectile_bllt":
		hp -= 10
		print(hp)

##TO DETECT THE PLAYER THRU AREA

func _change_color():
	#green
	#yellow
	if hp == 70:
		sprite_1.visible = false
		sprite_2.visible = true
	elif hp == 30:
	#orange
		sprite_2.visible = false
		sprite_3.visible = true
	#red
	elif hp == 0:
		sprite_3.visible = false
		sprite_4.visible = true



func _on_Area2_body_entered(body):
	if body.name == "player":
		print("player entered npc area")

##colors
#colors change with HP
# 100 = green
# 90 - 50 yellow
# 50 - 20 orange
# 20 - 0 red
#var green = "res://accesorios/sprites/npc/npc_test/g_npc.png"
#var yellow = "res://accesorios/sprites/npc/npc_test/y_npc.png"
#var orange = "res://accesorios/sprites/npc/npc_test/o_npc.png"
#var red = "res://accesorios/sprites/npc/npc_test/r_npc.png"
