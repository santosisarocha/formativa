CREATE DATABASE hogwards;
USE hogwards;

create table usuarios_excluidos (
Id_usuarios_excluidos int auto_increment,
nome varchar (255),
email varchar (255),
dte date,
PRIMARY KEY (Id_usuarios_excluidos)
);

create table usuarios (
Id_usuario int auto_increment,
nome varchar (255),
email varchar (255),
dtn date,
senha varchar (255),
dtc date,
papel varchar (255),
usuarios_excluidosID int, 
PRIMARY KEY (Id_usuario),
FOREIGN KEY (usuarios_excluidosID) REFERENCES usuarios_excluidos (Id_usuarios_excluidos)
);

create table ocupacoes (
Id_ocupacoes int auto_increment,
nome varchar (255),
PRIMARY KEY (Id_ocupacoes)
);

create table restricao (
Id_restricao int auto_increment,
papel varchar(255),
permicao varchar(255),
PRIMARY KEY (Id_restricao)
);

create table locais (
Id_locais int auto_increment,
nome varchar(255),
bloco varchar(1),
capacidades int,
PRIMARY KEY (Id_locais)
);

create table Checklist (
Id_Checklist int auto_increment,
Id_locais int,
requisito varchar(255),
verificado boolean,
PRIMARY KEY (Id_Checklist),
FOREIGN KEY (Id_locais) REFERENCES locais (Id_locais)
);

create table eventos (
Id_eventos  int auto_increment,
nome varchar(255),
dti datetime,
dtf datetime,
checkinAN int,
checkinAP int,
capacidadetotal int,
capacidadefinal int,
Id_locais int,
PRIMARY KEY (Id_eventos)
);

create table participantes (
Id_participantes int auto_increment,
Id_eventos int,
Id_usuario int,
ticket varchar(255),
PRIMARY KEY (Id_participantes),
FOREIGN KEY (Id_eventos) REFERENCES eventos (Id_eventos),
FOREIGN KEY (Id_usuario) REFERENCES usuarios (Id_usuario)
);

insert into usuarios (Id_usuario, nome, email, dtn, senha, dtc, papel)
values
(4, 'eduardo', 'eduardosantos@gmail.com', '2005-09-12', 'eduardo123', '2023-01-18', 'aluno'),
(3, 'alanis', 'alanisdavid@gmail.com', '2004-02-11', 'alanis123', '2023-04-18', 'aluno'),
(2, 'iago', 'iagomunhoz@gmail.com', '2004-09-11', 'iago123', '2023-05-18', 'aluno'),
(1, 'isabela', 'isabelarocha@gmail.com', '2004-09-10', 'isabela123', '2023-05-18', 'aluno');

insert into  ocupacoes (Id_ocupacoes, nome)
values
(4, 'aluno'),
(3, 'orientador'),
(2, 'secretaria'),
(1, 'assistende social');

insert into  restricao (Id_restricao, papel, permicao)
values
(4, 'admin', 'acessototal'),
(3, 'gestor', 'cadastro'),
(2, 'usuario', 'reservarevento'),
(1, 'visitante', 'inscriçãoevento');

insert into  locais (Id_locais, nome, bloco, capacidades)
values
(4, 'a01', 'a', 30),
(3, 'b01', 'b', 20),
(2, 'c01', 'c', 25),
(1, 'd01', 'd', 30);

insert into  locais (Id_locais, nome, bloco, capacidades)
values
(5, 'a02', 'a', 30);


insert into  Checklist (Id_Checklist, Id_locais, requisito, verificado)
values
(12, 1, 'ar condicional', 1),
(11, 1, 'Tv smart', 1),
(10, 1, 'projetor', 1),
(9, 3, 'ar condicional', 1),
(8, 3, 'Tv smart', 0),
(7, 3, 'projetor', 1),
(6, 4, 'ar condicional', 1),
(5, 4, 'Tv smart', 1),
(4, 4, 'projetor', 0),
(3, 2, 'ar condicional', 1),
(2, 2, 'Tv smart', 0),
(1, 2, 'projetor', 0);

insert into  eventos (Id_eventos, nome, dti, dtf, checkinAN, checkinAP, capacidadetotal, capacidadefinal )
values
(4, 'evento4', '2023-05-10', '2023-05-12',40,40,30,30),
(3, 'evento3', '2023-01-10', '2023-02-02',30,30,25,25),
(2, 'evento2', '2023-02-04', '2023-03-10',60,60,20,20),
(1, 'evento1', '2022-09-10', '2022-09-15',20,20,30,30);

insert into  eventos (Id_eventos, nome, dti, dtf, checkinAN, checkinAP, capacidadetotal, capacidadefinal )
values
(5, 'evento5', '2023-05-10', '2023-05-12',40,40,30,30);

insert into participantes (Id_participantes, Id_eventos, Id_usuario, ticket)
values
(9, 4, 1, '57245227'),
(8, 4, 2, '275872'),
(7, 3, 3, '527872'),
(6, 2, 1, '22825572'),
(5, 1, 2, '2525254245'),
(4, 4, 4, '57245227'),
(3, 3, 4, '25252425'),
(2, 2, 4, '2425242'),
(1, 1, 4, '2525254245');

select Id_locais
from locais
inner join eventos e on Id_locais ;

select Id_locais
from locais 
inner join eventos e on Id_locais 
where Id_locais is null;

select Id_eventos, nome, dti, dtf  
from eventos
where dti and dtf between '2022-09-10' and '2023-02-02';

select u.Id_usuario, u.nome  
from usuarios u
inner join participantes p on p.Id_eventos = u.Id_usuario;

select e.Id_eventos, e.nome, u.Id_usuario, u.nome 
from eventos e
inner join participantes p on p.Id_eventos = e.Id_eventos
inner join usuarios u on u.Id_usuario = p.Id_usuario
where e.dti > current_date();

select u.Id_usuario, u.nome, count(p.Id_usuario) as quantidadeChc
from eventos e 
inner join participantes p on p.Id_eventos = e.Id_eventos
inner join usuarios u on u.Id_usuario = p.Id_usuario
where e.dti > current_date
group by u.Id_usuario, u.nome;

select e.Id_eventos, e.nome, count(p.Id_participantes) as quantidadeChc
from eventos e 
left join participantes p on p.Id_eventos = e.Id_eventos
group by e.Id_eventos, e.nome
order by  quantidadeChc desc;

select e.Id_eventos, e.nome, count(p.Id_participantes) as quantidadeChc
from eventos e 
left join participantes p on p.Id_eventos = e.Id_eventos
group by e.Id_eventos, e.nome
order by  quantidadeChc asc;

select l.Id_locais, l.nome, avg(e.capacidadetotal) as Mediaparticipantes 
from locais l
left join eventos e on e.Id_locais = l.Id_locais
group by l.Id_locais, l.nome;

select u.Id_usuario, u.nome as perfilacesso 
from usuarios u 
inner join restricao r on r.Id_restricao = u.papel; 

select e.Id_eventos, e.nome , e.dti
from eventos e 
where e.checkinAN > 0
and e.dtf >= current_date()
