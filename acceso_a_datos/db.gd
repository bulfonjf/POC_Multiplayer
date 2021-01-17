extends Node

var db

# SQLite module
const SQLite = preload("res://lib/gdsqlite.gdns");

func _ready():
	# Create gdsqlite instance
	db = SQLite.new();
	
	# Open item database
	if (not db.open_db("res://db.db")):
		# to-do tirar exepcion si no se puede conectar a la db
		print("ERROR: no se pudo abrir la DB: db.db")

func _exit_tree():
	if (db and db.loaded()):
		# Close database
		db.close();

func consultar(consulta):
	return db.fetch_array(consulta)

func actualizar(comando):
	db.query(comando)

func generar_id(nombre_tabla):
	var id = 1
	var fila = self.consultar("select max(id) as id from %s" % nombre_tabla)

	if fila and fila[0]:
		var max_id = fila[0]["id"]
		id = int(max_id) + 1

	return id

