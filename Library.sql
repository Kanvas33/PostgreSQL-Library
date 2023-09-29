PostgreSQL Library

-----------------------------------------------------------
/* TABLE CONSTRUCTION WITHOUT FK						   
-----------------------------------------------------------

- auxiliary tables */ -----------------------------------------------------------

/* create table/entity "editoras"
pk= datatype: serial */
create table editoras (
   codigo serial primary key,
   nome varchar(50) not null
);


/* create table/entity "cidades"
pk= datatype: serial */
create table cidades (
   codigo serial primary key,
   cidade varchar(100) not null,
   estado char(2) not null
);


/* create table/entity "encadernacoes"
pk= datatype: serial */
create table encadernacoes (
   codigo serial primary key,
   tipo varchar(50) not null
);


/* create table/entity "autores"
pk= datatype: serial */
create table autores (
   codigo serial primary key,
   nome varchar(100) not null
);

-----------------------------------------------------------
/* TABLE CONSTRUCTION WITH FK,							   
but I will introduce FK and the relationship later         
-----------------------------------------------------------

- main tables */ -----------------------------------------------------------

/* create table "livros"
pk= datatype: serial */
create table livros (
   codigo serial primary key,
   cod_isbn varchar(30) not null,
   titulo varchar(100) not null,
   volume numeric(3),
   nro_edicao numeric(4),
   cod_encadernacao integer not null,
   cod_editora integer not null,
   cod_cidade_publi integer not null,
   cod_socio_reserva integer not null,
   data_publicacao date not null,
   reserva boolean not null
);

select * from livros;

/* create table "socios"
pk= datatype: serial */
create table socios (
   codigo serial primary key,
   nome varchar(50) not null,
   sobrenome varchar(50) not null,
   enredeco varchar(200) not null,
   cep varchar(9) not null,
   telefone varchar(20) not null,
   cod_cidade integer not null
);


/* create table "livros_autores"
identified by composite key (PFK)
composite key is declared at the end of the "create table" code */
create table livros_autores (
   cod_livro integer not null,
   cod_autor integer not null,
   primary key(cod_livro, cod_autor)
);


/* create table "locacoes"
identified by composite key (PFK)
composite key is declared at the end of the "create table" code */
create table locacoes (
   cod_socio integer not null,
   cod_livro integer not null,
   data_emprestimo date not null,
   data_prevista date not null,
   data_devolucao date not null,
   taxa numeric(4),
   primary key(cod_socio, cod_livro, data_emprestimo)
);

/*
----------------------------------------------------------------------
                                                                      
                    CREATE RELATIONSHIPS AND FK (foreign key)         
                    USING ALTER TABLE                                 
                                                                      
                    CREATING CONSTRAINTS WHEN CREATING RELATIONSHIPS: 
                                                                      
                    - ON DELETE CASCADE                               
                    - ON DELETE SET NULL                              
                    - ON DELETE SET DEFAULT                           
                    - ON DELETE RESTRICT                              
                    - ON DELETE NO ACTION                             
                                                                        
----------------------------------------------------------------------
*/

/* adding FK ATTRIBUTE ---------------------------------------------------
table/entity "livros" */
alter table livros
add foreign key(cod_editora)
references editoras(codigo);

alter table livros
add foreign key(cod_encadernacao)
references encadernacoes(codigo);

alter table livros
add foreign key(cod_cidade_publi)
references cidades(codigo);

alter table livros
add foreign key(cod_socio_reserva)
references socios(codigo);

-- adding FK ATTRIBUTE in the table/entity "livros_autores",
-- related to the "livros" table. */
alter table livros_autores
add foreign key(cod_livro)
references livros(codigo);

alter table livros_autores
add foreign key(cod_autor)
references autores(codigo);

/* adding FK ATTRIBUTE table/entity "socios" */
alter table socios
add foreign key(cod_cidade)
references cidades(codigo);

/* adding FK ATTRIBUTE table/entity "locacoes" */
alter table locacoes
add foreign key(cod_socio)
references socios(codigo);

alter table locacoes
add foreign key(cod_livro)
references livros(codigo);

-- ALTERING COLUMN CONSTRAINT
/* change "not null" from columns. So the data will not
be mandatory to be inserted */

alter table livros
alter column cod_socio_reserva
drop not null;

/* columns "data_devolucao" and "taxa" will be filled in
when the book is returned */
alter table locacoes
alter column data_devolucao
drop not null;

alter table livros
alter column reserva
set default false;

-- CREATION OF RELATIONSHIPS - PK/FK (ADVANCED) -----------------------------------
-- BECAUSE IT WILL CONFIGURE A FK WITH CONSTRAINTS OR WITHOUT CONSTRAINTS
-- USING "ON DELETE" OR "ON UPDATE"


-- ON DELETE CASCADE
-- CREATE RELATIONSHIP FK/PK WITH TABLE "locacoes" AND "socios"
alter table locacoes
add foreign key(cod_socio)
references socios(codigo)
ON DELETE CASCADE; -- WHEN DELETING RECORDS IN THE "socios" TABLE
-- ALL REFERENCES TO IT IN THE "locacoes" TABLE WILL BE DELETED.



-- ON DELETE SET NULL
-- CREATE RELATIONSHIP FK/PK WITH TABLE "livros" AND "socios"
alter table livros
add foreign key(cod_socio_reserva)
references socios(codigo)
ON DELETE SET NULL; -- WHEN DELETING A RECORD FROM THE "socios" TABLE
-- ALL REFERENCES TO IT ASSIGNED IN THE "livros" TABLE WILL BE SET TO "NULL".



-- ON DELETE RESTRICT
-- CREATE RELATIONSHIP FK/PK WITH TABLE "locacoes" AND "socios"
alter table locacoes
add foreign key(cod_socio)
references socios(codigo)
ON DELETE RESTRICT; -- WHEN DELETING RECORDS IN THE "socios" TABLE
-- ALL REFERENCES TO IT IN THE "locacoes" TABLE WILL NOT BE DELETED.



-- ON DELETE SET DEFAULT
-- CREATE RELATIONSHIP FK/PK WITH TABLE "locacoes" AND "socios"
alter table locacoes
add foreign key(cod_socio)
references socios(codigo)
ON DELETE SET DEFAULT;-- WHEN DELETING A RECORD FROM THE "socios" TABLE
-- ALL REFERENCES TO IT ASSIGNED IN THE "locacoes" TABLE WILL BE SET TO THE "DEFAULT" VALUE.



-- ON DELETE NO ACTION
-- CREATE RELATIONSHIP FK/PK WITH TABLE "locacoes" AND "socios"
alter table locacoes
add foreign key(cod_socio)
references socios(codigo)
ON DELETE NO ACTION; -- WHEN DELETING A RECORD FROM THE "socios" TABLE
-- ALL REFERENCES TO IT ASSIGNED IN THE "locacoes" TABLE WILL NOT BE DELETED.
-- DEFAULT OPTION

/*
--------------------------------------------------------------------
                                                                    
                INSERT DATA INTO TABLE RECORDS                      
                                                                    
                                                                    
--------------------------------------------------------------------
*/

/* table "editoras" */
insert into editoras(nome) values('Record');
insert into editoras(nome) values('Suma');
insert into editoras(nome) values('Todavia');
INSERT INTO editoras (nome) VALUES ('Intrínseca');
INSERT INTO editoras (nome) VALUES ('Rocco');
INSERT INTO editoras (nome) VALUES ('Companhia da Letras');
INSERT INTO editoras (nome) VALUES ('Arqueiro');
INSERT INTO editoras (nome) VALUES ('Sextante');
INSERT INTO editoras (nome) VALUES ('Gente');

select * from editoras;

/* table "cidades" */
INSERT INTO cidades (cidade, estado) VALUES ('São Paulo','SP');
INSERT INTO cidades (cidade, estado) VALUES ('Rio de Janeiro','RJ');
INSERT INTO cidades (cidade, estado) VALUES ('Porto Alegre','RS');
INSERT INTO cidades (cidade, estado) VALUES ('Salvador','BA');
INSERT INTO cidades (cidade, estado) VALUES ('Farroupilha','RS');
INSERT INTO cidades (cidade, estado) VALUES ('Caxias do Sul','RS');

/* show the sequence PK of the table */
select * from cidades_codigo_seq;
/* to restart the sequence if necessary */
alter sequence cidades_codigo_seq restart;

select * from cidades;

/* table "encadernacoes" */
INSERT INTO encadernacoes (tipo) VALUES ('Brochura');
INSERT INTO encadernacoes (tipo) VALUES ('Espiral');
INSERT INTO encadernacoes (tipo) VALUES ('Wire-o');

select * from encadernacoes;

/* table "autores" */
INSERT INTO autores (nome) VALUES ('Gabriel García Márquez');
INSERT INTO autores (nome) VALUES ('Paulo Coelho');
INSERT INTO autores (nome) VALUES ('Umberto Eco');
INSERT INTO autores (nome) VALUES ('Eric Nepomuceno');
INSERT INTO autores (nome) VALUES ('Marcia Denser');
INSERT INTO autores (nome) VALUES ('Gabriel García Márquez');
INSERT INTO autores (nome) VALUES ('Beatriz Horta');
INSERT INTO autores (nome) VALUES ('Julia Quinn');
INSERT INTO autores (nome) VALUES ('Ana Rodrigues');
INSERT INTO autores (nome) VALUES ('Ken Follett');
INSERT INTO autores (nome) VALUES ('Charlie Donlea');
INSERT INTO autores (nome) VALUES ('Olivier Guez');
INSERT INTO autores (nome) VALUES ('Jorge Amado');
INSERT INTO autores (nome) VALUES ('Rick Riordan');
INSERT INTO autores (nome) VALUES ('Fernanda Abreu');

select * from autores;

/* change the error in the attribute name (rename column) */
alter table socios
rename column enredeco to endereco;

/* table "socios" */
/* show the sequence PK of the table */
select * from socios_codigo_seq;
/* to restart the sequence if necessary */
alter sequence cidades_codigo_seq restart;

INSERT INTO socios (nome, sobrenome, endereco, cep, telefone, cod_cidade)
VALUES 
('Ana Maria','Souza','Rua A, 25','98654-989','99896-2542',6) ;
INSERT INTO socios (nome, sobrenome, endereco, cep, telefone, cod_cidade) 
VALUES
('João','Amaro','Rua Outubro, 89','78654-989','97796-2543',6) ;
INSERT INTO socios (nome, sobrenome, endereco, cep, telefone, cod_cidade) 
VALUES
('Paula','Souza','Rua 7 de Setembro, 321','54125-989','3025-0965',6) ;
INSERT INTO socios (nome, sobrenome, endereco, cep, telefone, cod_cidade) 
VALUES
('Anelise','Andrade','Rua Bento, 23','98542-888','2105-9654',5) ;
INSERT INTO socios (nome, sobrenome, endereco, cep, telefone, cod_cidade) 
VALUES
('Pedro','Gusmão','Rua Augusta, 99','85212-111','9871-9656',5) ;
INSERT INTO socios (nome, sobrenome, endereco, cep, telefone, cod_cidade) 
VALUES
('Catarina','Andrade','Av. Julio','85412-885','3424-8525',4) ;
INSERT INTO socios (nome, sobrenome, endereco, cep, telefone, cod_cidade) 
VALUES
('Carlos','Vivencio','Av. Ceara','74654-989','98545-9965',3) ;
INSERT INTO socios (nome, sobrenome, endereco, cep, telefone, cod_cidade) 
VALUES
('Paula','Tess','Rua C, 55','14789-987','2565-2542',6) ;

select * from socios;

/* table "livros" */
/* show the sequence PK of the table */
select * from livros_codigo_seq;

INSERT INTO livros (cod_isbn, titulo, volume, nro_edicao, cod_encadernacao, cod_editora,
data_publicacao, cod_cidade_publi, reserva)
VALUES ('8501046949', 'Notícia de um sequestro', 1, 5, 1, 1, '1996/11/13', 1, 'FALSE');
INSERT INTO livros (cod_isbn, titulo, volume, nro_edicao, cod_encadernacao, cod_editora,
data_publicacao, cod_cidade_publi, reserva)
VALUES ('8332046949', 'A Filha das Profundezas', 1, 4, 1, 4, '2021/11/09', 2, 'FALSE');
INSERT INTO livros (cod_isbn, titulo, volume, nro_edicao, cod_encadernacao, cod_editora,
data_publicacao, cod_cidade_publi, reserva)
VALUES ('8334046949', 'A Pirâmide Vermelha', 1, 1, 1, 4, '2010/11/17', 2, 'FALSE');
INSERT INTO livros (cod_isbn, titulo, volume, nro_edicao, cod_encadernacao, cod_editora,
data_publicacao, cod_cidade_publi, reserva)
VALUES ('6555651016', 'Esplêndida', 1, 1, 1, 7, '2021/04/15', 3, 'FALSE');
INSERT INTO livros (cod_isbn, titulo, volume, nro_edicao, cod_encadernacao, cod_editora,
data_publicacao, cod_cidade_publi, reserva)
VALUES ('4245651016', 'Os pilares da terra', 3,10, 1, 7, '2015/02/10', 1, 'FALSE');
INSERT INTO livros (cod_isbn, titulo, volume, nro_edicao, cod_encadernacao, cod_editora,
data_publicacao, cod_cidade_publi, reserva)
VALUES ('3245651016', 'Inverno do Mundo', 1,1, 1, 7, '2015/03/15', 2, 'FALSE');
INSERT INTO livros (cod_isbn, titulo, volume, nro_edicao, cod_encadernacao, cod_editora,
data_publicacao, cod_cidade_publi, reserva)
VALUES ('4995651016', 'Capitaes da Areia', 1,1, 1, 8, '2008/03/10', 4, 'FALSE');
INSERT INTO livros (cod_isbn, titulo, volume, nro_edicao, cod_encadernacao, cod_editora,
data_publicacao, cod_cidade_publi, reserva)
VALUES ('6675651016', 'Dona flor e seus dois maridos', 1,1, 1, 8, '2008/03/10', 4, 'FALSE');
INSERT INTO livros (cod_isbn, titulo, volume, nro_edicao, cod_encadernacao, cod_editora,
data_publicacao, cod_cidade_publi, reserva)
VALUES ('9995651016', 'Mar Morto', 1,1, 1, 8, '2008/03/10', 4, 'FALSE');
INSERT INTO livros (cod_isbn, titulo, volume, nro_edicao, cod_encadernacao, cod_editora,
data_publicacao, cod_cidade_publi, reserva)
VALUES ('5565651016', 'Gabriela, Cravo e Canela', 1,1, 1, 8, '2012/05/17', 4, 'FALSE');

select * from livros;

/* table "locacoes" */

INSERT INTO locacoes (cod_socio, cod_livro, data_emprestimo, data_prevista,
data_devolucao, taxa) VALUES (1,2,'2020/01/15','2020/01/25','2020/01/25', 15);
INSERT INTO locacoes (cod_socio, cod_livro, data_emprestimo, data_prevista,
data_devolucao, taxa) VALUES (4,3,'2019/06/01','2019/06/10','2019/06/30', 50);
INSERT INTO locacoes (cod_socio, cod_livro, data_emprestimo, data_prevista,
data_devolucao, taxa) VALUES (1,4,'2021/01/15','2021/01/25','2021/01/25', 15);
INSERT INTO locacoes (cod_socio, cod_livro, data_emprestimo, data_prevista,
data_devolucao, taxa) VALUES (4,3,'2021/09/04','2021/09/15','2021/06/20', 30);
INSERT INTO locacoes (cod_socio, cod_livro, data_emprestimo, data_prevista,
data_devolucao, taxa) VALUES (7,8,'2021/10/01','2021/10/10','2021/10/10', 15);
INSERT INTO locacoes (cod_socio, cod_livro, data_emprestimo, data_prevista,
data_devolucao, taxa) VALUES (3,4,'2021/10/01','2021/10/10','2021/10/10', 20);
INSERT INTO locacoes (cod_socio, cod_livro, data_emprestimo, data_prevista,
data_devolucao, taxa) VALUES (3,5,'2015/12/03','2015/12/12','2015/12/13', 23);

select * from locacoes; 

/* table livros_autores */

INSERT INTO livros_autores (cod_livro,cod_autor) VALUES (1,1);
INSERT INTO livros_autores (cod_livro,cod_autor) VALUES (2,14);
INSERT INTO livros_autores (cod_livro,cod_autor) VALUES (3,14);
INSERT INTO livros_autores (cod_livro,cod_autor) VALUES (4,8);
INSERT INTO livros_autores (cod_livro,cod_autor) VALUES (5,10);
INSERT INTO livros_autores (cod_livro,cod_autor) VALUES (6,10);
INSERT INTO livros_autores (cod_livro,cod_autor) VALUES (6,15);
INSERT INTO livros_autores (cod_livro,cod_autor) VALUES (7,13);
INSERT INTO livros_autores (cod_livro,cod_autor) VALUES (8,13);
INSERT INTO livros_autores (cod_livro,cod_autor) VALUES (9,13);
INSERT INTO livros_autores (cod_livro,cod_autor) VALUES (10,13);

select * from livros_autores;

/*
-----------------------------------------------------------
                    /* OPERATORS */						   
														   
-----------------------------------------------------------
*/ 


/* SIMPLE OPERATORS: --------------------------------------
>, >=, <, <=, =, <> */

select * from livros;

/* volume = 1 */
select codigo, titulo, volume, nro_edicao, cod_editora
from livros
where volume = 1;

/* nro_edicao > 3 */
select codigo, titulo, volume, nro_edicao, cod_editora
from livros
where nro_edicao > 3;

/* cod_editora different from 8 */
select codigo, titulo, volume, nro_edicao, cod_editora
from livros
where cod_editora <> 8;

/* data_devolucao = data_prevista */
select * from locacoes
where data_prevista = data_devolucao;

/* locacoes taxa greater than 15 */
select * from locacoes
where taxa > 15;

-----------------------------------------------------------

/* MATHEMATICAL OPERATORS:
+ , - , /, *  */

select * from locacoes;

/* attributes, taxa, and fee + 10 */
select taxa, taxa + 10 from locacoes;

/* attributes taxa, fee divided by 2 */
select taxa, taxa/2 as locacoes_dividido2 from locacoes;

/* attributes taxa, taxa greater than 15 (boolean),
where taxa is greater than 10 + 5 */
select taxa, taxa > (10+5) as isboolean_ from locacoes
where taxa > (10+5);

/*
-----------------------------------------------------------
                    /* OTHER OPERATORS:					   
														   
                    - LIKE/ILIKE						   
                    - IN								   
                    - BETWEEN							   
                    - IS NULL */						   
-----------------------------------------------------------
*/

/* LIKE -----------------------------------------------------------
case sensitive */

/* no one in this query because there are no names that start with a lowercase letter */
select * from socios where nome like 'a%';

-- QUERY SUCCESSFULLY EXECUTED. BECAUSE THERE ARE PEOPLE WHO HAVE THE CAPITAL LETTER "A" AS THE FIRST LETTER OF THEIR NAME
select * from socios where nome like 'A%';

/* ILIKE -----------------------------------------------------------
NOT case sensitive = BETTER FOR SEARCHES */
select * from socios where nome ilike 'a%'
/* = */
select codigo, titulo from livros where titulo ilike 'a%';

/* doesn't return anything because there is no book title called 'flor' only */
select * from livros where titulo ilike 'flor';
/* returns the word 'flor', with any character before or after, represented by the %  */
select * from livros where titulo ilike '%flor%';

/* query for 'do' with space before and after  */
select  titulo from livros where titulo ilike '% do %';
/* query for any word that has the syllable 'da'  */
select  titulo from livros where titulo ilike '%da%';

/* starts with the letter 'a', followed by 1 character, followed by the letter 'f', followed by any character */
select * from livros where titulo ilike 'A_f%';

-----------------------------------------------------------
                    /* IN */
-----------------------------------------------------------

select codigo, titulo, nro_edicao, volume
from livros where nro_edicao in(1,3,5);

select * from socios;

/* query for the name 'paula' */
select * from socios where nome in ('Paula');
/* query for the names 'paula', 'pedro', 'catarina' */
select * from socios where nome in ('Paula','Pedro','Catarina');

-----------------------------------------------------------
/* BETWEEN */
-----------------------------------------------------------

/* numeric query */
select * from socios where codigo between 3 and 7;

/* date queries */
select titulo, volume, cod_editora, data_publicacao
from livros where data_publicacao 
between '2008/01/01' and '2012/12/31';

-----------------------------------------------------------
                    /* IS NULL */

/* insight: who has not yet returned the book and has not paid the fee?
the operator to use is 'is null', because if the book has not been returned and
the fee has not been paid, the fields will be empty, i.e., null */

/* queries will not return any value
because all fields/columns/attributes in the table are filled in
AND DEFINED IN THE DATABASE CONSTRUCTION AS "NOT NULL" */
select * from locacoes
where data_devolucao is null;

select * from locacoes
where taxa is null;


/*	
------------------------------------------------------------
															
			LOGICAL OPERATORS: 					
															
			- OR, IN, AND, NOT, BETWEEN			
															
------------------------------------------------------------
*/


--OR------------------------------------------------------------
select codigo, titulo, volume, nro_edicao from livros
 where codigo = 1 or codigo = 4;
 /* Query between COLUMNS */
SELECT codigo, titulo, volume, nro_edicao FROM livros
WHERE volume = 1 OR nro_edicao = 4;

--IN------------------------------------------------------------
/* code 1 or 4 = code IN  */ 
select codigo, titulo, volume, nro_edicao from livros
where codigo in (1,4);

--NOT------------------------------------------------------------
select codigo, titulo, volume, nro_edicao from livros
where not(codigo=1);
/* codigo NOT equal to 1 = codigo different from 1 */
select codigo, titulo, volume, nro_edicao from livros
where codigo <> 1;

select * from livros;


--BETWEEN, AND-----------------------------------------------------
/* codigo between 1 and 5 */
select codigo, titulo, volume, nro_edicao from livros
where codigo between 1 and 5;
/* codigo not between 1 and 5 */
select codigo, titulo, volume, nro_edicao from livros
where codigo not between 1 and 5;


--NOT------------------------------------------------------------
/* dates of return that are NOT null. 
In other words, they have filled values. */
select * from locacoes 
where data_devolucao is not null;






/*
------------------------------------------------------------
															
		OPERATOR PRECEDENCE					    
															
------------------------------------------------------------
*/


select * from livros;

/* query cod_editora 8 OR 4, and then AND codigo 9 */
select codigo, titulo, cod_editora from livros
where codigo = 9 and (cod_editora = 8 or cod_editora =  4);

/* query codigo 9 AND cod_editora 8, and then OR cod_editora 4 */
select codigo, titulo, cod_editora from livros
where (codigo = 9 and cod_editora = 8) or cod_editora = 4;




					/* MODULE 7 EXERCISES (OPERATORS) */


/*
1. Select the titulo, volume, and nro_edicao of all books that have
more than one edition*/
select titulo, volume, nro_edicao from livros
where nro_edicao > 1;

/* 2. Query the name of members, address, and the city code they live in,
where the address is an avenue (contains 'Av.' or 'Avenida' in the address). */
select  nome, endereco, cod_cidade from socios
where endereco ilike '%Av%' or endereco ilike '%Avenida%';

/* 3. Retrieve the name, last name, and phone number of all members with the last name "Souza". */
select nome, sobrenome, telefone from socios
where sobrenome in ('Souza');

/* 4. Query the codes of books that have been loaned and returned on the correct date,
and the charged fee was less than R$20.00 */
select cod_livro, taxa, data_prevista, data_devolucao from locacoes
where (data_prevista = data_devolucao) and taxa < 20;

/* 5. Retrieve the codes of members who have delayed returning the book. */
select cod_socio, data_prevista, data_devolucao from locacoes
where data_prevista < data_devolucao;


/* 6. Retrieve the names of all authors that contain "an" anywhere in the name. */
select nome from autores
where nome ilike '%an%';

/* 7. Query the name and phone number of all members with the name "Paula". */
select nome, telefone from socios
where nome in('Paula');

/* 8. Query the title, publication date, volume, and publisher code of all books
that were published before 01/01/2010 with only one volume,
but belong to either publisher number 7 or 8. */
select titulo, data_publicacao, volume, cod_editora from livros
where (data_publicacao < '01/01/2010' and volume= 1) and cod_editora in(7,8); 









/*
------------------------------------------------------------
															
				ALIAS:							
															
				- AS							
															
------------------------------------------------------------
*/


/*AS*/------------------------------------------------------------
select nome as nome_autor from autores;

select taxa, taxa + 10 as taxa_mais10 , taxa - 5 as taxa_menos5
from locacoes;

/*RENAMING TABLES: more readable query, as when joining tables,
the name can become very long.
If using an alias on a column, you should use the alias.
The topic will be covered in the JOINS module. */

select livros_autores.cod_livro from livros_autores;
/*  =  */
/* OPTIMIZED CODE */
select LA.cod_livro from livros_autores as LA;






/*
--------------------------------------------------------------------
																	
			DISTINCT: 										
																	
		Query without Duplicate Values					
														
																	
--------------------------------------------------------------------		
*/


--DISTINCT------------------------------------------------------------
/* brings distinct values, i.e., non-repeated */
SELECT DISTINCT COD_EDITORA FROM LIVROS;

/* distinct values of cod_editora for publication date before 01/01/2010 */
select distinct cod_editora from livros 
where data_publicacao > '01/01/2010';

/* distinct values of members who loaned a book */
select distinct cod_socio from locacoes;

/* distinct dates that had loans */
select distinct data_emprestimo from locacoes;


/*
------------------------------------------------------------
															
			ORDER BY:								
															
			-ASC, DESC								
															
------------------------------------------------------------					
*/


/*ASC*/-----------------------------------------------------------
select titulo, data_publicacao from livros
order by data_publicacao asc;

/*DESC*/-----------------------------------------------------------
select titulo, data_publicacao from livros
order by data_publicacao desc;

/* order by column 3, for example */
select * from locacoes order by 3;

select cod_socio, cod_livro, taxa from locacoes
order by 3;

/* order by cod_autor, and then order by cod_livro.
column cod_livro ordered from the cod_autor column */
select cod_autor, cod_livro from livros_autores
order by cod_autor, cod_livro;



/*
------------------------------------------------------------
															
			AGGREGATION FUNCTIONS:					
															
			- MAX, MIN, AVG, SUM					
															
------------------------------------------------------------					
*/					
					
/*Aggregates a set of values into a single result */
/*max, min, avg, sum, count*/

/*MAX*/-----------------------------------------------------------
select max(data_publicacao)from livros;

select max(data_publicacao) from livros
where cod_cidade_publi=4;

/*MIN*/-----------------------------------------------------------
select min(data_publicacao) from livros;

select min(taxa) from locacoes;

/*AVG*/-----------------------------------------------------------
select avg(taxa) from locacoes;

select avg(nro_edicao) from livros;

/*SUM*/-----------------------------------------------------------
select sum(taxa) from locacoes;

/*combining aggregation functions, alias, where (conditional, operator */
select sum(taxa) as soma, avg(taxa) as media, 
max(taxa) as taxa_Maxima, min(taxa) as taxa_Minima
from locacoes
where data_prevista = data_devolucao;



/*
------------------------------------------------------------
                    COUNTING RECORDS:                   	
                                                       		
                    - COUNT                               	
                    - COUNT + DISTINCT                    
                    - COUNT + FILTER                     	       
------------------------------------------------------------                   
*/

                    
/*COUNT-----------------------------------------------------------
*/

--counts total values in locacoes
select count(*) from locacoes;

--counts total taxa in locacoes
select count(taxa) from locacoes;

--counts total values in locacoes where data_devolucao is null
select count(*) from locacoes
where data_devolucao is null;


/*COUNT + DISTINCT-----------------------------------------------------------
*/

select titulo, cod_editora from livros;

--distinct cod_editora values in livros
select distinct cod_editora as distinct_code from livros;

--counts total distinct cod_editora values in livros
select count(distinct cod_editora ) as distinct_count from livros;

--distinct cod_socio values in locacoes
select distinct cod_socio from locacoes;

--counts total distinct cod_socio values in locacoes
select count(distinct cod_socio) from locacoes;


/*COUNT + FILTER-----------------------------------------------------------
*/

--counts total values in locacoes
select count(*) from locacoes;

-- Count of as all rental,  filtering null Count of open rentals and not null Count of finished rentals in locacoes
select count(*) as total_rentals,
count(*) filter(where data_devolucao is null) as Open, 
count(*) filter(where data_devolucao is not null) as Finished 
from locacoes;

-- Count of as total_publications, filtering count cod_cidade_publi =1 and filtering count cod_cidade_publi <>(not equal) 1 in livros
select count(*) as total_publications,
count(*) filter(where cod_cidade_publi =1) as city_1,
count(*) filter(where cod_cidade_publi <>1) as Other_cities
from livros;




/*
------------------------------------------------------------
                    GROUPING VALUES:                        
                                                        	
                    - GROUP BY                              
                    - ROLLUP                                
                    - HAVING                                                         
------------------------------------------------------------
*/

            
/*GROUP BY*/-----------------------------------------------------------
select count(* )from livros;

select distinct cod_editora from livros;

/*total books per publisher*/
select cod_editora, count(*) as total from livros
group by cod_editora
order by cod_editora;

/*number of books each author wrote*/
select cod_autor, count(*) from livros_autores
group by cod_autor
order by cod_autor;

/*highest fee, average fee paid by members*/
select cod_socio, max(taxa), avg(taxa) from locacoes
group by cod_socio;

/*highest fee, average fee paid by each member per book*/
select cod_socio,cod_livro, max(taxa), avg(taxa) from locacoes
group by cod_socio, cod_livro
order by cod_socio;


/*ROLLUP -----------------------------------------------------------
- creates subtotals between each grouping*/

/*sum of how much each member spent on each book
generates a totalizer for each member and a totalizer for the overall*/
select cod_socio, cod_livro, sum(taxa) from locacoes
group by rollup (cod_socio, cod_livro)
order by cod_socio, cod_livro;


/*HAVING -----------------------------------------------------------
- performs a filter on the grouping result*/


/*sum of how much each member spent 
on renting each book (being able to rent the book several times).
Display only rows where this sum is greater than 23*/
select cod_socio, cod_livro, sum(taxa) from locacoes
group by cod_socio, cod_livro
having sum(taxa) >=23
order by cod_socio;


/*
------------------------------------------------------------
                    LIMITING RECORDS:                   	
                                                       		
                    - LIMIT                               	
                    - OFFSET                            	
------------------------------------------------------------
*/


/*LIMIT*/-----------------------------------------------------------
--The LIMIT clause restricts the number of rows returned by a query to a specified maximum number.
select codigo, titulo, cod_editora from livros
order by titulo
limit 5;

/*OFFSET*/-----------------------------------------------------------
--The OFFSET clause specifies the starting point from which to begin retrieving rows. 
select codigo, titulo, cod_editora from livros
order by titulo
offset 5;

select codigo, titulo, cod_editora from livros
order by codigo
limit 3 offset 6;


/*
------------------------------------------------------------
                                                            
                        CASE WHEN							
															
-"CASE WHEN" statement is a powerful and flexible 		
conditional expression that allows you to perform 		
conditional logic within a SQL query. It is 			
typically used to return different values or 			
perform different actions based on specific conditions. 
                                                            
------------------------------------------------------------
*/


/*adding + one data for the exercise*/
update livros set reserva=true, cod_socio_reserva=2
where codigo=2;

select * from livros;

/*simple example*/
select titulo,
case
when reserva= 'f' then 'no'
else 'yes'
end as "has reservation?"
from livros;

/*case when what is the situation of the books in rentals*/
select cod_socio, cod_livro, data_emprestimo,
case
when data_prevista = data_devolucao then 'returned on time'
when data_prevista > data_devolucao then 'returned early'
when data_prevista < data_devolucao then 'returned late'
else 'in rental'
end as "Situation"
from locacoes;

select * from locacoes;

/*count how many were delivered/late/early*/
select count(*),
case
when data_prevista = data_devolucao then 'returned on time'
when data_prevista > data_devolucao then 'returned early'
when data_prevista < data_devolucao then 'returned late'
else 'in rental'
end as "Situation"
from locacoes
group by "Situation";


                    
                    
                    /*EXERCISES MODULE 7 - "IMPROVING THE SELECT"*/


/*1) Query the quantity of books each author wrote. Order by author code.*/
select  cod_autor, count(distinct cod_livro) as total_livros from livros_autores
group by cod_autor
order by cod_autor;

select * from livros_autores;

/*2) Show, in a single line, the total quantity of books, the total quantity of
reserved books, and the quantity of books without reservations.*/
select count(*) as total_livros,
count (*) filter(where reserva='true') as total_com_reserva,
count (*) filter(where reserva='false') as total_sem_reserva
from livros;

select * from livros;

/*3) Retrieve the codes of all cities where more than one member resides.*/
select cod_cidade
from socios
group by cod_cidade
having count(*) > 1
order by cod_cidade;

select * from socios;

/*4) Calculate the average fee each member paid in their rentals.*/
select cod_socio , avg(taxa) as media_taxa
from locacoes
group by cod_socio;

select * from locacoes;

/*5) Calculate the sum of all fees that each member spent on rentals. In case
any member has not spent any fee, show 0.00 (zero).*/
select cod_socio,
case
when sum(taxa) is null then 0.00
else sum(taxa)
end as soma
from locacoes
group by cod_socio;

select * from locacoes;

/*6) Query how many members live in each city. Show the city code and the
quantity of members living in it, ordered from highest to lowest number.*/
select cod_cidade, count( distinct codigo) as total_socios 
from socios
group by cod_cidade
order by cod_cidade desc;


select * from socios;

/*7) Query which cities have members living in them. Do not repeat values.*/
select cod_cidade , count( distinct codigo)
from socios
group by cod_cidade
order by cod_cidade;

SELECT DISTINCT cod_cidade FROM Socios;

select * from socios;

/*8) Create a ranking with the top 5 most rented books. Show the book code and
the quantity of rentals.*/
select cod_livro, count(*)
from locacoes
group by cod_livro
order by count(*) desc
limit 5;

select * from locacoes;


/*9) The library owner catalogs books by collection according to the date they
were published:
● Sebo Collection = published before 01/01/2000
● Normal Collection = published between 01/01/2000 and 12/31/2010
● Modern Collection = published after 12/31/2010
We want to query the title of the books and to which collection they belong.*/
select titulo,
case
when data_publicacao < '01/01/2000'  then 'Sebo Collection'
when data_publicacao >= '01/01/2000' and data_publicacao <= '31/12/2010'  then 'Normal Collection'
else 'Modern Collection'
end as "collection_type"
from livros
order by "collection_type";


/*10) Based on the query made in the previous exercise, show how many books
belong to each collection.*/
select  count(*) as total_livros,
case
when data_publicacao < '01/01/2000'  then 'Sebo Collection'
when data_publicacao >= '01/01/2000' and data_publicacao <= '12/31/2010'  then 'Normal Collection'
else 'Modern Collection'
end as "collection_type"
from livros
group by "collection_type"
order by count(*) desc;


SELECT
CASE
WHEN data_publicacao < '2000/01/01'
THEN 'Sebo Collection'
WHEN data_publicacao >= '2000/01/01' AND data_publicacao <= '2010/12/31'
THEN 'Normal Collection'
ELSE 'Modern Collection'
END "Collection Type",
COUNT(*) AS Total
FROM livros
GROUP BY "Collection Type" ;


select * from livros;


/*
------------------------------------------------------------
                    MAIN FUNCTIONS:                       	
                                                        	
                    - SUBSTRING                             
                    - LENGTH                                
                    - TRIM                                  
                    - REPLACE                               
------------------------------------------------------------
*/


/*SUBSTRING*/-----------------------------------------------------------
select substring (nome from 1 for 3) from autores;

select titulo, substring(titulo from 10 for 15) from livros;


/*LENGTH*/-----------------------------------------------------------
select nome, length(nome) from autores;

/*UPPER/LOWER*/
select nome, upper(nome), lower(sobrenome) from socios;

/*TRIM*/-----------------------------------------------------------
select trim('    SQL Course');
select ltrim('    SQL Course ');

/*REPLACE*/-----------------------------------------------------------
select replace (titulo,' ','_') from livros;



/*
------------------------------------------------------------
                    CONCATENATING STRINGS:                  
                                                        	
                    - CONCAT OR ||                          
------------------------------------------------------------
*/


/*CONCAT -----------------------------------------------------------
- joining 2 or more strings*/
select concat ('ana', 'maria');

select concat ('ana',' ','maria');

select concat ('Name: ',nome ,' ','Last Name: ',sobrenome) from socios;

/* ||*/
select 'Name: ' || nome || ' ' || 'Last Name: ' || sobrenome from socios;


/*
------------------------------------------------------------
                    NUMERIC FUNCTIONS:                      
                                                        	
                    - ABS                                   
                    - MOD                                   
                    - ROUND                                	
                    - TRUNC                                	
                    - RANDOM                               	
------------------------------------------------------------
*/  


/*ABS -----------------------------------------------------------
- absolute value*/
select taxa, taxa-100 as taxa_minus_100, abs(taxa-100) from locacoes;

/*MOD - returns the remainder of x divided by y, mod(x,y)*/
select mod(10,2);
select mod(11,2);
select mod(20,3);

/*ROUND -----------------------------------------------------------
- rounds numbers to the specified digits*/
select taxa, taxa/2 as taxa_divided_by_2, round(taxa/2) as rounded 
from locacoes;

/*TRUNC -----------------------------------------------------------
- cuts off the decimals of a number*/
select trunc(35.823, 2);
/* trunc without specifying decimal digits*/
select trunc(35.823);
/* difference between round and trunc*/
select cod_socio, sum(taxa), sum(taxa)/12 as monthly_average,
round(sum(taxa)/12, 2),
trunc (sum(taxa)/12, 2)
from locacoes
group by cod_socio;

/*RANDOM -----------------------------------------------------------
- returns a number >=0 and <1*/
select random();
/*random - brings any range of numbers*/
select random() * (1000 - 1)+ 1;
/*random - example of a random number for the book code, from 1 to 10*/
select titulo from livros;
where codigo = trunc(random() * (10 - 1) + 1);


/*
------------------------------------------------------------
                    DATE/TIME FUNCTIONS:                   
                                                        	
                    - NOW() AND CURRENT_DATE                
                    - EXTRACT AND DATE_PART                 
                    - AGE                                   
------------------------------------------------------------
*/


select date '2001-09-28' + interval '1h';


/*NOW() and CURRENT_DATE -----------------------------------------------------------
- returns current date*/
select now();

--current date yyyy/mm/dd
select current_date;

/*returns rental date and today's date minus rental date, in days*/
select data_emprestimo, now() - data_emprestimo from locacoes;

/*EXTRACT AND DATE_PART  -----------------------------------------------------------
- returns a part of the date or time*/
select extract(year from data_emprestimo) from locacoes;

/*returns rental date, and extracts the month from the rental date*/
select data_emprestimo, extract(month from data_emprestimo)  as month 
from locacoes;

/*returns the year of the rental date*/
select date_part('year' , data_emprestimo) from locacoes;

/* returns the week of the year we are in*/
select extract(week from now());

select data_emprestimo,
extract(day from data_emprestimo) as day,
extract(month from data_emprestimo) as month,
extract(year from data_emprestimo) as year
from locacoes;

/*AGE -----------------------------------------------------------
- returns the years, months, days, hours between dates*/
select age( date '18-04-1989');

/*difference in days between the rental date and the book's expected return date*/
select  data_prevista, data_emprestimo, age(data_prevista , data_emprestimo) as rented_days
from locacoes;

/* years, months, days since the first rental and the last rental*/
select age( max(data_emprestimo), min(data_emprestimo))
from locacoes;


/*
------------------------------------------------------------
                    HIDING SENSITIVE DATA:                  
                                                            
                    - MD5                                   
                    - CRYPT                                 
                    - GEN_SALT                              
                    - CRYPT + GEN_SALT                      
------------------------------------------------------------
*/


/*ADD NEW TABLE/ENTITY "USERS" + INSTALL "PGCRYPTO" EXTENSION*/
create table usuarios(
codigo serial primary key,
usuario varchar(150) not null,
senha varchar(60) not null
);

create extension pgcrypto;


/*MD5 -----------------------------------------------------------
- not widely used due to vulnerabilities
ALWAYS RETURNS THE SAME 30-CHARACTER HASH*/
select md5('ayê');

/*GEN_SALT -----------------------------------------------------------
- RETURNS DIFFERENT RANDOM HASHES.
REQUIRES SPECIFYING THE ALGORITHM (BLOWFISH - BF) AND THE "SALT" SIZE*/
select gen_salt('bf',8);


/*CRYPT + GEN_SALT ----------------------------------------------------
- RETURNS RANDOM 60-CHARACTER HASHES,
more secure than MD5.
RETURNS THE SAME 60-CHARACTER HASH WITH BLOWFISH (BF) ALGORITHM
AND SALT (8)*/
select crypt('123456', gen_salt('bf', 8));


/*INSERT ENCRYPTED VALUES --------------------------------------------
( CRYPT , GEN_SALT )   
INTO FIELDS/ATTRIBUTES*/
insert into usuarios(usuario, senha)
values('ana@gmail.com', crypt('123456', gen_salt('bf',8)));
insert into usuarios(usuario, senha)
values('joao@gmail.com', crypt('123457', gen_salt('bf',8)));
insert into usuarios(usuario, senha)
values('pedro@gmail.com', crypt('123456', gen_salt('bf',8)));
insert into usuarios(usuario, senha)
values('maria@gmail.com', crypt('m@r!a', gen_salt('bf',8)));

select * from usuarios;

/*DECRYPT PASSWORD / PASSWORD AUTHENTICATION-----------------------------
if it returns, the password is correct*/
select * from usuarios
where usuario = 'ana@gmail.com' and
senha = crypt('123456','$2a$08$ynlMeyfG/2RAu36gyrQJ7.IY/rjRWAQwbuLYeWOm7wS.CU02ypRfC' );




			/*EXERCÍCIOS - MÓDULO 8 PRINCIPAIS FUNÇÕES*/

/*1) Retrieve the book titles and how long ago they were published.*/
select titulo, data_publicacao, age(now(), data_publicacao) as anos_desde_publicacao
from livros
order by data_publicacao;

/*2) Retrieve the name and last name of the partners in a single column. Display how many characters the names contain.*/
select concat(nome,' ', sobrenome) as nome_junto,
length(concat(nome,sobrenome)) as cumprimento_nome
from socios;

/*3) Display the partner code, book code, and how many days after borrowing they were returned.*/
select cod_socio, cod_livro, data_devolucao - data_emprestimo as dias_locados
from locacoes;
--where (data_prevista <= data_devolucao); <<<<-----  you can also use this line,
--because there is a date error in the database,
--where the return date is earlier than the borrow date,
--it shows a negative number. 
--Using the WHERE clause, it will only retrieve the ones with correct dates.

/*4) Display the average fees paid by each partner for their loans. Round the average to show only 2 decimal places.*/
select cod_socio, count(*) as qtde_locacoes , round(avg(taxa),2) as valor_medio_locacoes
from locacoes
group by cod_socio;

/*5) Retrieve how many books were published each year, ordered from the year with the least to the most.*/
select  extract(year from data_publicacao) as ano, count(*) as total
from livros
group by ano
order by ano, total asc;

/*6) Display the number of books borrowed per year and per month. Order by year/month.*/
select  count(*) as total_livros_locados , 
extract(year from data_emprestimo) as ano, 
extract(month from data_emprestimo) as mes 
from locacoes
group by mes, ano
order by ano, mes;


/*
------------------------------------------------------------
                    JOINING TABLES:                         
                                                            
                    - INNER JOIN                            
                    - RIGHT AND LEFT JOIN                   
                    - FULL JOIN                             
                    - UNION                                 
------------------------------------------------------------
*/


/*INNER JOIN -----------------------------------------------------------

- RETURNS COMMON RECORDS BETWEEN 2 TABLES.
TO ADD MORE THAN 2 TABLES, 2 TABLES MUST BE JOINED FIRST AND
THEN JOIN THE THIRD TABLE, FOURTH TABLE, AND SO ON*/

--join member names with their respective city from the cities table
select  socios.nome as nome, cidades.cidade from socios
inner join cidades on 
socios.cod_cidade = cidades.codigo
order by nome;

--join tables with composite PK, author name from authors with book name from books
-- improved code of "select * from book_authors"
select livros.titulo as titulo , autores.nome  from livros_autores as LA
inner join livros on LA.cod_livro = livros.codigo
inner join autores on LA.cod_autor = autores.codigo
order by titulo;

--select publisher name, member name,
--who have their name in some reservation from the "book".
select livros.titulo , editoras.nome, socios.nome  from livros
inner join editoras on editoras.codigo = livros.cod_editora
inner join socios on socios.codigo = livros.cod_socio_reserva;

/*LEFT JOIN AND RIGHT JOIN - ---------------------------------------------------

LEFT JOIN IS THE MOST COMMONLY USED. CHOOSE LEFT JOIN INSTEAD OF RIGHT JOIN
INSTEAD OF USING RIGHT JOIN, SIMPLY REVERSE THE TABLE POSITIONS IN THE EXPRESSION*/

/*LEFT JOIN -----------------------------------------------------------

Left Join retrieves all records that are in the left table,
regardless of whether they have a relationship with the right table.*/

--Retrieve the name of all cities, whether or not they have members living in them.
select cidades.cidade, socios.nome from cidades
left join socios on
cidades.codigo = socios.cod_cidade;

--cities with no members living in them
select cidades.cidade, socios.nome from cidades
left join socios on
cidades.codigo = socios.cod_cidade
where socios.nome is null;

/*RIGHT JOIN -----------------------------------------------------------

Right Join retrieves all records that are in the right table,
regardless of whether they have a relationship with the left table.*/

--Retrieve the name of all cities, whether or not they have members living in them
--(SAME RESULT AS LEFT JOIN, FOR COMPARISON)
select cidades.cidade, socios.nome from socios
right join cidades on
cidades.codigo = socios.cod_cidade;

/*FULL JOIN -----------------------------------------------------------

retrieves all records that are in the left and right tables*/

--alter the members table. REMOVE the NOT NULL constraint on city_code
--and insert new data WITHOUT city_code
alter table socios
alter column cod_cidade
drop not null;

insert into socios(nome, sobrenome, endereco, cep, telefone)
values('Lisiane', 'Pedroni', 'Rua X' , '99887-987', '87765799');

select * from socios;

--Retrieve all members who have or do not have a city, and all cities that
--have or do not have members
select socios.nome, cidades.cidade from socios
full join cidades on
cidades.codigo = socios.cod_cidade;

--Retrieve all members who do not have a city, OR all cities that do not
--have members.
select socios.nome, cidades.cidade from socios
full join cidades on
cidades.codigo = socios.cod_cidade
where socios.nome is null or cidades.cidade is null;

/*UNION - combines the result of two or more queries into a single result, returning
all rows belonging to the result of all involved queries.
WITHOUT USING PK AND FK*/

--Select all people from all tables (this way, it will bring WITHOUT
--repetitions, if you want repeated names, replace UNION with UNION ALL):
select nome from socios
union
select nome from autores
union
select usuario from usuarios 
order by nome asc;

/* JOIN WITHOUT JOIN - USES WHERE.----------------------------------------------------------
BUT IT IS CONFUSING TO DISTINGUISH WHAT IS A RELATIONSHIP AND WHAT IS A FILTER.*/

-- Retrieve the titles of books and the names of their authors, but only where the author's code is 13:
select livros.titulo , autores.nome 
from livros_autores, livros, autores
where livros_autores.cod_livro = livros.codigo
and
livros_autores.cod_autor = autores.codigo
and
autores.codigo = 13;

--SAME RESULT, but much cleaner code than using WHERE.
select livros.titulo, autores.nome from livros_autores
inner join livros on livros_autores.cod_livro = livros.codigo
inner join autores on livros_autores.cod_autor = autores.codigo
where autores.codigo = 13;


                    /*Module 9 - Exercises - JOIN*/


--1. Retrieve the titles of books and the name of the city where they were published.
select livros.titulo, cidades.cidade from livros
inner join cidades on 
livros.cod_cidade_publi = cidades.codigo;

--2. Retrieve the name of the authors and how many books each of them wrote.
select autores.nome , count(*) from livros_autores
inner join autores on autores.codigo = livros_autores.cod_autor
group by autores.nome;

--3. Create a ranking with the Top 5 most borrowed books, showing the book title and the number of times it was borrowed.
select livros.titulo , count(*) as total from locacoes
inner join livros on
livros.codigo = locacoes.cod_livro
group by livros.titulo
order by total desc
limit 5;

--4. Retrieve the name of the book and the name of the partner from all loans that were returned on the correct date.
select livros.titulo , socios.nome 
from locacoes
inner join socios on socios.codigo =locacoes.cod_socio
inner join livros on livros.codigo = locacoes.cod_livro
where  locacoes.data_devolucao <= locacoes.data_prevista;

--5. Retrieve the name of all partners who returned their books late.
select socios.nome 
from locacoes
inner join socios on socios.codigo =locacoes.cod_socio
where  locacoes.data_devolucao > locacoes.data_prevista;

--6. Retrieve the name of all cities that do not have books published in them.
select cidades.cidade from cidades
left join livros on livros.cod_cidade_publi = cidades.codigo
where livros.cod_cidade_publi is null;

--7. Query the name of all authors who do not have any books in the library.
select autores.nome from autores
left join livros_autores on autores.codigo = livros_autores.cod_autor
where cod_livro is null;

select * from autores;
select * from livros_autores;
select * from livros;

--8. Query the name of all partners who have reserved books.
select socios.nome from socios
inner join livros  on socios.codigo = livros.cod_socio_reserva
where reserva is true;

select * from livros;
select * from socios;


/*
------------------------------------------------------------
                    SUBQUERIES:                             
                                                            
                    - SUBQUERY AS FILTER                    
                    - SUBQUERY AS COLUMN                    
                    - SUBQUERY AS TABLE                     
                    - EXISTS / NOT EXISTS                   
                    - SUBQUERY IN AN UPDATE                 
                                                            
------------------------------------------------------------
*/


--SUBQUERY AS FILTER---------------------------------------

-- MUST USE AN OPERATOR

-- BOOKS WITH THE LATEST PUBLICATION DATE
select titulo, data_publicacao
from livros
where data_publicacao = (select max(data_publicacao) from livros);

-- NAMES OF PUBLISHERS THAT HAVE BOOKS
select nome from editoras
where codigo in (select distinct cod_editora from livros);


--SUBQUERY AS COLUMN---------------------------------------

-- USE PRIMARY AND FOREIGN KEYS

-- BOOK TITLE AND NUMBER OF LOANS
select titulo, 
(
select count(*) as total from locacoes
where locacoes.cod_livro = livros.codigo
) 
as nro_locacoes
from livros;


--SUBQUERY AS TABLE----------------------------------------

-- AVERAGE OF THE HIGHEST FEES PAID FOR LOANS

-- 1st find the max fee for each BOOK
SELECT cod_livro, MAX(taxa) FROM locacoes
GROUP BY cod_livro; 
-- SUBQUERY: average of the max fees paid for loans
SELECT AVG(maior_taxa) 
FROM (
SELECT cod_livro, MAX(taxa) as maior_taxa 
FROM locacoes
GROUP BY cod_livro
) as tab;

-- EXISTS / NOT EXISTS ------------------------------------

-- USE PRIMARY AND FOREIGN KEYS

-- TITLES OF BOOKS THAT HAVE BEEN LOANED
SELECT titulo FROM livros
WHERE EXISTS
(SELECT cod_livro FROM locacoes
WHERE locacoes.cod_livro = livros.codigo);
-- SAME RESULT, BUT USING INNER JOIN
SELECT DISTINCT titulo FROM livros
INNER JOIN locacoes ON locacoes.cod_livro = livros.codigo;

-- TITLES OF BOOKS WRITTEN BY MORE THAN 1 AUTHOR
SELECT titulo 
FROM livros
WHERE EXISTS
(SELECT cod_livro, count(*) FROM livros_autores
WHERE livros_autores.cod_livro = livros.codigo
GROUP BY cod_livro
HAVING count(*) > 1);

SELECT * FROM livros_autores;

-- SUBQUERY IN AN UPDATE ----------------------------------

-- CHANGE THE VOLUME TO 3 FOR BOOKS WITH THE LATEST PUBLICATION DATE
UPDATE livros SET volume = 3
WHERE data_publicacao =
(SELECT max(data_publicacao) FROM livros);

-- Query to validate the update data
SELECT volume FROM livros
WHERE data_publicacao = '2021-11-09';


/*
------------------------------------------------------------------------
																		
				CREATING TABLE COPIES FROM A QUERY																								|
				- SELECT INTO						
				- CREATE TABLE										
																		
------------------------------------------------------------------------
*/


--SELECT INTO ----------------------------------------------------------------------------------------------------------------

--COPY (BACKUP) OF TABLE "SOCIOS" AS "SOCIOS_BKP"
select * into socios_bkp from socios;

drop table socios_bkp;

--COPY (BACKUP) OF TABLE "SOCIOS" AS "SOCIOS_BKP", 
--BUT ONLY FIELDS NAME, SURNAME, AND ZIP CODE.
--NAME AND SURNAME CONCATENATED as "nome_completo"
select nome || ' ' || sobrenome as nome_completo, cep into socios_bkp
from socios;
 
select * from socios_bkp;
drop table socios_bkp;

--COPY (BACKUP) OF TABLE "SOCIOS" AS "SOCIOS_BKP", 
--BUT ONLY FOR MEMBERS WHOSE NAME STARTS WITH THE LETTER "c"
select * into socios_bkp
from socios
where nome ilike 'c%';


--CREATE TABLE----------------------------------------------------------------------------------------------------------------
create table socios_bkp as
select nome || ' ' || sobrenome as nome_completo, cep
from socios;






/*
----------------------------------------------------------------
																
		ATTRIBUTES OF THE UNIQUE TYPE:					
																
		- CREATE TABLE 									
		- ALTER TABLE									
		- USED IN TABLE / DB CREATION					
		- IT'S A UNIQUE VALUE, NOT REPEATED BY ROW		
		- IT'S A CONSTRAINT INFORMED FOR THE COLUMN		
																
----------------------------------------------------------------
*/


--CREATE TABLE WITH UNIQUE-----------------------------------------------------------------------------------------------------

-- CREATE "PESSOAS" TABLE WITH UNIQUE VALUE
create table pessoas (
codigo serial primary key,
nome varchar(100),
cpf varchar(15) unique not null
);


--ALTER TABLE WITH UNIQUE------------------------------------------------------------------------------------------------------
--ADD NEW CONSTRAINT 
alter table pessoas
add constraint cpf_un unique(cpf);







/*
----------------------------------------------------------------
																
		TRANSACTIONS: 									
																
		SET OF 1 OR MORE OPERATIONS 					
		THAT MAKE UP A SINGLE TASK TO BE EXECUTED.		
																
		ALWAYS USE COMMIT or ROLLBACK before			
		using UPDATE OR DELETE							
		AS A BEST PRACTICE								
																
		- COMMIT 										
		- ROLLBACK										
																
																
----------------------------------------------------------------
*/

--The COMMIT statement is used to permanently save the changes made during the current transaction. 
--The ROLLBACK statement is used to undo or discard the changes made during the current transaction.

--UPDATE ON MEMBER'S ADDRESS.------------------------------------------------------------------------------------------------

--1st: "BEGIN" OR "START TRANSACTION" EXPRESSION
--2nd: UPDATE OR DELETE EXPRESSION
--3rd: COMMIT OR ROLLBACK, DEPENDING ON THE ACTION TO BE PERFORMED

begin; -- or "START TRANSACTION"

update socios set endereco ='Rua Bezerra de Menezes, 970'
where codigo = 1;

commit;



/*
--------------------------------------------------------------------------------
																				
		VIEWS: 															
																				
		IT IS THE RESULT OF A PREDEFINED QUERY. 						
		WE CAN THINK OF A VIEW AS A VIRTUAL TABLE,						
		SINCE IT REPRESENTS A DATA VIEW AND DOES NOT CONTAIN			
		DATA PHYSICALLY WITHIN IT, MEANING THE DATA IS NOT				
		PHYSICALLY STORED IN THE DATABASE.								
																				
																				
		- CREATE OR REPLACE VIEW										
		- CREATE OR REPLACE TEMPORARY VIEW								
		- CREATE MATERIALIZED VIEW / REFRESH MATERIALIZED VIEW			
		- DROP VIEW														
																				
--------------------------------------------------------------------------------
*/

--VIEWS: It provides a dynamic, up-to-date representation of data from one or more underlying tables or other views.

--CREATE OR REPLACE VIEW------------------------------------------------------------------------------------------------------

--Creation of the "vw_emprestimos" view.
-- The view does NOT store data.
-- It's only a virtual table of the data query contained in the physical table.
-- "Replace" UPDATES the VIEW if new data has been inserted into the physical tables.
-- with a join of 3 tables (Socios, Livros, and Locacoes).
-- Stores the query inside the view.
create or replace view vw_emprestimos as
select cod_socio, concat(socios.nome, ' ', socios.sobrenome) as nome,
cod_livro, livros.titulo, data_emprestimo, data_prevista, data_devolucao 
from locacoes
inner join socios on socios.codigo = locacoes.cod_socio
inner join livros on livros.codigo = locacoes.cod_livro;

--UPDATE OF THE "SOBRENOME" FIELD IN THE "SOCIOS" TABLE
update socios
set sobrenome ='Sousa'
where codigo = 3;

--QUERY the "vw_emprestimos" VIEW to check if the "sobrenome" field has been updated.
select * from vw_emprestimos;



--CREATE OR REPLACE TEMPORARY VIEW:-------------------------------------------------------------------------------------------

--Temporary view exists only until the current session is closed.
--It is NOT saved as a virtual table after the current session ends.
create or replace temporary view vw_emprestimos as
select cod_socio, concat(socios.nome, ' ', socios.sobrenome) as nome,
cod_livro, livros.titulo, data_emprestimo, data_prevista, data_devolucao 
from locacoes
inner join socios on socios.codigo = locacoes.cod_socio
inner join livros on livros.codigo = locacoes.cod_livro;



--CREATE MATERIALIZED VIEW:-----------------------------------------------------------------

--Materialized view is physically stored in the database.
--Better performance in routine queries, as the queries are made
--on the materialized view instead of searching through the entire database.
--Stores the data of the table and the view's query.
create materialized view mvw_emprestimos as
select cod_socio, concat(socios.nome, ' ', socios.sobrenome) as nome,
cod_livro, livros.titulo, data_emprestimo, data_prevista, data_devolucao 
from locacoes
inner join socios on socios.codigo = locacoes.cod_socio
inner join livros on livros.codigo = locacoes.cod_livro;

--REFRESH MATERIALIZED VIEW
--"Refresh" UPDATES the materialized view if new data has been inserted into the physical tables.
refresh materialized view mvw_emprestimos as
select cod_socio, concat(socios.nome, ' ', socios.sobrenome) as nome,
cod_livro, livros.titulo, data_emprestimo, data_prevista, data_devolucao 
from locacoes
inner join socios on socios.codigo = locacoes.cod_socio
inner join livros on livros.codigo = locacoes.cod_livro;



--DROP VIEW---------------------------------------------------------------------------------

--DELETE A VIEW
drop view vw_emprestimos;




/*
------------------------------------------------------------------------------------
																					
		PROCEDURES: 														
																					
		A BLOCK OF SQL COMMANDS OR INSTRUCTIONS, ORGANIZED TO EXECUTE		
		ONE OR MORE TASKS. JUST LIKE A PROGRAMMING LANGUAGE,				
		WE CREATE A PROCEDURE TO PERFORM A MORE COMPLEX OR REPETITIVE TASK.	
																	
		- CREATE OR REPLACE PROCEDURE										
		- CALL																
		- DECLARE + RAISE NOTICE											
		- DELETE PROCEDURE (DROP)											
																					
------------------------------------------------------------------------------------
*/

 

--UPDATE A RECORD IN THE "LOCACOES" TABLE (COD_SOCIO=3 AND COD_LIVRO=5) 
-- TO SET FIELDS DATA_DEVOLUCAO = NULL, TAXA = NULL.
-- FOR EXERCISE PURPOSES ONLY.
update locacoes
set data_devolucao = null,  taxa = null
where cod_socio = 3 and cod_livro = 5;


--CREATE OR REPLACE PROCEDURE: -----------------------------------------------------------------------------------------------

-- CREATE PROCEDURES TO PERFORM A BOOK RETURN
-- TO LOCATE THE LOAN OF THE BOOK, WE NEED TO PROVIDE THE MEMBER, BOOK,
-- AND LOAN DATE (THROUGH THE PK)
create or replace procedure p_devolve_livro
(socio int, livro int, emp date, dev date, tx numeric(10,2))
language plpgsql
as $$
begin

	update locacoes set data_devolucao = dev , taxa = tx
	where cod_socio = socio and cod_livro = livro 
	and data_emprestimo = emp;

end;
$$;


--CALL: ----------------------------------------------------------------------------------------------------------------------

-- UPDATE THE TABLE WITH NEW DATA USING THE "CALL" COMMAND.
call p_devolve_livro(3, 5, '2015-12-03', '2015-12-13', 24.00);

-- CHECK UPDATED DATA (DATA_DEVOLUCAO AND TAXA)
select * from locacoes;


--DECLARE(VARIABLES) + RAISE NOTICE (PREDEFINED MESSAGE) --------------------------------------------------------------------

-- RETURN ONLY BOOKS THAT HAVE NOT BEEN RETURNED YET
-- AVOID INCORRECT DATA INSERTION
create or replace procedure p_devolve_livro
(socio int, livro int, emp date, dev date, tx numeric(10,2))
language plpgsql
as $$

	DECLARE dt_dev date; -- CREATION OF THE "DT_DEV" VARIABLE

begin

	select data_devolucao into dt_dev from locacoes
	where cod_socio = socio and cod_livro = livro and data_emprestimo = emp 
	and data_devolucao IS NULL; -- THE EXPRESSION IS EXECUTED IF "DATA_DEVOLUCAO" IS NULL
	-- AVOIDS INSERTING DATA INCORRECTLY/REPEATEDLY (E.G., BOOK RETURNED TWICE)
	
	-- WILL ONLY PERFORM THE BOOK RETURN IF THE BOOK HAS NOT YET BEEN RETURNED
	-- AND IF THE RETURN DATE IS GREATER THAN THE LOAN DATE
	
	
	IF (found) and (emp < dev) -- AVOID INSERTING INCORRECT DATA (E.G., LOAN DATE GREATER THAN BOOK RETURN DATE)
	THEN RAISE NOTICE 'ENTERED THE IF'; -- OUTPUT PREDEFINED MESSAGE IF THE "IF" IS EXECUTED

	update locacoes set data_devolucao = dev , taxa = tx
	where cod_socio = socio and cod_livro = livro 
	and data_emprestimo = emp;

	end IF;
end;
$$;



--DELETE PROCEDURE: ----------------------------------------------------------------------------------------------------------
drop procedure p_devolve_livro;




/*
----------------------------------------------------------------------------
																			
		FUNCTIONS: 													
																			
		RETURNS A VALUE, BOOLEAN, RECORD... BY DEFAULT.															
		SIMILAR TO PROCEDURES, BUT FUNCTIONS RETURN SOMETHING		
		LIKE A VALUE, BOOLEAN, TEXT RECORD, ETC...					
													
		- CREATE OR REPLACE FUNCTION									
		- SELECT "FUNCTION"											
														
----------------------------------------------------------------------------
*/

/*
SYNTAX

CREATE [ OR REPLACE ] FUNCTION function_name (<parameters>)
RETURNS <type>
AS $$
[DECLARE <variables>]
BEGIN
<SQL commands>
<tests, loops>
RETURN <value>
END;
$$
LANGUAGE plpgsql;
*/


--CREATE OR REPLACE FUNCTION -------------------------------------------------------------------------------------------------
--EXAMPLE 1--

-- CREATE A FUNCTION TO PERFORM USER PASSWORD VALIDATION IN THE "USERS" TABLE
CREATE OR REPLACE FUNCTION f_authenticate(usr varchar, pwd varchar)
RETURNS boolean
AS $$
DECLARE
    pwd_database varchar;
BEGIN
    -- Attempt to retrieve the hashed password for the given username
    SELECT senha INTO pwd_database FROM usuarios WHERE usuario = usr;
    
    -- If the username doesn't exist, return false (authentication failed)
    IF NOT FOUND THEN
        RETURN false;
    END IF;

    -- Verify the provided password against the stored hashed password
    IF CRYPT(pwd, pwd_database) = pwd_database THEN
        RETURN true;  -- Password matches, authentication successful
    ELSE
        RETURN false; -- Password doesn't match, authentication failed
    END IF;
END;
$$ LANGUAGE PLPGSQL;



--SELECT "FUNCTION": --------------------------------------------------------------------------------------------------------
--CALL THE FUNCTION TO VALIDATE THE USER'S PASSWORD
select f_authenticate('ana@gmail.com', '123'); --FALSE (CORRECT EMAIL, WRONG PASSWORD)

select f_authenticate('ana@gmail.com', '123456'); --TRUE (CORRECT EMAIL, CORRECT PASSWORD)




--CREATE OR REPLACE FUNCTION ------------------------------------------------------------------------------------------------
--EXAMPLE 2--

-- 2 STEPS --

--CREATE A FUNCTION TO CALCULATE RANDOM NUMBERS AND 
--USE THEM TO DISPLAY RANDOM BOOK TITLES THAT EXIST IN THE DATABASE

--STEP 1/2: CREATE FUNCTION TO CALCULATE RANDOM NUMBERS
-- Create a function to calculate a random number between start and end (inclusive)
CREATE OR REPLACE FUNCTION generate_random(start int, end int)
RETURNS int AS $$
DECLARE
    random_value int;
BEGIN
    SELECT TRUNC(random() * (end - start + 1) + start) INTO random_value;
    RETURN random_value;
END;
$$ LANGUAGE PLPGSQL;

--CALL THE "GENERATE_RANDOM" FUNCTION 
--TO TEST THE CREATION OF RANDOM NUMBERS USING THE "GENERATE_RANDOM" FUNCTION
select generate_random(20, 300);


--STEP 2/2: USE THE "GENERATE_RANDOM" FUNCTION TO DISPLAY RANDOM BOOK TITLES
-- Create a function to select a random book title from the "livros" table
CREATE OR REPLACE FUNCTION f_search_book()
RETURNS varchar AS $$
DECLARE
    max_value int;
    min_value int;
    random_code int;
    book_titles varchar;
BEGIN
    -- Calculate the maximum and minimum values of book codes in the "livros" table
    SELECT max(codigo) INTO max_value FROM livros;
    SELECT min(codigo) INTO min_value FROM livros;

    -- Loop to find a random book title
    LOOP
        random_code = generate_random(min_value, max_value); -- Generate a random book code
        SELECT titulo INTO book_titles FROM livros WHERE codigo = random_code; -- Get the title for the random code

        -- If a title is found, exit the loop
        IF book_titles IS NOT NULL THEN
            EXIT;
        END IF;
    END LOOP;

    -- Return the randomly selected book title
    RETURN book_titles;
END;
$$ LANGUAGE PLPGSQL;

-- Test the "f_search_book" function to retrieve a random book title
SELECT f_search_book();



/*
----------------------------------------------------------------------------------------
																						
		TRIGGERS: 																
																						
		EVENT-DRIVEN ACTIONS TRIGGERED BY ACTIONS PERFORMED ON OUR TABLES.		
		(INSERT, UPDATE, DELETE)												
		TRIGGERS ARE CREATED FOR A SINGLE TABLE, NEVER FOR THE ENTIRE DATABASE;	
		EACH TABLE HAS ITS OWN TRIGGER.											
		IF A TABLE HAS MULTIPLE TRIGGERS, THEY ARE EXECUTED IN 					
		ALPHABETICAL ORDER.														
																	
		- CREATE TRIGGER														
		- BEFORE|AFTER															
		- INSERT|DELETE|TRUNCATE|UPDATE											
		- WHEN																	
		- FOR EACH ROW|STATEMENT												
		- EXECUTE FUNCTION|PROCEDURE											
		- "FUNCTION_NAME"														
																						
----------------------------------------------------------------------------------------
*/

/*
SYNTAX

CREATE TRIGGER <name>
BEFORE|AFTER
INSERT|DELETE|TRUNCATE|UPDATE [OF column_name]
ON <table|view> [WHEN <condition>]
FOR EACH ROW|STATEMENT
EXECUTE FUNCTION|PROCEDURE
<function_name>;
*/


					
					
					
					--EXERCISE 1: 
					--TRIGGERS AND FUNCTIONS--
					
					
					

/*As an example of a trigger in our library database, let's implement
an audit control for the "locacoes" table, which can be replicated
later for other tables as well.
To do this, we will store:
● Who made the change
● What change was made (update, insert, delete)
● The date and time of the change
● Altered content*/

--First, we need to create the table that will store the audit logs:
create table auditoria(
codigo serial primary key,
usuario varchar(100),
data_hora timestamp,
operacao char(1),
tabela varchar(100),
conteudo text);

/* The next step is to implement the function that will be called by the trigger. This
function will be responsible for inserting the data (logs) related to the operations
performed on the "locacoes" table. */
CREATE OR REPLACE FUNCTION f_auditoria_loc() RETURNS TRIGGER
AS $$
DECLARE
    op char;
    valores text;
BEGIN
    op := SUBSTRING(TG_OP, 1, 1);

    IF TG_OP = 'INSERT' THEN
        valores := 'cod_socio: ' || new.cod_socio || E'\n' ||
                   'cod_livro: ' || new.cod_livro || E'\n' ||
                   'data_emprestimo: ' || new.data_emprestimo || E'\n' ||
                   'data_prevista: ' || new.data_prevista || E'\n' ||
                   'data_devolucao: ' || new.data_devolucao || E'\n' ||
                   'taxa: ' || new.taxa;
    ELSIF TG_OP = 'UPDATE' THEN
        valores := 'cod_socio: ' || new.cod_socio || E'\n' ||
                   'cod_livro: ' || new.cod_livro || E'\n' ||
                   'data_emprestimo: ' || new.data_emprestimo || E'\n' ||
                   'data_prevista: [OLD]: ' || old.data_prevista || E'\n' ||
                   '              [NEW]: ' || new.data_prevista || E'\n' ||
                   'data_devolucao: [OLD]: ' || old.data_devolucao || E'\n' ||
                   '              [NEW]: ' || new.data_devolucao || E'\n' ||
                   'taxa: [OLD]: ' || old.taxa || E'\n' ||
                   '      [NEW]: ' || new.taxa;
    ELSE
        valores := 'cod_socio: ' || old.cod_socio || E'\n' ||
                   'cod_livro: ' || old.cod_livro || E'\n' ||
                   'data_emprestimo: ' || old.data_emprestimo || E'\n' ||
                   'data_prevista: ' || old.data_prevista || E'\n' ||
                   'data_devolucao: ' || old.data_devolucao || E'\n' ||
                   'taxa: ' || old.taxa;
    END IF;

    INSERT INTO auditoria (usuario, data_hora, operacao, tabela, conteudo)
    VALUES (current_user, now(), op, TG_TABLE_NAME, string_to_array(valores, E'\n'));

    RETURN NULL;
EXCEPTION
    WHEN others THEN
        -- Handle exceptions here if needed
        RETURN NULL;
END;
$$ LANGUAGE PLPGSQL;



--And now, we finally create the trigger:
CREATE TRIGGER  tg_auditoria
AFTER
INSERT OR DELETE OR UPDATE
ON LOCACOES
FOR EACH ROW
EXECUTE FUNCTION f_auditoria_loc();


--TEST THE TRIGGER
--UPDATE THE "LOCACOES" TABLE
select * from locacoes;

UPDATE locacoes set data_devolucao = NULL , taxa = NULL
where cod_socio = 3 and cod_livro = 5;

UPDATE locacoes set data_devolucao = '2015-12-21' , taxa = 42
where cod_socio = 3 and cod_livro = 5;

--CHECK THE "AUDITORIA" TABLE AND SEE IF NEW VALUES WERE INSERTED (AUDIT SYSTEM)
SELECT * FROM AUDITORIA;





/*
------------------------------------------------------------------------------------------------
                                                                                				
        CTE: COMMON TABLE EXPRESSIONS                                  					                              
                                                                                				
        - AN ALTERNATIVE WAY TO WRITE QUERIES, MAKING THEM SIMPLER AND MORE READABLE. 	
        - CAN REPLACE SUBQUERIES, VIEWS, AND FUNCTIONS.                   				
        - ALLOWS YOU TO DIVIDE QUERIES INTO SIMPLE AND SEPARATE BLOCKS.   				
                                                                                				
------------------------------------------------------------------------------------------------
*/

--CTE: CTEs are particularly useful for improving the readability and maintainability of complex SQL queries by breaking them down into smaller, more manageable parts.

-- EXERCISE: 
-- FIND THE TITLES OF BOOKS WITH THE LATEST PUBLICATION DATE BY PUBLISHER

-- IN THE FORM OF A SUBQUERY (EXAMPLE)
select titulo, data_publicacao, cod_editora from livros
where data_publicacao in (select max(data_publicacao)  from livros
group by cod_editora);

-- IN THE FORM OF A CTE (SAME RESULT AS THE SUBQUERY ABOVE, BUT MORE LEGIBLE)

WITH data_maxima as (select max(data_publicacao) as maxima from livros
group by cod_editora)
select titulo, data_publicacao, cod_editora from livros
where data_publicacao in(select maxima from data_maxima);

-- EXTENDING THE CTE, CREATING ANOTHER CTE
WITH data_maxima as (select max(data_publicacao) as maxima from livros
group by cod_editora),
busca_livros as (select titulo, data_publicacao, cod_editora from livros
where data_publicacao in(select maxima from data_maxima))
select * from busca_livros
order by data_publicacao desc;

--------------------------------------------------------------------------------------------------------------

/*
------------------------------------------------------------------------------------------------
                                                                                				
                CURSORS:                                                        				                               
                                                                                			
                - CREATED AND INSERTED WITHIN A FUNCTION                        				
                - REPRESENTS A TEMPORARILY STORED TABLE IN MEMORY               				                               
                - RESOURCE-INTENSIVE OPERATION FOR THE DATABASE, AS IT CAN USE A LOT OF MEMORY 	
                DEPENDING ON THE OPERATION TO BE PERFORMED.                     				
                                                                                				
                - FOR: LOOP TO IMPLEMENT THE CURSOR AUTOMATICALLY               				
                - FETCH: USED TO NAVIGATE THE CURSOR, WHEN USING THE DIRECTION   				
                                                                                				
------------------------------------------------------------------------------------------------
*/

--CURSORS: Database object that allows you to retrieve and manipulate rows from a result set one at a time. 

-- DECLARING CURSORS
nome_cursor [ [NO] SCROLL] CURSOR [(param)] FOR query;

-- EXAMPLES OF DECLARATION
DECLARE
cursor1 CURSOR (valor INT) FOR
SELECT * FROM livros WHERE codigo > valor;
cursor2 CURSOR FOR SELECT * FROM livros;
cursor3 refcursor;


-- FETCH: FETCH[DIRECTIONS] <NOME_CURSOR> INTO VARIABLE
-- DIRECTIONS:
-- NEXT/FORWARD (DEFAULT)
-- PRIOR/BACKWARD
-- FIRST
-- LAST
-- ABSOLUTE
-- RELATIVE


-- CREATE FUNCTION WITH INSERTED CURSOR
create or replace function busca_livros(cur_livros refcursor)
returns refcursor
as $$
begin
    OPEN cur_livros FOR
    select * from livros order by codigo;
    return cur_livros;
end;
$$ language plpgsql;

-- USE CURSOR OUTSIDE THE FUNCTION. IT MUST BE WITHIN A TRANSACTION.
begin;
    
    select busca_livros('meus_livros');
    fetch  meus_livros;
    
    select busca_livros('meus_livros');
    fetch first meus_livros;
    
    select busca_livros('meus_livros');
    fetch last meus_livros;
    
    select busca_livros('meus_livros');
    fetch 4 meus_livros;
    
    select busca_livros('meus_livros');
    fetch absolute 3 meus_livros;
    
    select busca_livros('meus_livros');
    fetch relative 6 meus_livros;

-- IF YOU NO LONGER WANT TO USE THE CURSOR, USING THESE COMMANDS WILL REMOVE IT FROM MEMORY.
rollback;
commit;

---------------------------------------------------------------------------------------------


/*
--------------------------------------------------------------------------------------------------------
            INDEX:                                                            							
                                                                                						
            - USEFUL FOR IMPROVING DATABASE PERFORMANCE                        							
            - IMPROVES QUERY EXECUTION TIME                                     						
            - TYPES OF INDEX: B-TREE (DEFAULT), HASH, GIN, GIST                 						
            - FUNCTIONS LIKE AN INDEX IN A BOOK, MAKING IT EASIER TO LOCATE A SPECIFIC PART OF A COLUMN 
                                                                                						
            - INDEXES SHOULD BE CREATED ON COLUMNS THAT ARE FREQUENTLY ACCESSED 						
                                                                                						
                                                                                						
--------------------------------------------------------------------------------------------------------
*/


-- SYNTAX
CREATE [UNIQUE] INDEX <INDEX_NAME> ON <TABLE>(<COLUMN>);

-- EXAMPLE:
create index livros_cod_editora_idx on livros(cod_editora);

-----------------------------------------------------------------------------------------------------------



/*
--------------------------------------------------------------------------------
        PERMISSIONS AND USERS:                                                 	
                                                                                
        - WHEN CREATING A USER, PERMISSIONS CAN BE GRANTED IN DIFFERENT        	
        DATABASES AND TABLES.                                                  	
        - ENSURING DATA SECURITY AGAINST SQL INJECTION.                         
        - NEVER GRANT 'SUPERUSER' ACCESS TO OTHER USERS.                        
                                                                                
                                                                                
                                                                                
--------------------------------------------------------------------------------
*/


--USER-----------------------------------------------------------------------------------------------

--USER SYNTAX
CREATE USER <USERNAME> [ [WITH] OPTIONS [...] ];

--OPTIONS
SUPERUSER | NOSUPERUSER
CREATEDB | NOCREATEDB
CREATEROLE | NOCREATEROLE
LOGIN | NOLOGIN
[ENCRYPTED] PASSWORD 'PASSWORD' | PASSWORD NULL
VALID UNTIL 'TIMESTAMP'

--CREATING A USER
--EXAMPLE 1:
CREATE USER jeff_user
with encrypted password '123456';

--EXAMPLE 2:
CREATE USER login_sistema
with encrypted password '1234567';


--REMOVING A USER
--PERMISSIONS MUST BE REMOVED FIRST USING 'REVOKE'
DROP USER <USERNAME>;


--PERMISSIONS---------------------------------------------------------------------------------------------

--SYNTAX - GRANTING PERMISSIONS
GRANT
SELECT | INSERT | UPDATE | DELETE | TRUNCATE | REFERENCES | TRIGGER | ALL
ON
<TABLES> | ALL TABLES IN SCHEMA <SCHEMA_NAME>
TO
<USERNAME>;


--SYNTAX - REVOKING PERMISSIONS
REVOKE
SELECT | INSERT | UPDATE | DELETE | TRUNCATE | REFERENCES | TRIGGER | ALL
ON
<TABLES> | ALL TABLES IN SCHEMA <SCHEMA_NAME>
TO
<USERNAME>;



-- PERMISSION TO USER: LOGIN_SISTEMA:

--GIVING SELECT PERMISSION ONLY ON THE 'USUÁRIOS' TABLE, AS THAT IS THE ONLY TABLE OF INTEREST TO THE USER 'LOGIN_SISTEMA'.
grant select on usuarios
to login_sistema;



-- PERMISSION TO USER: JEFF_USER:

--GIVING 'ALL' PERMISSION TO USER 'JEFF_USER' ON THE 'LOCACOES' TABLE (FOR 'INSERT INTO LOCACOES')
--GIVING 'INSERT' PERMISSION TO USER 'JEFF_USER' ON THE 'AUDITORIA' TABLE AND 'AUDITORIA_CODIGO_SEQ'.
grant all on locacoes
to jeff_user;

grant insert on auditoria
to jeff_user;

grant all on auditoria_codigo_seq
to jeff_user;

!!IMPORTANT!!
-- TO GRANT PERMISSIONS, YOU MUST BE LOGGED IN AS 'SUPERUSER'
-- TO TEST, SHOULD LOG OUT OF 'SUPERUSER' (POSTGRES) AND LOG IN AS 'JEFF_USER' OR 'LOGIN_SISTEMA'



--TEST-----------------------------------------------------------------------------------------------------
--LOGGED IN AS 'JEFF_USER'
INSERT INTO LOCACOES
(cod_socio, cod_livro, data_emprestimo, data_prevista, data_devolucao, taxa)
VALUES
(1, 4, '2021-10-01', '2021-10-10', null, null);

!!IMPORTANT!!
-- CHECK IF NEW DATA HAS BEEN INSERTED INTO 'LOCACOES' AS USER 'JEFF_USER'
-- CHECK IF DATA HAS BEEN INSERTED INTO THE 'AUDITORIA' TABLE AS USER 'JEFF_USER'


---------------------------------------------------------------------------------------------------------------




/*
------------------------------------------------------------------------------------------------
                                                                                              	
        BACKUP AND RESTORE                                                                    	
                                                                                              	
        - The method of performing a backup depends on the operating system and interface   	
        we are using. In the TEXT INTERFACE, we have the PG_DUMP command, which has a        	
        series of parameters for performing the backup.                                       	
                                                                                              	
        - In the GRAPHICAL INTERFACE, we right-click on the DATABASE and choose the "BACKUP" 	
        option. In the file type, choose PLAIN TEXT or TEXT depending on the settings of     	
        your interface. In the graphical interface, simply right-click on the database and   	
        choose the Restore option, specify the backup file generated earlier and the type   	
        that was generated.                                                                   	
                                                                                              	
        - PostgreSQL supports PLAIN TEXT and CUSTOMIZED BACKUP. In PLAIN TEXT, an SQL file    	
        is generated that can be viewed in any text editor, which is not the case with       	
        CUSTOMIZED BACKUP. When the backup is generated in a customized way, the restore     	
        must be done using the PG_RESTORE tool.                                                	
                                                                                              	
                                                                                              	
                                                                                              	
                                                                                              	
------------------------------------------------------------------------------------------------
*/




				-- END OF THE LIBRARY PROJECT--
								
								



--------------------------------------------------------------------------------------------------

--GENERIC COMMANDS IN POSTGRESQL

--------------------------------------------------------------------------------------------------

--POSTGRES SYSTEM QUERIES--
--FOR RETRIEVING POSTGRES DATABASE OBJECT INFORMATION---------------------------------------------

--TABLES
--Postgres table information can be retrieved either from the information_schema.tables view, 
--or from the pg_catalog.pg_tables view. Below are example queries:
select * from information_schema.tables;

select * from pg_catalog.pg_tables;
							
--SCHEMA
--This query will get the user's currently selected schema:
select current_schema();

--These queries will return all schemas in the database:
select * from information_schema.schemata;

select * from pg_catalog.pg_namespace

--DATABASES
--This query will get the user's currently selected database:
select current_database();

--This query will return all databases for the server:
select * from pg_catalog.pg_database

--VIEWS
--These queries will return all views across all schemas in the database:
select * from information_schema.views;

select * from pg_catalog.pg_views;

--COLUMNS FOR TABLES
--This query will return column information for a table named "livros":
SELECT
	*
FROM
	information_schema.columns
WHERE
	table_name = 'livros'
ORDER BY
	ordinal_position;

--INDEXES
--This query will return all index information in the database:
select * from pg_catalog.pg_indexes;

--FUNCTIONS
--This query will return all functions in the database. For user-defined functions, 
--the routine_definition column will have the function body:
select * from information_schema.routines where routine_type = 'FUNCTION';


--TRIGGERS
--This query will return all triggers in the database.
--The action_statement column contains the trigger body:
select * from information_schema.triggers;
