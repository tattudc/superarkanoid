extends Area2D

@export var speed = 250

func _physics_process(delta):
	global_position.y -=  speed * delta


func _on_body_entered(body):
	GameManage._add_pontos(1) #adiciona pontos
	queue_free() #excluir a bala
	body._take_damage()
