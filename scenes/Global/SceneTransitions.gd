extends Node


onready var animationPlayer = $CanvasLayer/Control/AnimationPlayer

func fade_in():
	$CanvasLayer/Control/AnimationPlayer.play("fade_in")

func fade_out():
	$CanvasLayer/Control/AnimationPlayer.play("fade_out")
