extends CharacterBody2D

@export var y_speed = -250
@export var angle = [-200,-250, 250, 300]
@export var drop_probability = 0.2 #probabilidade de 20%
@export var item_scene = preload("res://Scenes/item_power_up.tscn") #preload da cena
@onready var timer_item_power_up = $TimerItemPowerUp
@onready var audio_colision = $AudioColision

func _physics_process(delta):
	#detecta entrada das teclas iniciais e arremessa a bola
	if Input.is_action_pressed('Start') and !GameManage.started:
		play_game() #iniciar o jogo
	if GameManage.started:
		#Detecta colisões e retorna dados do mesmo
		var collision = move_and_collide(velocity*delta)
		if collision != null: #se colisão existir
			audio_colision.play()
			velocity = velocity.bounce(collision.get_normal())
			#verifica se o nome do objeto é block
			var collided_object = collision.get_collider()
			if 'Block' in collided_object.name:
				GameManage._add_pontos(5)
				var destroyer: bool = collided_object._take_damage()
				if destroyer:
					spawn_item(collided_object.get_position())
	
		
func play_game():
	GameManage.started = true
	velocity = Vector2(angle.pick_random(), y_speed)

func spawn_item(position_item: Vector2):
	#sorteia se deve gerar um item coletável
	if randf() < drop_probability:
		if timer_item_power_up.is_stopped():
			#cria o item coletavel
			var item = item_scene.instantiate() #instacia o item
			item.position = position_item #define a posição
			get_parent().add_child(item) #Adiciona o item a cena
			timer_item_power_up.start()

func reset_position():
	var player = get_parent().get_node('Player')
	position = player.position + Vector2(0, -25)
	GameManage.started = false
