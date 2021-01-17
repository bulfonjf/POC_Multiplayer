extends Node2D

onready var menu_crear_partida_tscn = get_node("/root/escena_principal/menu_crear_partida")
# to-do ver si usamos load o preload
var ronda_script = load("res://ronda/ronda.gd")
var partida_script = preload("res://partida/partida.gd")

var _ignore

func iniciar_partida(_partida):
	menu_crear_partida_tscn.hide()
	var partida = partida_script.new(_partida.nombre)
	partida.guardar_en_db()
	
	iniciar_ronda(_partida["ronda"], partida.id) 
	iniciar_facciones(_partida["facciones"])

func iniciar_ronda(_ronda, _id_partida):
	var ronda = ronda_script.new(_ronda, _id_partida)
	ronda.guardar_en_db()
	pass

func iniciar_facciones(facciones):
	for faccion in facciones:
		iniciar_unidades(faccion["unidades"])
		iniciar_edificios(faccion["edificios"])
	pass

func iniciar_unidades(unidades):
	pass

func iniciar_edificios(edificios):
	pass
