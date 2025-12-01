extends Node
class_name PlayerController

@onready var body: CharacterBody2D = get_parent() as CharacterBody2D
@onready var entity: Entity = get_parent() as Entity

func _physics_process(_delta: float) -> void:
	if entity.type != Entity.EntityType.PLAYER:
		return
	
	var movdir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	body.velocity = movdir * entity.speed
	body.move_and_slide()
