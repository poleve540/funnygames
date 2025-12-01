extends Area2D
class_name EntityHitbox

@onready var entity: Entity = get_parent() as Entity

func _physics_process(_delta: float) -> void:
	if !monitoring:
		return
	
	for area in get_overlapping_areas():
		var entity_hitbox := area as EntityHitbox
		if !entity_hitbox: return
		var e := entity_hitbox.entity as Entity
		if !e or e.invincibility_time > 0:
			continue
	
		e.hurt(1)
		if entity.type == Entity.EntityType.MINION:
			entity.queue_free()
