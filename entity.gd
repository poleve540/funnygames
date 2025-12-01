extends Node2D
class_name Entity

signal health_changed(entity: Entity)

@export var speed := 400.0
@export var health := 3
@onready var max_health := health

@export var score_value: int

## If it's controlled by player input
enum EntityType {DEFAULT, ANIME, PLAYER, MINION, HORRACES}
@export var type: EntityType

## Bullet the enemy may shoot
@export var bullet: PackedScene

@export var health_bar: ProgressBar

@export var gain_score_only_on_death: bool

var invincibility_time: float

func _ready() -> void:
	if health_bar:
		health_bar.max_value = health
		health_bar.value = health


func _physics_process(delta: float) -> void:
	if type == EntityType.PLAYER:
		player_update(delta)
	elif type == EntityType.ANIME:
		position.y = 400 + 95 * sin(2*PI * Time.get_ticks_msec()/1000 * 0.5)
	elif type == EntityType.MINION:
		var mov_dir := (Globals.player.position - self.position).normalized()
		self.position += mov_dir * speed * delta


func hurt(damage: int) -> void:
	if type == EntityType.PLAYER:
		invincibility_time = 1.0
		modulate = Color(1.0, 1.0, 1.0, 0.627)
	
	self.health -= damage
	if health_bar: health_bar.value = health
	health_changed.emit(self)
	
	if !gain_score_only_on_death:
		Globals.add_points(score_value)
	
	if self.health <= 0:
		if type == EntityType.PLAYER:
			var tween := get_tree().create_tween()
			tween.tween_property(self, "modulate", Color(0.0, 0.0, 0.0, 0.2), 1.0)
			var spinner := $Spinner as Node2D
			var ibrahim_timer := %IbrahimTimer as Timer
			ibrahim_timer.stop()
			tween.tween_callback(spinner.set_process_mode.bind(Node.PROCESS_MODE_DISABLED))
			type = EntityType.DEFAULT
			return
		queue_free()
		
		if gain_score_only_on_death:
			Globals.add_points(score_value)


func player_update(delta: float) -> void:
	if invincibility_time > 0:
		invincibility_time -= delta
		if invincibility_time <= 0:
			invincibility_time = 0
			modulate = Color.WHITE
	
	if Input.is_action_just_pressed("ui_accept"):
		var new_bullet: Bullet = bullet.instantiate()
		new_bullet.position = self.position
		new_bullet.speed = 800
		new_bullet.friction = 0
		add_sibling(new_bullet)
