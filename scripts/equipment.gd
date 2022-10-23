extends Node


onready var player = get_parent().get_node("Player")
onready var weapon = $Staff
onready var gem = $Gem
func _ready():
	pass

	
func _process(delta):
	if get_parent().get_node("Player") != null:
		var weapon_position = player.weapon_point.global_position

		weapon.position = weapon_position
	gem_seek_staff(delta)

	
func gem_seek_staff(delta):
	var dir = (weapon.get_node("gemPosition").global_position - gem.position).normalized()
	gem.velocity = gem.velocity.move_toward(dir * (weapon.get_node("gemPosition").global_position - gem.position).length(), 50 * delta)
	gem.position += gem.velocity * delta
