extends Node

var score_label: Label
var score: int
var player: Entity
var flich: Sprite2D


func update_score_text() -> void:
	score_label.text = "Score: " + str(score)


func add_points(points: int) -> void:
	score += points
	update_score_text()
	flich.modulate.r += int(points / 50.0)
