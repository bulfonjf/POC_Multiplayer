extends Reference
class_name Ronda

var id 
var numero_ronda
var id_partida

func _init(_ronda, _id_partida):
	self.numero_ronda = _ronda.numero_ronda
	self.id_partida = _id_partida

func guardar_en_db():
	self.id = Db.generar_id("rondas")
	var comando = "insert into rondas (id, numero_ronda, id_partida) values (%d, %d, %d)"  % [self.id, self.numero_ronda, self.id_partida]
	Db.actualizar(comando)

	pass
