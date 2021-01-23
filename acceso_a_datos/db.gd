extends Node

var db_path = "res://db.db"

# SQLite module
const SQLite = preload("res://lib/gdsqlite.gdns");

func _ready():
	# Create gdsqlite instance
	var db = SQLite.new();
	
	# Open item database
	var check_connection = db.open_db(db_path)
	if (check_connection):
		db.close()
	else:
		# to-do tirar exepcion si no se puede conectar a la db
		print("ERROR: no se pudo abrir la DB: db.db")

func consultar(consulta):
	# Create gdsqlite instance
	var db = SQLite.new();

	# Create a new connection with the database
	db.open_db(db_path)

	# do the query
	var result =  db.fetch_array(consulta)

	# close the connection
	db.close()

	return result

func actualizar(comando):
	# Create gdsqlite instance
	var db = SQLite.new();

	# Create a new connection with the database
	db.open_db(db_path)

	# do the query
	db.query(comando)

	# close the connection
	db.close()

func retornar_primer_elemento(_resultado_consulta):
	if _resultado_consulta:
		return _resultado_consulta[0]
	else:
		return {}
	
# -----------------------------
# ------- QUERIES -------------
# -----------------------------

func consultar_item_por_nombre(_nombre_item) -> Dictionary:
	var result = self.consultar("select * from items where nombre == '%s'" % _nombre_item)
	return retornar_primer_elemento(result)
	
	

