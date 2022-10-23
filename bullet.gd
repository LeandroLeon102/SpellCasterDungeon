extends Node2D

export (int) var damage = 0
export (float)  var vel = 0
export (int) var angle = 0
onready var expodeParticles = preload("res://scenes/Bullets/explodeParticles.tscn")

var velocity = Vector2.ZERO

onready var area2D = $Area2D

func _ready():
	pass

func _physics_process(delta):
	position += velocity * delta

	
func start_at(pos, dir):
	angle = dir
	position = pos
	velocity = Vector2(vel, 0).rotated(angle)

func _on_Area2D_area_entered(area):
	var area_parent = area.get_parent()
	area_parent.take_damage(damage)
	explode()

	
func explode():

	var particles = expodeParticles.instance()
	particles.global_position = global_position
	particles.emitting = true
	get_tree().get_nodes_in_group('bulletContainer')[0].add_child(particles)
	queue_free()


func _on_Area2D_body_entered(_body):
	explode()


func _on_VisibilityNotifier2D_screen_exited():
	
	queue_free()
