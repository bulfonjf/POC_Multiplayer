extends Reference
class_name Unidad

var id
var id_faccion
var tipo
var vida
var ataque_base
var defensa_base

var nombre_tabla = "unidades"

func _init(_unidad, _id_faccion):
	self.id_faccion = _id_faccion
	self.tipo = _unidad.tipo
	self.vida = 
	self.ataque_base = 
	self.defensa_base = 
	self.posicion = _unidad.posicion
	

func guardar_en_db(_db):
	self.id = _db.generar_id(nombre_tabla)

	var comando = "insert into %s (id, id_faccion, tipo, vida, ataque_base, defensa_base, posicion_x, posicion_y) values (%d, %d, \"%s\", %d, %d, %d, )"  % [self.nombre_tabla, self.id, self.id_faccion, self.tipo, self.vida, self.ataque_base, self.defensa_base]
	_db.actualizar_con_transaccion(comando)