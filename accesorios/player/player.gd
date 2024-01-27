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
#node for the gun(S)?
var node_pistol

##UI Stuff
var button_exit
var button_continue

##TIMER
var timer

func _ready():
	bullet_location = get_node("player_muz")
	button_exit = $button_exit
	button_continue = $button_continue
	timer = get_node("Timer")
	node_pistol = $pistol
	
	##hide ui stuff
	button_exit.visible = false
	button_continue.visible = false
	#hide gun(s)
	node_pistol.visible = false
	current_gun = 0

func _process(delta):
	##PAUSE THE GAME
	if Input.is_action_just_pressed("esc"):
		get_tree().paused = true
		button_exit.visible = true
		button_continue.visible = true
	
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

	##check timer
	if Input.is_action_just_pressed("pew"):
		timer.start()
		
	#spawn bullet I guess
	if Input.is_action_just_pressed("pew") && current_gun == 1 && node_pistol.clip > 0 && node_pistol.can_fire == true:
		print("current clip = ",node_pistol.clip)
		bullet_sfx.play()
		var bullet_scene = load(bullet_path)
		bullet_instance = bullet_scene.instance()
		add_child(bullet_instance)
		bullet_instance.set_as_toplevel(true)
		bullet_instance.global_transform.origin = bullet_location.global_transform.origin
	
	##different weapons
	if Input.is_action_just_pressed("1"):
		pistol_scn.visible = true
		current_gun = 1
		print("gun selected", current_gun)
		#print("current clip = ",node_pistol.clip)
		
	elif Input.is_action_just_pressed("2"):
		pistol_scn.visible = false
		current_gun = 2
		print("gun selected", current_gun)
	
	##debbuging reload
	if Input.is_action_just_pressed("reload") && current_gun == 1:
		print("current mags = ",node_pistol.mag)
		

func _on_button_exit_pressed():
	get_tree().paused = false
	get_tree().change_scene("res://accesorios/menu/main/menu.tscn")


func _on_button_continue_pressed():
	get_tree().paused = false
	button_exit.visible = false
	button_continue.visible = false
