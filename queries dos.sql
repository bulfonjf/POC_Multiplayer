-- SQLite
drop table unidades;
create table if not exists unidades (
    id integer PRIMARY KEY,
    tipo nvarchar(500),
    vida integer,
    ataque_base integer,
    defensa_base integer
);

create table if not exists edificios (
    id integer PRIMARY KEY,
    tipo nvarchar(500)
);

create table if not exists celdas_ocupadas (
    posicion_x integer,
    posicion_y integer,
    entidad_id integer,
    entidad_tipo nvarchar(500)
);

insert into unidades values (1, 'fighter', 100, 10, 5);
insert into edificios values (1, 'base');
insert into celdas_ocupadas values (0, 0, 1, 'unidad');
insert into celdas_ocupadas values (1, 0, 1, 'edificio');

select * from celdas_ocupadas where posicion_x = 0 and posicion_y = 0;

select * from unidades where id = 1;