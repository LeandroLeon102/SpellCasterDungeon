extends Node2D
onready var player = get_node("Player")


func _ready():

	Input.set_custom_mouse_cursor(load("res://crosshair038.png"), 0, Vector2(14, 14))
	#Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
	player.connect('set_health', self,"set_player_health")
	
func set_player_health(health):
	$CanvasLayer/Control/PlayerHealthbar.set_health(health)
	


