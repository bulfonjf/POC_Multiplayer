-- SQLite

-- select * from partidas

-- create table partidas (
--     id integer PRIMARY KEY,
--     nombre nvarchar(100)
--     )

-- create table rondas (
--     id integer PRIMARY KEY,
--     id_partida integer,
--     numero_ronda integer

--     FOREIGN KEY id_partida REFERENCES partidas(id)
--     )

-- create table turnos (
--     id integer PRIMARY KEY,
--     id_jugador integer,
--     id_partida integer,
--     numero_turno integer unique,

--     FOREIGN KEY (id_jugador) REFERENCES jugadores(id)
--     FOREIGN KEY (id_partida) REFERENCES partidas(id)
--     )

-- create table jugadores (
--     id integer PRIMARY KEY,
--     id_partida integer,
--     nombre nvarchar(500) unique,
--     network_id nvarchar(500),

--     FOREIGN KEY (id_partida) REFERENCES partidas(id)
-- )

-- create table facciones (
--     id integer PRIMARY KEY,
--     id_jugador integer,
--     nombre nvarchar(500),
    
--     FOREIGN KEY (id_jugador) REFERENCES jugadores(id)
-- )

-- create table unidades (
--     id integer PRIMARY KEY,
--     id_faccion integer,
--     vida integer,
--     ataque_base integer,
--     defensa_base integer,

--     FOREIGN KEY (id_faccion) REFERENCES facciones(id)
-- )

-- create table items (
--     id integer PRIMARY KEY,
--     id_partida integer,
--     nombre nvarchar(500),

--     vida integer,
--     ataque_base integer,
--     defensa_base integer,

--     FOREIGN KEY (id_partida) REFERENCES partidas(id)
-- )

-- create table items_equipados (
--     id_unidad integer,
--     id_item integer,

--     FOREIGN KEY (id_unidad) REFERENCES unidades(id)
--     FOREIGN KEY (id_item) REFERENCES items(id)
-- )






-- insert into borrar_tabla (id) values ("hola");

-- select * from borrar_tabla;

-- drop table borrar_tabla;

/* func _ready(): */
/*     # Create gdsqlite instance */
/*     db = SQLite.new(); */
    
/*     # Open item database */
/*     if (not db.open_db("res://db.db")): */
/*             print("ERROR: no se pudo abrir la DB: db.db") */

/*     # Create table */
/*     var query = "CREATE TABLE IF NOT EXISTS equipos (id INTEGER PRIMARY KEY);"; */
/*     if (not db.query(query)): */
/*             print("not db.query") */
/*             return; */
    
/*     var insert_query = "insert into equipos (id) values (1);" */
/*     db.query(insert_query); */

/*     # obtener equipos */
/*     var equipos = db.fetch_array("select * from equipos;"); */
/*     if equipos and not equipos.empty(): */
/*             print(equipos) */
