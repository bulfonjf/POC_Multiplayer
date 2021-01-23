extends Node2D

onready var menu_crear_partida_tscn = get_node("/root/escena_principal/menu_crear_partida")
# to-do ver si usamos load o preload
var partida_script = preload("res://partida/partida.gd")
var ronda_script = load("res://ronda/ronda.gd")
var equipo_script = preload("res://equipo/equipo.gd")
var jugador_script = preload("res://jugador/jugador.gd")
var faccion_script = preload("res://faccion/faccion.gd")
var unidad_script = preload("res://unidad/unidad.gd")

var transaccion_script = preload("res://acceso_a_datos/transaccion_db.gd")
var migraciones_script = preload("res://acceso_a_datos/migraciones.gd")

var _ignore

func _ready():
	var migraciones = migraciones_script.new()
	migraciiones.aplicar_migraciones()

func iniciar_partida(_partida):
	menu_crear_partida_tscn.hide()
	
	var partida = partida_script.new(_partida)

	var transaccion_db = transaccion_script.new()

	# todas las entidades que se creen al iniciar la partida deben ir
	# dentro de la transaccion
	transaccion_db.abrir_transaccion()

	partida.guardar_en_db(transaccion_db)
	
	iniciar_ronda(_partida.ronda, partida.id, transaccion_db)
	iniciar_equipos(_partida.equipos, partida.id, transaccion_db) 
#	iniciar_grilla(tiles, celdas_ocupadas, transaccion_db)

	transaccion_db.cerrar_transaccion()

func iniciar_ronda(_ronda, _id_partida, _db):
	var ronda = ronda_script.new(_ronda, _id_partida)
	ronda.guardar_en_db(_db)

func iniciar_equipos(_equipos, _id_partida, _db):
	for equipo in _equipos:
		iniciar_equipo(equipo, _id_partida, _db)

func iniciar_equipo(_equipo, _id_partida, _db):
	var equipo = equipo_script.new(_equipo, _id_partida)
	equipo.guardar_en_db(_db)
	for jugador in equipo.jugadores:
		iniciar_jugador(jugador, equipo.id,  _db)

func iniciar_jugador(_jugador, _id_equipo, _db):
	var jugador = jugador_script.new(_jugador, _id_equipo)
	jugador.guardar_en_db()
	iniciar_faccion(jugador.faccion, jugador.id, _db)

func iniciar_faccion(_faccion, _id_jugador, _db):
	var faccion = faccion_script.new(_faccion, _id_jugador)
	faccion.guardar_en_db(_db)

	for unidad in _faccion.unidades:
		iniciar_unidad(unidad, faccion.id, _db)

	for edificio in _faccion.edificios:
		iniciar_edificio(edificio, faccion.id, _db)

func iniciar_unidad(_unidad, _id_faccion, _db):
	var unidad = unidad_script.new(_unidad, _id_faccion)
	unidad.guardad_en_db(_db)

	for item_nombre in equipamiento:
		iniciar_equipamiento(item_nombre, unidad.id, _db)

func iniciar_equipamiento(_item_nombre, _unidad_id, _db):
	# to-do el item podria no existir y aca va a tirar un error	
	var id_item = Db.consultar_item_por_nombre(_item_nombre).id
	# WIP: Juan, deje aca pq me fui a comer.
	# Crear la clase item_equipado o unidad_item para insertar en la base

	
func iniciar_edificio(_edificio, _id_faccion, _db):
	pass

func iniciar_grilla(_tiles, _celdas_ocupadas, _db):
	pass	
