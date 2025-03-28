use peliculas;

-- SELECT
-- SELECT * permite traer todas las filas y columnas de una tabla
select * 
from peliculas;

-- Podemos asignarle un nombre a las columnas del resultado con: as
select pelicula_titulo as titulo, pelicula_anio as anio
from peliculas p;

-- Ordenando resultados con ORDER BY, de manera ASC=ascendente y DESC=descendente
-- Ordenar películas por año de manera de descendente
select pelicula_titulo as titulo, pelicula_anio as anio
from peliculas p
order by pelicula_anio desc;

-- Ordenar nombres por orden alfabético
select actor_nombre as nombre
from actores a
order by actor_nombre asc;

-- FILTRAR RESULTADOS CON WHERE
-- Películas que se hicieron después del año 2000
select pelicula_titulo as titulo, pelicula_anio as anio
from peliculas p
where pelicula_anio >= 2000 -- where se acompaña de una condición
order by pelicula_anio asc;

-- Actores que nacieron antes de 1980
select actor_nombre as nombre, YEAR(actor_fecha_nacimiento) as anio_nacimiento
from actores a 
where year(a.actor_fecha_nacimiento) < '1980'; -- Función YEAR() obtiene el año de una fecha

-- Películas que hayan salido entre 2000 y 2010 y que hayan tenido un presupuesto > 50M
select pelicula_titulo as titulo, pelicula_anio as anio
from peliculas p
where pelicula_anio between 2000 and 2010 -- between permite indicar un rango 
and pelicula_presupuesto > 50000000; 

-- AND - OR permiten agregar condiciones extra a la consulta
-- IN permite indicar una serie de valores a considerar en la consulta
-- Peliculas que se hicieron en 2005, 2010 y 2015
select pelicula_titulo as titulo, pelicula_anio as anio
from peliculas p 
where pelicula_anio in (2005, 2010, 2015);

-- FUNCIONES
-- COUNT() permite contar la cantidad de filas o registros dentro una columna
-- Contar el total de películas
select COUNT(*) as cantidad_peliculas 
from peliculas p;

-- SUM() permite obtener la suma de las filas si son un dato de tipo numérico
-- Suma de los presupuestos de las películas
select SUM(pelicula_presupuesto) as total_presupuesto
from peliculas p;

-- AVG() permite obtener el promedio entre los registros dentro de una columna numérica
-- Presupuesto promedio entre las películas
select AVG(pelicula_presupuesto) as total_presupuesto
from peliculas p;

-- MIN Y MAX permiten obtener valor mínimo y máximo dentro de los registros en una columna
select MIN(pelicula_duracion) as duracion_minima, MAX(pelicula_duracion) as duracion_maxima
from peliculas p;

-- CONCAT() permite concatenar un texto a los resultados de una columna
select pelicula_titulo as titulo, CONCAT(pelicula_presupuesto, ' $') as presupuesto
from peliculas p;

-- ROUND() permite redondear valores como resultado de una operacion
select pelicula_titulo as titulo, ROUND(pelicula_presupuesto/1000000, 2) as presupuesto_en_millones 
from peliculas p;

-- LIMIT permite limitar la cantidad de resultados obtenidos en una consulta
-- 10 películas más recientes
select pelicula_titulo as titulo, pelicula_anio as anio
from peliculas p 
order by pelicula_anio desc 
limit 10;

-- 5 actores más jóvenes
select actor_nombre as nombre, year(actor_fecha_nacimiento) as fecha_nacimiento
from actores a 
order by actor_fecha_nacimiento desc 
limit 5;

-- JOINS permiten hacer consultas combinando una o más tablas a partir de una columna en la que coincidan
-- INNER JOIN va a buscar las coincidencias entre ambas tablas 
-- Peliculas y países donde se han hecho
select p.pelicula_titulo, pa.pais_nombre
from peliculas p 
inner join paises pa on p.pelicula_pais = pa.pais_id;

-- Directores y sus nacionalidades
select d.director_nombre, pa.pais_nombre
from directores d 
inner join paises pa on d.director_nacionalidad = pa.pais_id;

-- LEFT JOIN va a buscar todo de la tabla a la izquierda y sólo las coincidencias de la tabla a la derecha
-- Mostrar todos los géneros de las películas incluso si no tienen películas asociadas
select g.genero_nombre, pg.pelicula_id
from generos g -- Acá le digo a la query que tabla generos es la tabla a la izquierda
left join peliculas_generos pg on g.genero_id = pg.genero_id;

-- INSERCIONES PARA PROBAR JOINS
-- Insertamos un director que no tiene películas 
insert ignore into directores (director_nombre, director_nacionalidad) values
('Director sin peliculas', 1);

-- Insertamos otro género sin peliculas asociadas 
insert ignore into generos (genero_nombre) values ("Parodia");

-- Insertamos otro país sin películas producidas 
insert ignore into paises (pais_nombre, pais_capital) values ("Noruega", "Oslo");

-- LEFT JOIN para ver qué directores existen y si hay peliculas dirigidas por ellos 
select d.director_nombre, p.pelicula_id, p.pelicula_titulo
from directores d  -- A la izquierda se encuentra la tabla de directores 
left join peliculas p on d.director_id = p.pelicula_director; -- A la derecha se encuentra la tabla peliculas

-- RIGHT JOIN para mostrar todos los paises y si tienen peliculas hechas
select p.pais_nombre, p1pelicula_id, p1.pelicula_titulo
from peliculas p1 -- A la izquierda se encuentra la tabla paises 
right join paises p on p.pais_id = p1.peliculas_pais -- A la derecha se encuentra la tabla peliculas

-- FULL OUTER JOIN
-- Mostramos todos los directores y todas las peliculas, incluyendo los que no han dirigido nada y peliculas sin director
select d.director_nombre, p.pelicula_id, p.pelicula_titulo
from directores d
left join peliculas p on d.director_id = p.pelicula_director
union 
select d.director_nombre, p.pelicula_id, p.pelicula_titulo
from directores d
right join peliculas p on d.director_id = p.pelicula_director
where d.director_id is null; 

select d.director_nombre, p.pelicula_id, p.pelicula_titulo
from directores d
inner join peliculas p on d.director_id = p.pelicula_director;

-- QUERIES DENTRO DE QUERIES (SUBQUERY)
-- Peliculas con un presupuesto mayor al promedio 
select pelicula_titulo, pelicula_duracion, pelicula_anio, pelicula_presupuesto 
from peliculas p2
where pelicula_presupuesto > (select AVG(pelicula_presupuesto) as promedio_presupuesto
    from peliculas p); -- El resultado de la segunda query, es tomado como referencia para la query principal

-- Peliculas dirigidas por directores estadounidenses
select pelicula_titulo -- Esta query indica todas las peliculas que tengan un direct
from peliculas 
where pelicula_director in (
    select director_id
    from directores d where d.director_nacionalidad = select pais_id
                                        from paises
                                        where pais_nombre like 'Estados Unidos')
);

-- SUBQUERIES EN EL select
-- Obtener actores de una pelicula
select p.pelicula_titulo,
	(select count(*) from reparto r where p.pelicula_id = r.pelicula_id) as cantidad_actores
	from peliculas p;

-- SUBQUERY EN EL FROM
-- Peliculas que tienen una duración mayor al promedio
create view peliculas_mayor_duracion as
select p.pelicula_titulo, p.pelicula_duracion
from peliculas p,
	(select avg(pelicula_duracion) as promedio_duracion
	from peliculas) as duracion
where p.pelicula_duracion > duracion.promedio_duracion ;

-- LAS VISTAS son consultas almacenadas como tablas virtuales
select * 
from peliculas_mayor_duracion;
	
