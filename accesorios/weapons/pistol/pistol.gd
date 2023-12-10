extends Node2D

# Declare member variables here. Examples:
var clip = 17
var mag = 2

onready var animation_pew = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
#func _ready():
#	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("pew") && clip != 0:
		animation_pew.play("shoot")
		clip = clip - 1
		#print("Current Clip = ",clip)
		#print("pew pew!") ##TO DEBUG
	if Input.is_action_just_pressed("reload") && mag > 0:
		mag = mag - 1
		clip = 17
