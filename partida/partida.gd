extends Reference
class_name Partida

var nombre
var id

var nombre_tabla = "partidas"

func _init(_nombre):
	self.nombre = _nombre

func guardar_en_db(_db):
	self.id = _db.generar_id(nombre_tabla)

	var comando = "insert into %s (id, nombre) values (%d, \"%s\")"  % [self.nombre_tabla, self.id, self.nombre]
	_db.actualizar_con_transaccion(comando)
