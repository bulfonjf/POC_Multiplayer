extends Reference
class_name Jugador

var id
var id_partida
var nombre

var nombre_tabla = "jugadores"

func _init(_jugador, _id_partida):
	self.id_partida = _id_partida
	self.nombre = _jugador.nombre

func guardar_en_db(_db):
	self.id = _db.generar_id(nombre_tabla)

	var comando = "insert into %s (id, id_partida, nombre) values (%d, %d, '%s')"  % [self.nombre_tabla, self.id, self.id_partida, self.nombre]
	_db.actualizar_con_transaccion(comando)
