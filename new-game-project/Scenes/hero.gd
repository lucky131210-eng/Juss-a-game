extends Node2D
@onready var a=$CharacterBody2D/AnimatedSprite2D
@onready var healthbar =$Health_bar
@onready var hitbox: Area2D =$CharacterBody2D/Hitbox
@onready var hit_shape:CollisionShape2D = $CharacterBody2D/Hitbox/CollisionShape2D
var already_hit:=false
var s:=200
var dir:=1
@onready var G=$punch
func _ready() -> void:
	healthbar._init_health(6)
	hit_shape.disabled = true
	hitbox.area_entered.connect(_on_hitbox_area_entered)
	$CharacterBody2D/Hurtbox.add_to_group("hurtbox")
	 
	
func _process(delta):
	if Input.is_action_pressed("Right"):
		position.x+=dir*s*delta
		a.flip_h = false
		a.play("Walk")
	elif Input.is_action_pressed("Left"):
		position.x-=dir*s*delta
		a.flip_h = true
		a.play("Walk")
	elif Input.is_action_pressed("Punchplayer1"):
		already_hit = false
		a.play("punch")
		hit_shape.disabled = false
		await get_tree().create_timer(0.15).timeout
		hit_shape.disabled = true
		G.play()
	else:
		a.play("Idle")
func take_damage(amount: int)-> void:
	healthbar.health -=amount
	if healthbar.health<=0:
		queue_free()
	
func _on_hitbox_area_entered(area:Area2D) -> void:
	if already_hit:
		return
		
	if not area.is_in_group("hurtbox"):
		return
		
	var opponent : Node=area
	
	while opponent !=null and not opponent.has_method("take_damage"):
		opponent = opponent.get_parent()
		
	if opponent !=null:
		opponent.take_damage(1)
		already_hit = true
		print("hit")
		
		
	
		
		
		
