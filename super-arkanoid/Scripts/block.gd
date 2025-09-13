extends StaticBody2D

@export var lives_blocks = 1
@onready var sprite_node = get_node('Sprite2D')

func _take_damage() -> bool:
	lives_blocks -= 1
	if lives_blocks <= 0:
		get_parent().get_parent().call_deferred('check_if_blocks_exist')
		get_parent().remove_child(self) #excluindo a instancia instantaneamente
		queue_free() #removendo da memoria
		return true
	else:
		_on_damage_received()
		return false
	

func _on_damage_received():
	sprite_node.modulate = Color(0.75,0.75,0.25,1)
