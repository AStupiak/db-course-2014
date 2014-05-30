CREATE TABLE CAR
	( 	car_id NUMBER PRIMARY KEY
	,	name varchar2(150)
	,	producation_start date
	,	producation_ent date
	);

CREATE TABLE group_parts
	( 	group_id NUMBER PRIMARY KEY
	,	name varchar2(100)
	,	parent_id NUMBER
	,	FOREIGN KEY (group_id)
      	REFERENCES group_parts(group_id)
	);

INSERT ALL
into CAR values(1, 'ford ka', '11-Nov-2009', '11-Nov-2015')
into CAR values(2, 'opel corsa', '11-Nov-1999', '11-Nov-2003')
into CAR values(3, 'vw polo', '11-Nov-1995', '11-Nov-2001')
select * from dual;

INSERT ALL
into group_parts values(1, 'Привод колеса', null)
into group_parts values(2, 'Рулевое управление', null)
into group_parts values(3, 'Рулевой механизм', 2)
into group_parts values(4, 'Фильтр рулевого управления', 3)
into group_parts values(5, 'Расходники', null)
into group_parts values(6, 'Фильтры', 5)
select * from dual;

CREATE TABLE autopart
	( 	autopart_id NUMBER PRIMARY KEY
	,	name VARCHAR2(100)
	,	group_id NUMBER
	);

create sequence inc1;

INSERT into autopart
SELECT 
	inc1.nextval as autopart_id,
	CAST ('part-' || rownum AS VARCHAR2(100)),
  	trunc(dbms_random.value(1, 6)) as group_id
FROM dual 
CONNECT BY LEVEL <= 1000;


alter TABLE autopart
add	FOREIGN KEY (group_id)
REFERENCES group_parts(group_id);


CREATE TABLE CAR_AUTOPARTS
	( 	car_id NUMBER
	,	part_id NUMBER 	
	);

INSERT into CAR_AUTOPARTS
SELECT 
	trunc(dbms_random.value(1, 6)) as car_id,
  	trunc(dbms_random.value(1, 1000)) as part_id
FROM dual 
CONNECT BY LEVEL <= 1500;


alter TABLE CAR_AUTOPARTS
add FOREIGN KEY (car_id)
REFERENCES car(car_id);

add FOREIGN KEY (part_id)
REFERENCES autopart(autopart_id);


select *
from car
WHERE producation_start <= to_date('2010', 'YYYY')
and producation_ent >= to_date('2010', 'YYYY');


update car set producation_start = ADD_MONTHS(producation_start, 1) WHERE producation_start <= to_date('2010', 'YYYY')
and producation_ent >= to_date('2010', 'YYYY');

select count(group_id)
from autopart a
Left join group_parts
on a.group_id = group_parts.group_id;

drop TABLE CAR;
drop TABLE group_parts;
drop TABLE CAR_AUTOPARTS;
drop TABLE autopart;
drop sequence inc1;


SELECT * 
FROM autopart 
WHERE id <= 10;