use peliculas;

-- Tabla de actores
create table if not exists actores (
    actor_id INT primary key auto_increment,
    actor_nombre VARCHAR(100) not null,
    actor_fecha_nacimiento DATE,
    actor_nacionalidad INT,
    foreign key (actor_nacionalidad) references paises(pais_id)
);

-- Tabla de reparto (relación muchos a muchos entre películas y actores)
create table if not exists reparto (
    pelicula_id INT,
    actor_id INT,
    personaje VARCHAR(100),
    primary key (pelicula_id, actor_id),
    foreign key (pelicula_id) references peliculas(pelicula_id) on delete cascade,
    foreign key (actor_id) references actores(actor_id) on delete cascade
);

-- Tabla de premios
create table if not exists premios (
    premio_id INT primary key auto_increment,
    premio_nombre VARCHAR(100) not null,
    premio_categoria VARCHAR(100),
    premio_anio INT
);

-- Tabla de premios_peliculas (relación muchos a muchos)
create table if not exists premios_peliculas (
    premio_id INT,
    pelicula_id INT,
    ganador boolean default false,
    primary key (premio_id, pelicula_id),
    foreign key (premio_id) references premios(premio_id) on delete cascade,
    foreign key (pelicula_id) references peliculas(pelicula_id) on delete cascade
);

alter table peliculas 
modify column pelicula_presupuesto DECIMAL(15, 2);

-- Insertar más países
insert ignore into (pais_nombre, pais_capital) values
    ('México', 'Ciudad de México'),
    ('Brasil', 'Brasilia'),
    ('Argentina', 'Buenos Aires'),
    ('Canadá', 'Ottawa'),
    ('Australia', 'Canberra'),
    ('Japón', 'Tokio'),
    ('Corea del Sur', 'Seúl');

-- Insertar más directores
insert ignore into (director_nombre, director_nacionalidad, director_fecha) values
    ('Christopher Nolan', 2, '1970-07-30'),
    ('Quentin Tarantino', 1, '1963-03-27'),
    ('Bong Joon-ho', 7, '1969-09-14'),
    ('Guillermo del Toro', 8, '1964-10-09'),
    ('Alejandro González Iñárritu', 8, '1963-08-15'),
    ('Martin Scorsese', 1, '1942-11-17'),
    ('Steven Spielberg', 1, '1946-12-18'),
    ('Greta Gerwig', 1, '1983-08-04'),
    ('Alfonso Cuarón', 8, '1961-11-28'),
    ('Denis Villeneuve', 4, '1967-10-03');

-- Insertar más películas populares (desde los 90 hasta ahora)
insert ignore into (pelicula_titulo, pelicula_anio, pelicula_duracion, pelicula_director, pelicula_pais, pelicula_presupuesto) values
    ('Pulp Fiction', 1994, 154, 14, 1, 8000000.00),
    ('El Caballero de la Noche', 2008, 152, 11, 1, 185000000.00),
    ('Parásitos', 2019, 132, 13, 7, 11400000.00),
    ('El Laberinto del Fauno', 2006, 118, 14, 8, 19000000.00),
    ('Birdman', 2014, 119, 15, 1, 18000000.00),
    ('Titanic', 1997, 195, 17, 1, 200000000.00),
    ('Forrest Gump', 1994, 142, 17, 1, 55000000.00),
    ('El Padrino', 1972, 175, 16, 1, 6000000.00),
    ('Interestelar', 2014, 169, 11, 1, 165000000.00),
    ('Dune', 2021, 155, 20, 4, 165000000.00),
    ('Barbie', 2023, 114, 18, 1, 145000000.00),
    ('Oppenheimer', 2023, 180, 11, 1, 100000000.00),
    ('El Irlandés', 2019, 209, 16, 1, 159000000.00),
    ('Whiplash', 2014, 106, 8, 1, 3300000.00),
    ('La Forma del Agua', 2017, 123, 14, 1, 19500000.00);

-- Insertar géneros adicionales
insert ignore into (genero_nombre) values
    ('Crimen'),
    ('Western'),
    ('Documental'),
    ('Cine Negro'),
    ('Superhéroes');
   
-- Insertar relaciones entre películas y géneros
insert ignore into peliculas_generos (pelicula_id, genero_id) values
	(5, 5),  
	(24, 9), 
	(24, 17),
	(24, 3), 
	(25, 9), 
	(25, 21),
	(25, 17),
	(25, 10),
	(26, 3), 
	(26, 10),
	(26, 17),
	(27, 7), 
	(27, 12),
	(27, 5), 
	(28, 3),
	(28, 1),
	(29, 3),
	(29, 4), 
	(29, 12),
	(30, 3), 
	(30, 15),
	(31, 3), 
	(31, 17),
	(32, 2), 
	(32, 3), 
	(32, 13),
	(33, 2), 
	(33, 13),
	(33, 9), 
	(34, 1), 
	(34, 7), 
	(35, 3), 
	(35, 12),
	(35, 15),
	(36, 3), 
	(36, 17),
	(36, 12),
	(37, 3), 
	(37, 6), 
	(38, 3), 
	(38, 4), 
	(38, 7); 

-- Insertar actores famosos
insert ignore into actores (actor_nombre, actor_fecha_nacimiento, actor_nacionalidad) values
    ('Leonardo DiCaprio', '1974-11-11', 1),
    ('Tom Hanks', '1956-07-09', 1),
    ('Meryl Streep', '1949-06-22', 1),
    ('Song Kang-ho', '1967-01-17', 7),
    ('Emma Stone', '1988-11-06', 1),
    ('Ryan Gosling', '1980-11-12', 4),
    ('Margot Robbie', '1990-07-02', 5),
    ('Christian Bale', '1974-01-30', 2),
    ('Cate Blanchett', '1969-05-14', 5),
    ('Joaquin Phoenix', '1974-10-28', 1),
    ('Robert Downey Jr.', '1965-04-04', 1),
    ('Scarlett Johansson', '1984-11-22', 1),
    ('Brad Pitt', '1963-12-18', 1),
    ('Jennifer Lawrence', '1990-08-15', 1),
    ('Timothée Chalamet', '1995-12-27', 1);

-- Insertar reparto
insert ignore into reparto (pelicula_id, actor_id, personaje) values
    (1, 1, 'Donnie Azoff'),           -- Mamma Mia / Leonardo DiCaprio
    (1, 2, 'Jordan Belfort'),         -- Mamma Mia / Tom Hanks
    (2, 3, 'Mia Thermopolis'),        -- Jardín Secreto / Meryl Streep
    (3, 4, 'Christina'),              -- Canino / Song Kang-ho
    (4, 5, 'Bella Baxter'),           -- Pobres Criaturas / Emma Stone
    (5, 6, 'Cindy Campbell'),         -- Scary Movie / Ryan Gosling
    (6, 7, 'Sebastian'),              -- LaLaLand / Margot Robbie
    (6, 8, 'Mia'),                    -- LaLaLand / Christian Bale
    (7, 9, 'Edward Scissorhands'),    -- El Joven manos de tijera / Cate Blanchett
    (8, 10, 'Victor'),                -- El cadáver de la novia / Joaquin Phoenix
    (24, 11, 'Vincent Vega'),         -- Pulp Fiction / Robert Downey Jr.
    (24, 12, 'Jules Winnfield'),      -- Pulp Fiction / Scarlett Johansson
    (25, 13, 'Bruce Wayne/Batman'),   -- El Caballero de la Noche / Brad Pitt
    (25, 14, 'Joker'),                -- El Caballero de la Noche / Jennifer Lawrence
    (26, 15, 'Kim Ki-taek');          -- Parásitos / Timothée Chalamet

-- Insertar premios importantes
insert ignore into premios (premio_nombre, premio_categoria, premio_anio) values
    ('Óscar', 'Mejor Película', null),
    ('Óscar', 'Mejor Director', null),
    ('Óscar', 'Mejor Actor', null),
    ('Óscar', 'Mejor Actriz', null),
    ('Globo de Oro', 'Mejor Película - Drama', null),
    ('BAFTA', 'Mejor Película', null),
    ('Festival de Cannes', 'Palma de Oro', null);

-- Premios películas
insert ignore into premios_peliculas (premio_id, pelicula_id, ganador) values
    (1, 26, true),   -- Parásitos (ID 26) - Óscar a Mejor Película
    (2, 28, true),   -- Birdman (ID 28) - Óscar a Mejor Director
    (3, 1, true),    -- Mamma Mia (ID 1) - Óscar a Mejor Actor (ajustar según realidad)
    (4, 4, true),    -- Pobres Criaturas (ID 4) - Óscar a Mejor Actriz
    (5, 25, true),   -- El Caballero de la Noche (ID 25) - Globo de Oro
    (6, 26, true),   -- Parásitos (ID 26) - BAFTA
    (7, 24, true),   -- Pulp Fiction (ID 24) - Palma de Oro
    (1, 29, true),  -- Titanic (ID 29) nominada a Óscar
    (1, 30, true);  -- Forrest Gump (ID 30) nominada a Óscar

-- Tabla de usuarios
create table if not exists usuarios (
    usuario_id INT primary key auto_increment,
    usuario_nombre VARCHAR(100) not null,
    usuario_email VARCHAR(100) unique not null,
    usuario_fecha_registro DATE default (CURRENT_DATE)
);

-- Tabla de calificaciones de usuarios
create table if not exists calificaciones (
    calificacion_id INT primary key auto_increment,
    usuario_id INT,
    pelicula_id INT,
    puntuacion TINYINT check (puntuacion between 1 and 5),
    fecha_calificacion DATETIME default CURRENT_TIMESTAMP,
    foreign key (usuario_id) references usuarios(usuario_id) on delete cascade,
    foreign key (pelicula_id) references peliculas(pelicula_id) on delete cascade,
    unique (usuario_id, pelicula_id) -- Un usuario solo puede calificar una película una vez
);

-- Insertar usuarios y calificaciones
insert ignore into usuarios (usuario_nombre, usuario_email) values
    ('Juan Pérez', 'juan@example.com'),
    ('María García', 'maria@example.com'),
    ('Carlos López', 'carlos@example.com'),
    ('Ana Martínez', 'ana@example.com'),
    ('Luis Rodríguez', 'luis@example.com');

-- Inserción corregida de calificaciones (asegurando que los IDs existan)
-- Insertar todas las calificaciones con IGNORE
insert ignore into calificaciones (usuario_id, pelicula_id, puntuacion) values
    (1, 1, 5), (1, 2, 4), (1, 24, 5),
    (2, 3, 5), (2, 4, 3), (2, 25, 4),
    (3, 5, 5), (3, 6, 4), (3, 26, 5),
    (4, 7, 5), (4, 8, 4), (4, 27, 5),
    (5, 24, 4), (5, 28, 5), (5, 29, 5);