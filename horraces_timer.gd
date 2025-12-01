extends Timer

var scared_timer: float
@export var node: Entity

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		node.speed = 1000
		start(5.0)


func _on_timeout() -> void:
	node.speed = 200
