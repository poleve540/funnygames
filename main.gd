extends Node2D
class_name Main


@export var game_over_label: Label
@export var game_over_picture: Sprite2D
@export var flich: Sprite2D
@export var player: Entity
@export var score_label: Label

var crystal_died: bool

func _ready() -> void:
	Globals.score_label = score_label
	Globals.update_score_text()
	Globals.player = player
	Globals.flich = flich


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("restart"):
		get_tree().reload_current_scene()


func game_over() -> void:
	if crystal_died:
		game_over_label.text = "YOU MORON!!\nTHiS WAS MY PRIZED METH CRYSTAL!!\nDIE!!!"
	
	var sockmit := %SockmitNecrophilia as SockmitNecrophilia
	sockmit.process_mode = Node.PROCESS_MODE_INHERIT
	
	var minion_timer := %MinionSpawner as Timer
	minion_timer.process_mode = Node.PROCESS_MODE_DISABLED
	
	game_over_label.show()
	game_over_picture.show()


func win(max_score: int) -> void:
	get_tree().call_group("bullets", "set_monitoring", false)
	get_tree().call_group("bullet_spawners", "queue_free")
	game_over_label.text = "YOU WIN !!!!!\nYOUR SCORE: " + str(Globals.score) + "\n"

	if Globals.score <= max_score * 0.5:
		game_over_label.text += "you are really bad at this game."
	elif Globals.score <= max_score * 0.7:
		game_over_label.text += "you can do better!"
	elif Globals.score < max_score:
		game_over_label.text += "nice job !"
	elif Globals.score == max_score:
		game_over_label.text += "PERFECT SCORE !"
	else:
		game_over_label.text += "I killed the neighbor's cat\nwhen I was 9"
		
	var minion_timer := %MinionSpawner as Timer
	minion_timer.process_mode = Node.PROCESS_MODE_DISABLED
	game_over_label.show()


func defeat_anime(anime: Entity) -> void:
	win(anime.max_health * anime.score_value)


func _on_anime_girl_health_changed(anime: Entity) -> void:
	if anime.health <= 0:
		defeat_anime(anime)


func _on_green_meth_health_changed(green_meth: Entity) -> void:
	if green_meth.health <= 0:
		var blue_guy := Globals.player
		crystal_died = true
		blue_guy.hurt(999)
 

func _on_blue_guy_health_changed(blue_guy: Entity) -> void:
	if blue_guy.health <= 0:  
		get_tree().call_group("bullets", "set_monitoring", false)
		get_tree().call_group("bullet_spawners", "queue_free")
		game_over()
