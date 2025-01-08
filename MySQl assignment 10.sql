use country;
create table teachers (Id int primary key, name char(25),subject CHAR(25),experience int, salary int);
insert into teachers values (1,'smitha','maths',2,20000);
insert into teachers values (2,'Mathew','english',1,19000);
insert into teachers values (3,'Angel','science',3,21000);
insert into teachers values (4,'Amith','maths',5,24000);
insert into teachers values (5,'Anjali','Science',6,25000);
insert into teachers values (6,'Osto','Malayalam',4,23000);
insert into teachers values (7,'Anil','P.T',5,24000);

select *from teachers;
Delimiter $$
create trigger alary_error
before insert on teachers
for each row
begin
if new.salary <0 then
signal 	SQLstate '45000' set message_text = 'Salary cannot be negative';
end if;
end $$
Delimiter ;
insert into teachers values (13,'Raghav','Hindi',8,'-1000');
drop trigger teachers;
create table teacher_log(teacher_id int, action char(24), time timestamp);
drop table teacher_log;
Delimiter $$
create trigger after_insertteacher
after insert on teachers
for each row
begin
insert into teacher_log (teacher_id,action,time)
 values (new.Id,'inserted',now());
end;
$$
Delimiter ;
drop trigger after_insertteacher;
insert into teachers values (15,'Anil','P.T',5,24000);
select*from teacher_log;
Delimiter $$
create trigger experience_error
before delete on teachers
for each row
begin
if old.experience > 4 then
signal SQLstate '45000' set message_text = 'experience geater than 10 years cannot be deleted';
end if;
end;
$$
Delimiter ;
drop trigger experience_error;
delete from teachers where Id = 7;
Delimiter $$
create trigger deleted_teachers
after delete on teachers
for each row
begin
insert into teacher_log (teacher_id,action,time)
 values (old.Id,'deleted',now());
end;
$$
Delimiter ;
delete from teachers where id =2;
select*from teacher_log;












