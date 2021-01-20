extends Reference
class_name Partida

var nombre
var id

func _init(_nombre):
	self.nombre = _nombre

func guardar_en_db(_db):
	self.id = _db.generar_id("partidas")

	var comando = "insert into partidas (id, nombre) values (%d, \"%s\")"  % [self.id, self.nombre]
	_db.actualizar_con_transaccion(comando)
