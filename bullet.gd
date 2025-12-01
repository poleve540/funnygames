extends Area2D
class_name Bullet


@export var boing_force := 300.0
@onready var speed := boing_force

@export var friction := 300.0

var is_pizza: bool

func _ready() -> void:
	assert(speed >= 0)


func _physics_process(delta: float):
	movement(delta)
	if monitoring:
		collision()


func movement(delta) -> void:
	if speed <= 0:
		speed += randf_range(0.5, 2) * boing_force
	else:
		speed -= friction * delta

	position += speed * Vector2.from_angle(rotation) * delta


func collision() -> void:
	for area in get_overlapping_areas():
		var entity_hitbox := area as EntityHitbox
		if !entity_hitbox: continue
		var entity := entity_hitbox.entity
		
		if entity.invincibility_time > 0:
			continue
		
		entity.hurt(1)
		
		queue_free()


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	self.queue_free()
