extends Control

# Declare member variables here. Examples:
onready var text_res = $text_res
#ProjectSettings

# Called when the node enters the scene tree for the first time.
#func _ready():
	#pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_button_low_pressed():
	print("use this to lower the res!")
	text_res.text = ("RES0LUTI0N L0W3R3D")
	ProjectSettings.set_setting("display/window/size/width",960)
	ProjectSettings.set_setting("display/window/size/width",540)

func _on_button_hi_pressed():
	print("use this to raise the res!")
	text_res.text = ("RES0LUTI0N RAIS3D")
	ProjectSettings.set_setting("display/window/size/width",1920)
	ProjectSettings.set_setting("display/window/size/width",1080)


func _on_button_exit_pressed():
	get_tree().change_scene("res://accesorios/menu/main/menu.tscn")
