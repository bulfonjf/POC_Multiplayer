extends Reference
class_name Ronda

var id 
var numero_ronda
var id_partida

var nombre_tabla = "rondas"

func _init(_ronda, _id_partida):
	self.numero_ronda = _ronda.numero_ronda
	self.id_partida = _id_partida

func guardar_en_db(_db):
	self.id = _db.generar_id(nombre_tabla)
	var comando = "insert into %s (id, numero_ronda, id_partida) values (%d, %d, %d)"  % [self.nombre_tabla, self.id, self.numero_ronda, self.id_partida]
	_db.actualizar_con_transaccion(comando)
