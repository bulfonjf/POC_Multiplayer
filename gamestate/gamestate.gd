extends Node

signal cliente_conectado(cliente_id)
signal cliente_desconectado(cliente_id)

# Default game port
const DEFAULT_PORT = 44444

# Max number of players
const MAX_PLAYERS = 2

# Players dict stored as id:name
var players = {}
var ready_players = []
var _ignore


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
	registrar_jugador(_id)
	emit_signal("cliente_conectado", _id)
	print("Client ", _id, " connected")


# Callback from SceneTree, called when client disconnects
func _player_disconnected(_id):
	if ready_players.has(_id):
		ready_players.erase(_id)
		#rpc("unregister_player", _id)
	players.erase(_id)
	for peer_id in players:
		rpc_id(0, "unregister_jugador", _id)

	rpc_id(0,"update_player_list") # not needed, just double checks everyone on same page
	print(players)
	
	emit_signal("cliente_desconectado", _id)
	print("Client ", _id, " disconnected")

func registrar_jugador(id): 
	print("Everyone sees this.. adding this id to your array! ", id) # everyone sees this
	#the server will see this... better tell this guy who else is already in...
	#if !(id in players):
	players[id] = ""
	
	
	# Send the info of existing players to the new player from ther server's personal list
	for peer_id in players:
		rpc_id(id, "registrar_jugador", peer_id) #rpc_id only targets player with specified ID			
	
	rpc_id(0,"update_player_list") # not needed, just double checks everyone on same page
	
	print(players)

remote func unregister_jugador(id):
	players.erase(id)	

remote func update_player_list():
		for x in players:
			print(x)
	

func iniciar_partida(_partida):
	for peer_id in players:
		rpc_id(peer_id,"iniciar_partida", _partida)
	#Orquestador.iniciar_partida(partida)
