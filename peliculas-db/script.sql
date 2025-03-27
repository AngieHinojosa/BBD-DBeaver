-- use testdb;

-- comentarios se crean con doble guión
-- show tables; comando que me permite ver las tablas de una BDD

create database if not exists peliculas
	character set utf8mb4
	collate utf8mb4_unicode_ci;

use peliculas; -- Conectamos a la BDD películas

-- Creamos las tablas para la BDD películas
-- COMANDOS DE ESTRUCTURA DE DATOS, TIPOS DE DATOS Y RESTRICCIONES

create table if not exists generos (
	genero_id INT primary key auto_increment, -- El id se genera automáticament y de manera incremental
	genero_nombre VARCHAR(50) 
);

create table if not exists paises (
	pais_id INT primary key auto_increment,
	pais_nombre VARCHAR(50) ,
	pais_capital VARCHAR(50)
);

create table if not exists directores (
	director_id INT primary key auto_increment,
	director_nombre VARCHAR(50),
	director_nacionalidad INT, -- Creamos la columna que lleva el id del país
	director_fecha DATE,
	foreign key (director_nacionalidad) references paises(pais_id)
	-- Indicamos primero la columna que va a llevar la llave foránea
	-- Luego, indicamos la columna de la otra tabla que proporciona la llave 
);


create table if not exists peliculas (
	pelicula_id INT primary key auto_increment,
 	pelicula_titulo VARCHAR(100) not null unique,
 	pelicula_anio INT check(pelicula_anio between 1880 and 2025), -- Restricción check, va a verificar que el ingreso cumpla alguna condición
 	pelicula_duracion INT default 0, -- Restricción default, va a asignar un valor si se ingresa este campo como nulo
 	pelicula_director INT not null,
 	pelicula_pais INT not null,
 	pelicula_presupuesto DECIMAL(10, 2), -- El Decimal es más exacto al momento de indicar cantidad de dígitos y decimales
	foreign key (pelicula_director) references directores(director_id), -- on delete set null y on delete cascade permiten indicar cómo se propagan las acciones sobre una referencia
	foreign key (pelicula_pais) references paises(pais_id)
 );

create table if not exists peliculas_generos ( 
	pelicula_id INT,
	genero_id INT,
	foreign key (pelicula_id) references peliculas(pelicula_id),
	foreign key (genero_id) references generos(genero_id)
);

create table if not exists criticas (
	critica_id INT primary key auto_increment,
	critica_resenia VARCHAR(255),
	critica_puntaje smallint check(critica_puntaje between 1 and 10),
	critica_pelicula INT unique,
	foreign key (critica_pelicula) references peliculas(pelicula_id) 
		on delete cascade
);

-- COMANDOS PARA ALTERAR LA ESTRUCTURA

-- Comando ALTER TABLE permite realizar cambios sobre la estructura de una tabla

alter table generos 
modify column genero_nombre VARCHAR(50) not null unique;
-- modify permite modificar tipo de dato y restricciones de una columna

alter table peliculas 
add column idioma_original VARCHAR(50) default "Inglés" after pelicula_anio;
-- add permite añadir una nueva columna y after o before para indicar en qué posición


alter table criticas 
rename column critica_resenia to critica_comentario;
-- rename permite cambiar el nombre de una columna, verifica primero si hay una restricción

-- DROP COLUMN (USAR CON PRECAUCIÓN)
alter table peliculas 
drop column idioma_original;

-- DROP TABLE (BORRA LA TABLA Y SUS DATOS)
-- drop table criticas;

-- DROP DATABASE (BORRA LA BASE Y SUS DATOS)
-- drop database peliculas;

-- TRUNCATE elimina registros dentro de una tabla
-- truncate table generos;

-- COMANDOS PARA REALIZAR INSERCIONES, ACTUALIZAR DATOS Y ELIMINAR
-- INSERCIONES

insert into generos (genero_nombre) values 
	("Comedia"),
	("Ciencia Ficción"),
	("Drama"),
	("Romántica"),
	("Terror"),
	("Musical"),
	("Fantasía"),
	("Bélica"),
	("Acción"),
	("Suspenso"),
	("Animada"),
	("Histórica"),
	("Aventura"),
	("Misterio"),
	("Biográfica"),
	("Fantasía Científica");

insert into paises (pais_nombre, pais_capital) values
	("Estados Unidos", "Washington D.C"),
	("Reino Unido", "Londres"),
	("Chile", "Santiago"),
	("Alemania", "Berlín"),
	("Grecia", "Atenas"),
	("Francia", "París"),
	("Polonia", "Varsovia");


insert ignore into directores (director_nombre, director_nacionalidad, director_fecha) values
	("Damien Chazelle", 6 ,'1985-01-19'),
	("Kennen Ivory Wayans", 1 ,'1958-06-08'),
	("Agnieszka Holland", 7 ,'1948-11-28'),
	("Yorgos Lanthimos", 5 , '1973-09-23'),
	("Tim Burton", 1, '1958-08-25'),
	("Phillida Lloyd", 2 , '1957-06-17');

insert ignore into directores (director_nombre, director_nacionalidad, director_fecha) values
	("Aldo Francia", 3 , '1923-08-30');

insert ignore into peliculas (pelicula_id, pelicula_titulo, pelicula_anio, pelicula_duracion, 
pelicula_director, pelicula_pais, pelicula_presupuesto) values
	(1, "Mamma Mia", 2008, 108,13, 2, 52000000.00),
	(2, "Jardín Secreto", 1993, 101, 10, 2, 18000000.00),
	(3, "Canino", 2009, 97, 11, 5, 250000.00),
	(4, "Pobres Criaturas", 2023, 141, 11, 1, 35000000.00),
	(5, "Scary Movie", 2000, 88, 9, 1, 19000000.00),
	(6, "LaLaLand", 2016, 128, 8, 1, 30000000.00),
	(7, "El Joven manos de tijera", 1990, 104, 12, 1, 20000000.00),
	(8, "El cadáver de la novia", 2005, 76, 12, 2, 40000000.00);

insert ignore into peliculas_generos (pelicula_id, genero_id) values
	(1, 1),
	(1, 4),
	(1, 6),
	(2, 3),
	(2, 12),
	(3, 3),
	(4, 16),
	(5, 1),
	(6, 3),
	(6, 4),
	(6, 6),
	(7, 4),
	(7, 1),
	(7, 7),
	(8, 7),
	(8, 11),
	(8, 6);

	
-- COMANDO PARA ACTUALIZAR
-- UPDATE
update criticas 
set critica_puntaje = 9
where critica_pelicula = 3;

update criticas 
set critica_comentario = "Excelente"
where critica_pelicula = 3;

-- COMANDO PARA BORRAR REGISTROS
-- DELETE
delete from criticas; -- USAR delete con where o tener mucha precaución
 	
-- delete from directores 
-- where director_id in (6,7);

-- COMANDOS PARA HACER QUERIES
-- SELECT
select *
from peliculas 
where pelicula_titulo = "LaLaLand";



show tables;