create database ctf;
use ctf;
create table items
(
id int NOT NULL AUTO_INCREMENT key,
name varchar(200),
price int
);

insert into items (name, price) values ('lolita', 1000);
insert into items values (1314, 'lolita''s flag is flag{fake flag}', 1688);