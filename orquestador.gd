extends Node2D

onready var menu_crear_partida_tscn = get_node("/root/escena_principal/menu_crear_partida")
# to-do ver si usamos load o preload
var ronda_script = load("res://ronda/ronda.gd")
var partida_script = preload("res://partida/partida.gd")
var transaccion_script = preload("res://acceso_a_datos/transaccion_db.gd")

var _ignore

func iniciar_partida(_partida):
	menu_crear_partida_tscn.hide()
	
	var partida = partida_script.new(_partida.nombre)

	var transaccion_db = transaccion_script.new()

	# todas las entidades que se creen al iniciar la partida deben ir
	# dentro de la transaccion
	transaccion_db.abrir_transaccion()

	partida.guardar_en_db(transaccion_db)
	
	iniciar_ronda(_partida["ronda"], partida.id, transaccion_db) 
	iniciar_facciones(_partida["facciones"], transaccion_db)

	transaccion_db.cerrar_transaccion()

func iniciar_ronda(_ronda, _id_partida, _db):
	var ronda = ronda_script.new(_ronda, _id_partida)
	ronda.guardar_en_db(_db)
	pass

func iniciar_facciones(facciones, _db):
	for faccion in facciones:
		iniciar_unidades(faccion["unidades"], _db)
		iniciar_edificios(faccion["edificios"], _db)
	pass

func iniciar_unidades(unidades, _db):
	pass

func iniciar_edificios(edificios, _db):
	pass
