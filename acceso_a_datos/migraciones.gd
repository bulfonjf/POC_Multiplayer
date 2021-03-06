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
		crear_terrenos(),
		crear_slots(),
		crear_tipo_unidades(),
		crear_slots_tipo_unidades(),
		crear_coste_movimiento_tipo_unidad(),
		crear_items(),
		crear_slots_item(),
		crear_unidades(),
		crear_items_equipados(),
		crear_celdas_ocupadas(),
		insertar_slots(),
		insertar_items()
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

func crear_terrenos():
	return """
		create table if not exists terrenos(
			id integer PRIMARY KEY,
			nombre nvarchar(500)
		);"""

func crear_slots():
	return """
		create table if not exists slots(
			id integer PRIMARY KEY,
			nombre nvarchar(500)
		);"""

func crear_tipo_unidades():
	return """
		create table if not exists tipo_unidades (
			id integer PRIMARY KEY,
			nombre nvarchar(500),
			vida integer,
			ataque_base integer,
			defensa_base integer,
			movimientos integer
			);"""

func crear_slots_tipo_unidades():
	return """
		create table if not exists slots_tipo_unidades(
			id_slot integer,
			id_tipo_unidad integer,

			FOREIGN KEY (id_slot) REFERENCES slots(id)
			FOREIGN KEY (id_tipo_unidad) REFERENCES tipo_unidades(id)
		);"""

func crear_coste_movimiento_tipo_unidad():
	return """
		create table if not exists coste_movimiento_tipo_unidad(
			id_tipo_unidad integer,
			id_terreno integer,
			coste_movimiento integer

			FOREIGN KEY (id_tipo_unidad) REFERENCES tipo_unidades(id)
			FOREIGN KEY (id_terreno) REFERENCES terrenos(id)
		);"""

func crear_items():
	return """
		create table if not exists items (
		id integer PRIMARY KEY,
		nombre nvarchar(500),
		vida integer,
		ataque_base integer,
		defensa_base integer
		);"""

func crear_slots_item():
	return """
		create table if not exists slots_item (
			id_item integer,
			id_slot integer

			FOREIGN KEY (id_item) REFERENCES items(id)
			FOREIGN KEY (id_slot) REFERENCES slots(id)
		);"""

func crear_unidades():
	return """
		create table if not exists unidades (
		id integer PRIMARY KEY,
		id_faccion integer,
		id_tipo integer,
		vida integer,
		ataque_base integer,
		defensa_base integer,

		FOREIGN KEY (id_faccion) REFERENCES facciones(id)
		FOREIGN KEY (id_tipo) REFERENCES tipo_unidades(id)
		);"""

func crear_items_equipados():
	return """
		create table if not exists items_equipados (
		id_unidad integer,
		id_item integer,
		id_slot integer

		FOREIGN KEY (id_unidad) REFERENCES unidades(id)
		FOREIGN KEY (id_item) REFERENCES items(id)
		FOREIGN KEY (id_slot) REFERENCES slots_tipo_unidades(id)
		);"""

func crear_celdas_ocupadas():
	return """
		create table if not exists celdas_ocupadas (
			posicion_x integer,
			posicion_y integer,
			entidad_id integer,
			entidad_tipo nvarchar(500)
		);"""

func insertar_slots():
	return """
		insert into slots(1, 'pecho');
		insert into slots(2, 'mano_izquierda');
		insert into slots(3, 'mano_derecha');
		insert into slots(4, 'caballo');
	"""

func insertar_items():
	return """
		
		insert into items(1, 'pechera de cuero', 0, 0, 10);
		insert into slots_item(1,1)
		insert into items(2, 'espada', 0, 10, 0);
		insert into slots_item(2,3)
		insert into items(3, 'armadura de caballo', 0, 0, 10);
		insert into slots_item(3,4)
	"""
