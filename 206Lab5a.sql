Drop table module;
Create table Module
(Module_code     char(5) primary key,
Module_name     varchar2(30) Not Null,
Credits   number(2),
Teacher        char(4));
Insert into Module values('M001','Database System and Design',10, 'F001');
Insert into Module values('M002','System Methodolgoies',20, 'F002');
Insert into Module values('M003','Data Structure and Algorithm',30, 'F006');
Insert into Module values('M004','Web Programming',40, 'F007');

commit;