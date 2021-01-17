extends Reference
class_name Partida

var nombre
var id

func _init(_nombre):
	self.nombre = _nombre

func guardar_en_db():
	self.id = Db.generar_id("partidas")

	var comando = "insert into partidas (id, nombre) values (%d, \"%s\")"  % [self.id, self.nombre]
	Db.actualizar(comando)
