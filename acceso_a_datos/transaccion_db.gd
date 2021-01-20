extends Node

var db_path = "res://db.db"

# SQLite module
const SQLite = preload("res://lib/gdsqlite.gdns");
var db

func _init():
	db = SQLite.new()

func abrir_transaccion():
	db.open_db(db_path)
	db.query("begin transaction;")

func cerrar_transaccion():
	db.query("commit;")
	db.close()

func rollback():
	db.query("rollback;")
	db.close()

func actualizar_con_transaccion(comando):
	db.query(comando)

func generar_id(nombre_tabla):
	var id = 1
	var fila = db.fetch_array("select max(id) as id from %s" % nombre_tabla)

	if fila and fila[0]:
		var max_id = fila[0]["id"]
		id = int(max_id) + 1

	return id

