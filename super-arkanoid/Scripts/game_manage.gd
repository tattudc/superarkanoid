extends Node

var started: bool = false
var lives: int = 3
var pontos: int = 0
var record: int = 0

var current_level = 1 #fase inicial
var total_levels = 3 #qtd total de fases

signal on_powerup

func  _add_pontos(value):
	pontos += value

func _reset_pontos():
	pontos = 0
	
func _update_record():
	if pontos > record:
		record = pontos

func _reset_lives():
	lives = 3

func change_level():
	if current_level < total_levels:
		current_level += 1
		var scene_directory = 'res://Scenes/level_' + str(current_level) + '.tscn'
		get_tree().change_scene_to_file(scene_directory)
	else:
		print('Você venceu o jogo!')
