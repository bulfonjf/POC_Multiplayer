extends Reference
class_name Faccion

var id
var id_jugador
var nombre


var nombre_tabla = "facciones"

func _init(_faccion, _id_jugador):
	self.id_jugador = _id_jugador
	self.nombre = _faccion.nombre

func guardar_en_db(_db):
	self.id = _db.generar_id(nombre_tabla)

	var comando = "insert into %s (id, id_jugador, nombre) values (%d, %d, \"%s\")"  % [self.nombre_tabla, self.id, self.id_jugador, self.nombre]
	_db.actualizar_con_transaccion(comando)
