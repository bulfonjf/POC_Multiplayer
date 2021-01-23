extends Reference
class_name Unidad

var id
var id_faccion
var tipo
var vida
var ataque_base
var defensa_base
var coste_movimiento = {}
var movimientos 
var slots = []


var nombre_tabla = "unidades"

func _init(_unidad, _id_faccion):
	var valores_base = Db.consultar_data_tipo_unidad(self.tipo)
	
	self.id_faccion = _id_faccion
	self.tipo = _unidad.tipo
	self.vida = valores_base.vida 
	self.ataque_base = valores_base.ataque
	self.defensa_base = valores_base.defensa
	self.coste_movimiento = valores_base.coste_movimiento
	self.movimientos = valores_base.movimientos
	for slot in valores_base.slots:
		self.slots[slot] = {"ocupado": false}
	self.posicion = _unidad.posicion 
	#set_equipamiento(_unidad.equipamiento) to-do equipar la unidad con los items que vengan de _partida

func guardar_en_db(_db):
	self.id = _db.generar_id(nombre_tabla)

	var comando = "insert into %s (id, id_faccion, tipo, vida, ataque_base, defensa_base, posicion_x, posicion_y) values (%d, %d, \"%s\", %d, %d, %d, )"  % [self.nombre_tabla, self.id, self.id_faccion, self.tipo, self.vida, self.ataque_base, self.defensa_base]
	# to-do insertar la posicion
	# to-do insertar los items equipados
	# to-do insertar los slots (ocupado true o false)
	_db.actualizar_con_transaccion(comando)

func obtener_coste_movimiento(tipo_terreno):
	var coste = self.coste_movimiento[tipo_terreno]
	if coste:
		return coste
	else:
		return 10000 # un numero alto para decir que no puede mover ahi

func set_equipamiento(equipamiento_data):
	for nombre_item in equipamiento_data:
		var item = Db.consultar_item_por_nombre(nombre_item)
		if self.puede_equipar(item):
			self.equipamiento.append(item.id)
			self.ocupar_slots(item.slots)

func ocupar_slots(slots_param : Array):
	for slot in slots_param:
		self.slots[slot] = {"ocupado" : true}

func liberar_slots(slots_param : Array):
	for slot in slots_param:
		self.slots[slot] = {"ocupado" : false}

func puede_equipar(item_data) -> bool:
	return tipo_unidad_pude_equipar_item(item_data) and unidad_dispone_de_slots(item_data)

func tipo_unidad_pude_equipar_item(item) -> bool:
	return Listas.comparar_arrays(item.clases, self.clase.puede_equipar)

func unidad_dispone_de_slots(item) -> bool:
	# Arrancamos diciendo que puede equiparse el item
	# y buscamos si alguno de los slots que requiere el item esta ocupado/(o no existe) en esta unidad (self)
	var slots_disponibles = true 
	if Listas.comparar_arrays(item.slots, self.slots.keys()):
		for slot in item.slots:
			var slot_ocupado = self.slots[slot].ocupado
			# si el slot esta ocupado, entonces no permitimos equipar el item
			# se puede hacer con menos variables pero estoy priorizando comprension mas rapida del metodo
			if slot_ocupado: 
				slots_disponibles = false
				break
	else:
		slots_disponibles = false
	return slots_disponibles

func get_movimientos():
	# agregar todos los modificadores aca, por ahora esta el base no mas
	var movimientos = self.movimientos
	return movimientos
	
func reducir_vida(danio : int):
	self.vida = self.vida - danio

func get_ataque():
	# agregar todos los modificadores aca, por ahora esta el base no mas
	return self.ataque_base

func get_defensa():
	# agregar todos los modificadores aca, por ahora esta el base no mas
	return self.defensa_base
