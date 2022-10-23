extends Area2D

var player = null

func _ready():
	pass

func can_see_player():
	return player != null

func _on_PlayerDetectionArea_body_entered(body):
	if body.is_in_group('player'):
		player = body


func _on_PlayerDetectionArea_body_exited(_body):
	player = null
