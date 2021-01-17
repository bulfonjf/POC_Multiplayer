-- SQLite
/*Sselect * 
from partidas;

select *
from rondas;

select p.*, r.*
from partidas p
inner join rondas r on p.id = r.id_partida;
*/
select u.*
from unidades u;

select i.*
from items i;

select u.*, i.*
from unidades u
inner join items_equipados ie on u.id = ie.id_unidad
inner join items i on ie.id_item = i.id
order by u.nombre asc;
