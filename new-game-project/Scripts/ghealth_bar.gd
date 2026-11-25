extends ProgressBar
@onready var timer=$Timer
@onready var damage_bar=$damage_bar

var health=0 : set = _set_health

func _set_health(new_health):
	var prev_health = health
	health=min(max_value,new_health)
	value = health
	

		
	if health <prev_health:
		timer.start()
		
	else:
		damage_bar.value = health 
		
func _init_health(start_health: int)-> void:
	max_value = start_health
	health = start_health
	value = health
	damage_bar.max_value = max_value
	damage_bar.value = health
	
func _on_timer_timeout() -> void:
	damage_bar.value = health
	
