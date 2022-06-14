extends Control
class_name HealthBar

@onready var effect: TextureProgressBar = $Effect
@onready var bar: TextureProgressBar = $Bar

var entity: Entity


func init(_entity):
	entity = _entity
	
	effect.max_value = entity.max_health
	effect.value = entity.health
	
	bar.max_value = entity.max_health
	bar.value = entity.health
	
	entity.connect('damage_took', set_health)


func set_health(health: float):
	bar.value = health
	
	var tween: Tween = create_tween()
	tween.tween_property(effect, 'value', health, .3)
