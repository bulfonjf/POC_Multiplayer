extends Control 

onready var lista_clientes : VBoxContainer = $VBoxContainer

signal partida_lista(partida)

var _ignore
#var partida = {
#		"nombre": "partida_1_prueba",
#		"ronda": { 
#			"numero_ronda" : 1
#		},
#		"facciones": [{
#			"nombre": "orcos",
#			"unidades": [{
#				"fighter": {
#					"nombre": "fighter",
#					"equipo": []
#				}
#			}],
#			"edificios": []
#		}]
#	}
var partida = {
		"nombre": "partida_1_prueba",
		"ronda": { 
			"numero_ronda" : 1
		},
		"edificios":
		{
			"nombre": "base",
			"posicion": posiciones_edificios[0],
			"faccion": "orcos"
		}
		{
			"nombre": "aserradero",
			"posicion": posiciones_edificios[1],
			"faccion": "orcos"
		}
		{
			"nombre": "cantera",
			"posicion": posiciones_edificios[2],
			"faccion": "orcos"
		}
		{
			"nombre": "mina_de_oro",
			"posicion": posiciones_edificios[3],
			"faccion": "orcos"
		},
		"facciones":
		{
			"nombre" : "orcos",
			"unidades": [
				{
					"posicion" : posiciones_unidades[0],
					"clase" : "fighter",
					"equipamiento" : ["pechera de cuero", "espada", "armadura de caballo"], #// ojo, usar los mismos nombres que items
				}
			]
		},
		{
			"nombre" : "elfos",
			"unidades": [
				{
					"posicion" : posiciones_unidades[1],
					"clase" : "caballero",
					"equipamiento" : ["pechera de cuero", "espada","armadura de caballo"], #// ojo, usar los mismos nombres que items
				}
			]
		}
	}	

func _ready():
	
	_ignore = Gamestate.connect("cliente_conectado", self, "_on_cliente_conectado")
	_ignore = Gamestate.connect("cliente_desconectado", self, "_on_cliente_desconectado")
	_ignore = self.connect("partida_lista", Gamestate, "iniciar_partida")

func _on_cliente_conectado(cliente_id):
	var label = Label.new();
	label.text = "se ha conectado el cliente con id:" + str(cliente_id);

	lista_clientes.add_child(label);

func _on_cliente_desconectado(cliente_id):
	var label = Label.new();
	label.text = "se ha desconectado el cliente con id:" + str(cliente_id);

	lista_clientes.add_child(label);

func _on_readybtn_pressed():
	emit_signal("partida_lista", partida) 
