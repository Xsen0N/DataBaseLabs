--Select PROGRESS.IDSTUDENT, STUDENT.NAME, FACULTY.FACULTY_NAME, PULPIT.PULPIT, PROFESSION.PROFESSION, PROGRESS.SUBJECT,
--case PROGRESS.NOTE
--when 6 then '�����'
--when 7 then '����'
--when 8 then '������'
--else '������'
--end [������]
--from PROGRESS inner join STUDENT on PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT
--inner join SUBJECT on PROGRESS.SUBJECT = SUBJECT.SUBJECT
--inner join PULPIT on SUBJECT.PULPIT = PULPIT.PULPIT
--inner join FACULTY on PULPIT.FACULTY = FACULTY.FACULTY
--inner join PROFESSION on FACULTY.FACULTY = PROFESSION.FACULTY
--order by  PROGRESS.NOTE DESC;
use UNIVER
Select PROGRESS.IDSTUDENT, STUDENT.NAME, FACULTY.FACULTY_NAME, PULPIT.PULPIT, PROFESSION.PROFESSION, PROGRESS.SUBJECT,PROGRESS.NOTE,
Case 
when (PROGRESS.NOTE between 6 and 8) then ' �� ����� �� ������'
else '������'
end [������]
from PROGRESS inner join STUDENT on PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT
inner join SUBJECT on PROGRESS.SUBJECT = SUBJECT.SUBJECT
inner join PULPIT on SUBJECT.PULPIT = PULPIT.PULPIT
inner join FACULTY on PULPIT.FACULTY = FACULTY.FACULTY
inner join PROFESSION on FACULTY.FACULTY = PROFESSION.FACULTY
order by  PROGRESS.NOTE DESC;