extends Timer

@onready var audio: AudioStreamPlayer = $AudioStreamPlayer
@onready var ibrahim: Entity = get_parent() as Entity
@export var pizza: PackedScene

var voiceline_counter: int

func _on_timeout() -> void:
	var new_pizza := pizza.instantiate() as Pizza
	new_pizza.position = ibrahim.global_position
	get_tree().root.add_child(new_pizza)
	
	voiceline_counter += 1
	
	if !audio.playing && voiceline_counter >= 10:
		audio.play()
		voiceline_counter = 0
