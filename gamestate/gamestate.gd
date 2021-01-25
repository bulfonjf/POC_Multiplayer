extends Node

signal cliente_conectado(cliente_id)
signal cliente_desconectado(cliente_id)
signal nombre_registrado()
# Default game port
const DEFAULT_PORT = 44444

# Max number of players
const MAX_PLAYERS = 2

# Players dict stored as id:name
var players = {}
var equipos = []
var facciones = []
var ready_players = []
var _ignore
var nombre_nuevo 

func _ready():
	_ignore = get_tree().connect("network_peer_connected", self, "_player_connected")
	_ignore = get_tree().connect("network_peer_disconnected", self,"_player_disconnected")

	create_server()

func create_server():
	var host = NetworkedMultiplayerENet.new()
	host.create_server(DEFAULT_PORT, MAX_PLAYERS)
	get_tree().set_network_peer(host)

# Callback from SceneTree, called when client connects
func _player_connected(_id):
	#le pide el nombre al cliente
	rpc_id(_id, "obtener_nombre") 
	# espera a queel cliente llame a "registrar_nombre" y su nombre se guarde en la var "nombre_nuevo"
	yield(self, "nombre_registrado") 
	var nombre_jugador_conectado = nombre_nuevo
	#llama a registrar jugador con el id y el nombre del cliente
	registrar_jugador(_id, nombre_jugador_conectado)
	print("Client ", _id, " connected")


# Callback from SceneTree, called when client disconnects
func _player_disconnected(_id):
	if ready_players.has(_id):
		ready_players.erase(_id)
		#rpc("unregister_player", _id)
	players.erase(_id)
	for peer_id in players:
		rpc_id(0, "unregister_jugador", _id)

			
	emit_signal("cliente_desconectado", _id)
	print("Client ", _id, " disconnected")

func registrar_jugador(id, _nombre_jugador_conectado): 
	#guarda el id con su respectivo nombre en "players"
	players[id] = _nombre_jugador_conectado

	#emite la señal para que se muestre un label en el lobby con el nombre y id del cliente conectado
	emit_signal("cliente_conectado", id, players[id])

	#llama al cliente conectado para que se registre a si mismo
	rpc_id(id, "registrar_jugador", id, _nombre_jugador_conectado)
	#le envia la lista de equipos al cliente
	rpc_id(id, "obtener_equipos", equipos)
	#le envia la lista de facciones al cliente
	rpc_id(id, "obtener_facciones", facciones)
	#una vez registrado el nuevo jugador, se obtienen los id de los jugadores conectados
	var players_keys = players.keys()
	
	#se le envia la info de los jugadores al cliente nuevo
	for peer_id in players_keys:
		if not peer_id  == id:
			rpc_id(id, "registrar_jugador", peer_id, players[peer_id]) 
	
	#se envia la info del nuevo cliente a los que ya estaban conectados			
	for peer_id in players_keys:
		if not peer_id  == id:
			rpc_id(peer_id, "registrar_jugador", id, players[id])

	 

remote func registrar_nombre(_nombre):
		nombre_nuevo = _nombre
		emit_signal("nombre_registrado")
		

remote func unregister_jugador(id):
	players.erase(id)	

func obtener_equipos(_equipos):
	equipos = _equipos

func obtener_facciones(_facciones):
	facciones = _facciones
#La llama _on_readybtn_pressed() de "lobby" 
func iniciar_partida(_partida):
	for peer_id in players:
		rpc_id(peer_id,"iniciar_partida", _partida)
	Orquestador.iniciar_partida(_partida)
	var grilla = load("res://grilla/grilla.tscn").instance()
	get_node("/root").add_child(grilla)
