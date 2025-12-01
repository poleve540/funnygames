extends Timer

@export var minion: PackedScene

func _on_timeout() -> void:
	var x := 1000.0
	var y := 150.0
	
	for c in range(2):
		for r in range(4):
			var minion_instance := minion.instantiate()
			minion_instance.position.x = x
			minion_instance.position.y = y
			add_sibling(minion_instance)
			y += 100
		y = 150.0
		x += 100
