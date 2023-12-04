extends KinematicBody

##movement
var move_direction = Vector3()
var speed = 10
var rotation_speed = 1.0
var rotation_vector = Vector2()
var gravity = 9.8
var current_gun = 0

##pewing
#this stuff will spawn the boolet on the scene!!!
onready var bullet_path = "res://accesorios/projectile/projectile_bullet/projectile_bullet.tscn"
onready var bullet_sfx = $pew_sfx
var bullet_instance: RigidBody
var bullet_location
onready var pistol_scn = $pistol

var rate_of_fire = 1

##import self stuf

var timer

func _ready():
	bullet_location = get_node("player_muz")
	timer = get_node("Timer")

func _process(delta):
	##player movement and rotation
	#movement
	if Input.is_action_pressed("ui_up"):
		move_direction -= global_transform.basis.z
	else:
		move_direction = Vector3.ZERO
	if Input.is_action_pressed("ui_down"):
		move_direction += global_transform.basis.z
	if Input.is_action_pressed("ui_left"):
		move_direction -= global_transform.basis.x
	if Input.is_action_pressed("ui_right"):
		move_direction += global_transform.basis.x
	move_direction.y 
	move_direction = move_direction.normalized()
	
	if move_direction != Vector3.ZERO:
		move_and_slide(move_direction * speed)
	else:
		move_and_slide(Vector3.ZERO)

	#rotation
	if Input.is_action_pressed("shift"):
		rotation_vector.x -= Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")# && Input.is_action_pressed("shift")
		rotation_vector = rotation_vector.normalized() * rotation_speed * delta
	else:
		rotation_vector = Vector2.ZERO
	if rotation_vector != Vector2.ZERO:
		rotate_y(rotation_vector.x)
		rotate_x(rotation_vector.y)
	
	##add gravity lol
	if not is_on_floor():
		move_and_collide(-global_transform.basis.y.normalized() * gravity * delta)
		rotate_y(rotation_vector.x)
		rotate_x(rotation_vector.y)

	#spawn bullet I guess
	if Input.is_action_just_pressed("pew") && current_gun == 1:
		bullet_sfx.play()
		var bullet_scene = load(bullet_path)
		bullet_instance = bullet_scene.instance()
		add_child(bullet_instance)
		bullet_instance.set_as_toplevel(true)
		bullet_instance.global_transform.origin = bullet_location.global_transform.origin
		
	if Input.is_action_just_pressed("1"):
		pistol_scn.visible = true
		current_gun = 1
		print("gun selected", current_gun)
		
	elif Input.is_action_just_pressed("2"):
		pistol_scn.visible = false
		current_gun = 2
		print("gun selected", current_gun)
		


func _on_button_exit_pressed():
	get_tree().change_scene("res://accesorios/menu/menu.tscn")
