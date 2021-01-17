extends Control 

onready var lista_clientes : VBoxContainer = $VBoxContainer

signal partida_lista(partida)

var _ignore
var partida = {
		"nombre": "partida_1_prueba",
		"ronda": { 
			"numero_ronda" : 1
		},
		"facciones": [{
			"nombre": "orcos",
			"unidades": [{
				"fighter": {
					"nombre": "fighter",
					"equipo": []
				}
			}],
			"edificios": []
		}]
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
