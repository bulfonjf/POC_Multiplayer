extends Reference 
class_name Migraciones


var transaccion_script = preload("res://acceso_a_datos/transaccion_db.gd")

func aplicar_migraciones():
	var migraciones = [
		crear_partidas(),
		crear_rondas(),
		crear_turnos(),
		crear_jugadores(),
		crear_facciones(),
		crear_unidades(),
		crear_items(),
		crear_items_equipados()
		]
	
	var transaccion_db = transaccion_script.new()

	transaccion_db.abrir_transaccion()
	
	for m in migraciones:
		transaccion_db.actualizar_con_transaccion(m)

	transaccion_db.cerrar_transaccion()

func crear_partidas():
	return """  
		create table if not exists partidas (
		id integer PRIMARY KEY,
		nombre nvarchar(100)
		);"""

func crear_rondas():
	return """
		create table if not exists rondas (
		id integer PRIMARY KEY,
		id_partida integer,
		numero_ronda integer

		FOREIGN KEY id_partida REFERENCES partidas(id)
		);"""
	
func crear_turnos():
	return """
		create table if not exists turnos (
		id integer PRIMARY KEY,
		id_jugador integer,
		id_partida integer,
		numero_turno integer unique,

		FOREIGN KEY (id_jugador) REFERENCES jugadores(id)
		FOREIGN KEY (id_partida) REFERENCES partidas(id)
		);"""

func crear_jugadores():
	return """
		create table if not exists jugadores (
		id integer PRIMARY KEY,
		id_partida integer,
		nombre nvarchar(500) unique,
		network_id nvarchar(500),

		FOREIGN KEY (id_partida) REFERENCES partidas(id)
		);"""

func crear_facciones():
	return """
		create table if not exists facciones (
		id integer PRIMARY KEY,
		id_jugador integer,
		nombre nvarchar(500),
		
		FOREIGN KEY (id_jugador) REFERENCES jugadores(id)
		);"""

func crear_unidades():
	return """
		create table if not exists unidades (
		id integer PRIMARY KEY,
		id_faccion integer,
		vida integer,
		ataque_base integer,
		defensa_base integer,

		FOREIGN KEY (id_faccion) REFERENCES facciones(id)
		);"""

func crear_items():
	return """
		create table if not exists items (
		id integer PRIMARY KEY,
		id_partida integer,
		nombre nvarchar(500),

		vida integer,
		ataque_base integer,
		defensa_base integer,

		FOREIGN KEY (id_partida) REFERENCES partidas(id)
		);"""

func crear_items_equipados():
	return """
		create table if not exists if not exists items_equipados (
		id_unidad integer,
		id_item integer,

		FOREIGN KEY (id_unidad) REFERENCES unidades(id)
		FOREIGN KEY (id_item) REFERENCES items(id)
		);"""

