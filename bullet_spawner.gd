extends Node2D
class_name BulletSpawner

@onready var bullet := preload("uid://cfolycmuo5d7h")

@export var bullet_speed: float = 300.0
@export var spawnrate: float = 0.8

func _ready() -> void:
	$Timer.wait_time = spawnrate


func spawn_bullet() -> void:
	var new_bullet: Bullet = bullet.instantiate()
	new_bullet.boing_force = bullet_speed
	
	new_bullet.position = self.position
	new_bullet.rotation_degrees = 180

	# Disable hurting enemy and enable hurting player
	new_bullet.set_collision_mask_value(1, false)
	new_bullet.set_collision_mask_value(2, true)
	add_sibling(new_bullet)


func _on_timer_timeout() -> void:
	spawn_bullet()
