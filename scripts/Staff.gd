extends Area2D

export(PackedScene) var gem

onready var GemPivot = $GemPivot

func _ready():
	gem = load("res://scenes/Gems/StardardGem.tscn")
	change_gem(gem, global_position)

func change_gem(new_gem, pos):
	if new_gem != null:
		var gem_container = get_tree().get_nodes_in_group('gemContainer')[0]
		var gems = gem_container.get_children()
		for g in gems:
			g.queue_free()
		var n_gem = new_gem.instance()
		n_gem.position = pos

		gem_container.add_child(n_gem)
func _physics_process(delta):
	if len(get_tree().get_nodes_in_group('player')) != 0:
		global_position = get_tree().get_nodes_in_group('player')[0].Weapon.global_position
	else:
		global_position.y += gravity


	
