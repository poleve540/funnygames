extends Node2D

func _physics_process(delta: float) -> void:
	self.rotation_degrees += 360 * 0.5 * delta
	if rotation_degrees > 360: rotation_degrees -= 360
