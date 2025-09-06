Ajuda:
# \?

Quitar coisa rodando:
# q

pra criar uma database:
# CREATE DATABASE [name of databse];

para se conectar a uma database:
# psql -h localhost -p 5432 -U postgres [name of databse]

ou melhor::
listar databases:
# \l
se conectar a uma database:
# \c [database name]

deletar uma databse(bem perigoso):
# DROP DATABASE [name of databse];

criar table:
column name + data type + constraints (if there are any)

 # CREATE TABLE person (
id int,
first_name VARCHAR(50),
last_name VARCHAR(50),
gender VARCHAR(6),
date_of_birth TIMESTAMP
);

\d pra ver as tables
\d person pra ver os detalhes da table
\dt pra ver soh as tables mesmo

now lets put constraints to make it better:
 # CREATE TABLE person(
id BIGSERIAL NOT NULL PRIMARY KEY,
first_name VARCHAR(50) NOT NULL,
last_name VARCHAR(50) NOT NULL,
gender VARCHAR(50) NOT NULL,
date_of_birth DATE NOT NULL,
);

drop table:
# DROP TABLE [table name(= person)]

insert into table:
 # INSERT INTO person (
first_name,
last_name,
gender,
date_of_birth,
email)
VALUES ('Jake', 'Jones', 'MALE', DATE '1990-01-10', 'jake@gmail.com');

// up arrow gets last command

to see data in the table:
# TABLE person

lets add 1000 people int our table using mockeroo to mock values:
\\ a gent ebaixou o aqruvo sql e abriu no editor de texto
\\ agora nois roda esse script no prompt
# \i path_to_file
// pra dar as permissoes:
 // need to be superuser:
 # ALTER USER postgres WITH SUPERUSER;
 # GRANT CONNECT ON DATABASE test TO postgres ;
 # GRANT ALL PRIVILEGES ON DATABASE test TO postgres;
 # GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO postgres;
 # GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO postgres;
 # ALTER DEFAULT PRIVILEGES GRANT ALL ON TABLES TO postgres;

path = C:/Users/bruno/Desktop/Trabalhos_e_Area_de_Trabalho/curso_Web_Development/person.sql

TEM QUE COLOCAR AS BARRAS NESSE SENTIDO!!
// inverter o sentido das barras que fez dar certo

pra da clear na tela:
# \! cls 

select from:
SELECT * FROM person; // selects everything

order by:
SELECT * FROM person ORDER BY date_of_birth DESC;
SELECT country_of_birth FROM person ORDER BY country_of_birth

distinct:
SELECT DISTINCT country_of_birth FROM person ORDER BY country_of_birth; // um de cada

where / and:
SELECT * FROM PERSON WHERE gender == 'Female' OR country_of_birth == 'China';

comparisons (returns boolean):
// <> is not equal operator

limit, offset & fetch:
SELECT*FROM person LIMIT 10; // primeiras 10 linhas
SELECT*FROM person OFFSET 5 LIMIT 5; // msm coisa sohq comecando num offset de 5
SELECT*FROM person OFFSET 5 FETCH 5; // msm coisa sohq eh padrao sql

in:
SELECT* FROM person WHERE country_of_birth IN ('China', 'Brazil', 'France');

between:
SELECT* FROM person WHERE date_of_birth BETWEEN DATE '2000-01-01' AND '2015-01-01';

like/ ilike:
SELECT* FROM person WHERE email LIKE '%@google.%'; // % is any character
SELECT* FROM person WHERE email LIKE '%_____@google.%'; // % is any character, 5 underscores means 5 any characters 
// ilike ignores lower/upper cases

groupby:
SELECT country_of_birth, COUNT(*) FROM person GROUP BY country_of_birth;

grouby having:
SELECT country_of_birth, COUNT(*) FROM person GROUP BY country_of_birth HAVING COUNT(*) > 5 ORDER BY country_of_birth;


// new table created avout car sales
MAX/MIN/AVG/SUM operations:
SELECT MAX(price) FROM car;
SELECT ROUND(AVAREGE(price)) FROM car;
SELECT make, model MIN(price) FROM car GROUP BY make, model;
SELECT SUM(price) FROM car;

// * é multiplicacao ^ é elevado, ! faz fatorial, % é sobra da divisao

// queremos ver os precos com desconto de 10%
SELECT id, make, model, price AS ORIGINAL PRICE, ROUND(price*.10, 2), ROUND(price - (price*10), 2) AS with_discount FROM car;

// vamo colocar pras pessoas que nao tem email, um aviso 'email not privided' com COALESCE:
SELECT COALESCE (email, 'email not provided') FROM person;

// NULLIF to handle division by zero

//dealing with timestamps:
SELECT NOW()::DATE; 
SELECT NOW()::TIME;
//subtracting/simming dates:
SELECT NOW() - INTERVAL '10 DAYS';
SELECT (NOW() + INTERVAL '10 DAYS')::DATE;
// extracting values from timestamp:
SELECT EXTRACT(MONTH FROM NOW());
//age function:
AGE(NOW(), date_of_birth)


Primary Keys:
// suppose we want to add a new row to our person table with id==1;
// it would give an error
// we can overcome by altering the table, taking off the constraint:
ALTER TABLE person DROP CONSTRAINT person_pkey;
//adding primary:
ALTER TABLE person ADD PRIMARY KEY(id); // but the column id is already unique in every row

//unique constraints: (unique value per column)
ALTER TABLE ADD CONSTRAINT unique_email_adress UNIQUE (email);
//check constraints:
// lets make sure that we can only add male and female to the gender column:
ALTER TABLE person ADD CONSTRAINT gender_constraint CHECK (gender = 'Female' OR gender ='Male');

//DELETE:
DELETE FROM person WHERE id== 1011;
// and so on...

//UPDATE:
UPDATE person SET email =  'ommar@gmail.com' WHERE id = 2011;
UPDATE person SET first_name = 'Omar', last_name = 'Montana', email = 'omar.montana@hotmail' WHERE id= 2011;

// On Conflict do Nothing:
// lets saywe iserted a row with same id:
// type at the end :
// ON CONFLICT (id) DO NOTHING; // just wont insert

// lets say the guy sent a new row but with a different email:
// type afterwards:
ON CONFLICT (id) DO UPDATE SET email = EXCLUDED.email; // vai trocar o email pelo ultimo que ele mandou

// Foreign Keys and Joins:
// lets add a relationship between table person and car 
// we will create new tables:
crate table person (
	(all the usual stuff)
	car_id BIGINT REFERENCES car (id),
	UNIQUE(car_id)
)
// so lets assign a car to fernanda:
UPDATE person SET car_id = 2 WHERE id = 1;

// if we try:
// UPDATE person SET car_id = 823283 WHERE id = 1; // we will get error because in table car there isnt this id

Inner Joins:
SELECT * FROM person JOIN car ON person.car_id = car.id;
\x to better display 
SELECT * FROM person;
// if we wanted to select just some columns:
SELECT person.first_name, car.make, car.model, car.price (and so on)
// if we wanted to include people that dont have cars also, use LEFT JOIN (they will have null values in the columns related to the car table)

// Deleting values with foreign keys:
// por default nao da pra apagar linhas que tem referencia em outra tabela
// o jeito certo se vc quiser deletar as referencias tb, eh primeiro deletar as referecias dps as linhas e nao usar CASCADE
// obs: referencias eh onde tao as foreign keys

//Exporting Query results to CSV:
\copy (SELECT * FROM person LEFT JOIN car ON car.id = person,car_id) TO 'path_to_file' DELIMITER ',' CSV HEADER;

// Serials and Sequences:
ALTER SEQUENCE person_id_seq RESTART WITH 10; // recomeca a contagem do BIGSERIAL

//Extensions:
// are basically functions that can extra functionality to your database
// to seea vailable extensions:
SELECT FROM pg_avilable_extensions;
// lets use the one that makes universally unique identifiers for our primary key (very secure):
CREATE EXTENSION IF NOT EXISTS 'uuid-ossp';
\df // to see available functions
// lets use the random version:
SELECT uuid_generate_v4(); // generate a key that is globally unique every time

// UUID as Primary Key
// lets create the table again:

create table(
	person_uid UUID NOT NULL PRIMARY KEY,
	(and so on)
	car_uid UUID REFERENCES car(car_uid),
	(and so on)
);

//and now we have to change the insert, because our primary key is not automatic anymore
insert into person(person_uid, e as outras colunas etc);
values(uuid_generate_v4(), e os outros valores etc);
//and then we assign people who own cars like usual

//obs: remember to create table that is referenced before the table with foreign key

//  if the primary primary key and foreign key have the same name 
// we can join like this:
LEFT JOIN car USING (car_uid);




























































