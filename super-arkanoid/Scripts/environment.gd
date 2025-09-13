extends Node2D

@onready var timer_reset = $TimerReset
@onready var audio_death = $AudioDeath

func _process(delta):
	if Input.is_action_just_pressed("next_level_test"):
		GameManage.started = false
		GameManage.change_level()

#Sinal emitido quando corpo entra na área de morte
func _on_death_zone_body_entered(body):
	if body.name == 'Ball': #veriifica se o nome do objeto colidido é ball
		audio_death.play()
		if GameManage.lives > 1:
			GameManage.lives -= 1
			body.reset_position()
		else:
			GameManage.lives = 0
			GameManage._update_record()
			timer_reset.start()
	else: #se não for a bola, ele é deletado
		body.queue_free()

#sinal emitido quando o cronometro é zerado
func _on_timer_reset_timeout():
	GameManage.started = false #atualiza a variavel global de controle do jogo
	GameManage._reset_lives()
	GameManage._reset_pontos()
	GameManage.current_level = 0
	GameManage.change_level()
	#get_tree().reload_current_scene() # reinicia a cena na qual estamos
