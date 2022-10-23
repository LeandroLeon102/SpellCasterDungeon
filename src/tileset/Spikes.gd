extends Area2D

export (int) var damage = 0



func _on_Spikes_area_entered(area):
	var area_parent = area.get_parent()
	if area_parent.is_in_group('player'):
		area_parent.take_damage(damage)
