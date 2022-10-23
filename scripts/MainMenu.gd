extends Node

onready var scene_transitions = preload("res://scenes/Global/SceneTransitions.tscn")

func _ready():
	pass


func _on_QuitGame_pressed():
	get_tree().quit()


func _on_Settings_pressed():
	$Control/CenterContainer2.show()


func _on_SettingsBack_pressed():
	$Control/CenterContainer2.hide()


func _on_PlayGame_pressed():
	get_tree().change_scene("res://scenes/main.tscn")
