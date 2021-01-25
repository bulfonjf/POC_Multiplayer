extends Control 
onready var VBox_lista_clientes = $VBoxContainer2/HBoxContainer/VBoxContainer
onready var gamestate_nodo = get_tree().get_root().get_node("Gamestate")


signal partida_lista(partida)
signal obtener_equipos(equipos)
signal obtener_facciones(facciones)
var _ignore
var equipos : Array = ["azul", "rojo"]
var facciones : Array = ["elfos", "orcos", "humanos"]

var partida = {
		"nombre": "partida_1_prueba",
		"ronda": { 
			"numero_ronda" : 1
		},
		"equipos":[
			{
				"nombre": "azul",
				"jugadores": [
					{
						"nombre": "pepe",
						"faccion": {
							"nombre": "orcos",
							"unidades": [
								{
									"tipo": "fighter",
									"posicion": Convertir.celda(Vector2(1,0)),
									"equipamiento": ["pechera de cuero", "espada"]
								}
							],
							"edificios": [
								{
									"tipo": "base",
									"posicion": Convertir.celda(Vector2(0,0))
								}
							]
						}
					}
				]
			},
			{
				"nombre": "rojo",
				"jugadores": [
					{
						"nombre": "cacho",
						"faccion": {
							"nombre": "elfos",
							"unidades": [
								{
									"tipo": "caballero",
									"posicion": Convertir.celda(Vector2(10,6)),
									"equipamiento" : ["pechera de cuero", "espada", "armadura de caballo"]
								}
							],
							"edificios": [
								{
									"tipo": "base",
									"posicion": Convertir.celda(Vector2(9,6))
								}
							]
						}
					}
				]
			},
		]
	}
		
func _ready():
	
	_ignore = Gamestate.connect("cliente_conectado", self, "_on_cliente_conectado")
	_ignore = Gamestate.connect("cliente_desconectado", self, "_on_cliente_desconectado")
	_ignore = self.connect("partida_lista", Gamestate, "iniciar_partida")
	_ignore = self.connect("obtener_equipos", Gamestate, "obtener_equipos")
	_ignore = self.connect("obtener_facciones", Gamestate, "obtener_facciones")
	self.obtener_equipos()
	self.obtener_facciones()

func _on_cliente_conectado(cliente_id, nombre_cliente):
	var label = Label.new();
	label.name = str(cliente_id)
	label.text = "se ha conectado el cliente " + str(nombre_cliente) + " con id:" + str(cliente_id);

	VBox_lista_clientes.add_child(label);

func _on_cliente_desconectado(cliente_id):
	var nombre_label = str(cliente_id)
	var label = get_tree().get_root().find_node(str(nombre_label) , true, false)
	label.queue_free()
	pass

func _on_readybtn_pressed():
	emit_signal("partida_lista", partida) 

func obtener_equipos():
	emit_signal("obtener_equipos", equipos)

func obtener_facciones():
	emit_signal("obtener_facciones", facciones)
