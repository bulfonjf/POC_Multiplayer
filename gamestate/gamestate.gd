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
	emit_signal("cliente_conectado", _id)
	print("Client ", _id, " connected")


# Callback from SceneTree, called when client disconnects
func _player_disconnected(_id):
	if ready_players.has(_id):
		ready_players.erase(_id)
		# rpc("unregister_player", _id)

	emit_signal("cliente_desconectado", _id)
	print("Client ", _id, " disconnected")

func iniciar_partida(partida):
	Orquestador.iniciar_partida(partida)
