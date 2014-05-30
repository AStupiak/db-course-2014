drop table recipe cascade constraints;
drop table ingredients cascade constraints;
drop table product cascade constraints;
drop table uom cascade constraints;

create table recipe (
  id number(19,0) not null, 
  title varchar2(255 char) not null, 
  constraint recipe_pk primary key(id));
  
create table product (
  id number(19,0) not null,  
  uom_id number(19,0) not null, 
  name varchar2(125 char) not null, 
  constraint product_pk primary key(id),
  constraint uom_fk foreign key(uom_id) references uom(id));
  
create table ingredients (
  id number(19,0) not null, 
  recipe_id number(19,0) not null, 
  product_id number(19,0) not null,
  quantity number(10,3),
  constraint ingredients_pk primary key(id),
  constraint ingredients_fk foreign key(product_id) references Product(name)
  constraint recipe_fk foreign key(recipe_id) references Recipe(id),);
  
create table uom (
  id number(19,0) not null,  
  name varchar2(125 char) not null, 
  "code" varchar2(15 char) not null,  
  constraint uom_pk primary key(id));
  

insert into recipe (id, title) values (1, 'friedEggs');