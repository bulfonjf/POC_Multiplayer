extends Reference
class_name Ronda

var id 
var id_partida
var numero_ronda

var nombre_tabla = "rondas"

func _init(_ronda, _id_partida):
	self.id_partida = _id_partida
	self.numero_ronda = _ronda.numero_ronda
	

func guardar_en_db(_db):
	self.id = _db.generar_id(nombre_tabla)
	var comando = "insert into %s (id, id_partida, numero_ronda) values (%d, %d, %d)"  % [self.nombre_tabla, self.id, self.id_partida, self.numero_ronda]
	_db.actualizar_con_transaccion(comando)
