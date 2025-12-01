extends Sprite2D

func _physics_process(_delta: float) -> void:
	self.position.x -= 1000.0
	if self.position.x < get_viewport_rect().end.x:
		self.position.x = get_viewport_rect().end.x - get_rect().size.x
