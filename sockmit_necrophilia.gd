extends Sprite2D
class_name SockmitNecrophilia

var speed: float = 100.0

func _physics_process(delta: float):
	var mov_dir := (Globals.player.position - self.position).normalized()
	self.position += mov_dir * speed * delta
	speed += 600.0 * delta
