extends Reference
class_name Equipo

var id
var id_partida
var nombre

var nombre_tabla = "equipos"

func _init(_equipo, _id_partida):
	self.id_partida = _id_partida
	self.nombre = _equipo.nombre

func guardar_en_db(_db):
	self.id = _db.generar_id(nombre_tabla)

	var comando = "insert into %s (id, id_partida, nombre) values (%d, %d, '%s')"  % [self.nombre_tabla, self.id, self.id_partida, self.nombre]
	_db.actualizar_con_transaccion(comando)
