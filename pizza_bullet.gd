extends RigidBody2D
class_name Pizza


func _on_bullet_tree_exited() -> void:
	queue_free()
