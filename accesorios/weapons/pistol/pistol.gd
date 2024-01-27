extends Node2D


#clip and mag size
var clip = 17
var mag = 2
#load bullet location
onready var bullet_path = "res://accesorios/projectile/projectile_bullet/projectile_bullet.tscn"
#instance the boolet
var bullet_instance: RigidBody
#spawn the boolet here
onready var bullet_spawn = $Muzzle
onready var animation_pew = $AnimationPlayer
var can_fire = true
onready var timer = $Timer
# Called when the node enters the scene tree for the first time.
#func _ready():
#	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("1"):
		can_fire = true
	if Input.is_action_just_pressed("2"):
		can_fire = false
	if Input.is_action_just_pressed("pew") && clip != 0 && can_fire == true:
		timer.start()
		animation_pew.play("shoot")
		clip = clip - 1
		can_fire = false
		#print("Current Clip = ",clip) ##TO DEBUG
		
	if Input.is_action_just_pressed("reload") && mag > 0:
		#print("Current mag = ",mag) ##TO DEBUG
		mag = mag - 1
		clip = 17

func _on_Timer_timeout():
	#print("can fire") ##todebug
	can_fire = true
