drop table PROGRESS
drop table STUDENT
 drop table GROUPS
drop table SUBJECT
drop table TEACHER
drop table  PULPIT
drop table PROFESSION
drop table FACULTY
drop table AUDITORIUM 
drop table AUDITORIUM_TYPE  

------------�������� � ���������� ������� AUDITORIUM_TYPE 

create table AUDITORIUM_TYPE 
(    AUDITORIUM_TYPE  char(10) constraint AUDITORIUM_TYPE_PK  primary key,  
      AUDITORIUM_TYPENAME  varchar(30)       
 )
insert into AUDITORIUM_TYPE   (AUDITORIUM_TYPE,  AUDITORIUM_TYPENAME )        values ('��',            '����������');
insert into AUDITORIUM_TYPE   (AUDITORIUM_TYPE,  AUDITORIUM_TYPENAME )         values ('��-�',          '������������ �����');
insert into AUDITORIUM_TYPE   (AUDITORIUM_TYPE, AUDITORIUM_TYPENAME )         values ('��-�',          '���������� � ���. ����������');
insert into AUDITORIUM_TYPE   (AUDITORIUM_TYPE,  AUDITORIUM_TYPENAME )          values  ('��-X',          '���������� �����������');
insert into AUDITORIUM_TYPE   (AUDITORIUM_TYPE, AUDITORIUM_TYPENAME )        values  ('��-��',   '����. ������������ �����');
                      
-------------�������� � ���������� ������� AUDITORIUM  
  create table AUDITORIUM 
(   AUDITORIUM   char(20)  constraint AUDITORIUM_PK  primary key,              
    AUDITORIUM_TYPE     char(10) constraint  AUDITORIUM_AUDITORIUM_TYPE_FK foreign key         
                      references AUDITORIUM_TYPE(AUDITORIUM_TYPE), 
   AUDITORIUM_CAPACITY  integer constraint  AUDITORIUM_CAPACITY_CHECK default 1  check (AUDITORIUM_CAPACITY between 1 and 300),  -- ����������� 
   AUDITORIUM_NAME      varchar(50)                                     
)
insert into  AUDITORIUM   (AUDITORIUM, AUDITORIUM_NAME,  
 AUDITORIUM_TYPE, AUDITORIUM_CAPACITY)   
values  ('206-1', '206-1','��-�', 15);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, 
AUDITORIUM_TYPE, AUDITORIUM_CAPACITY) 
values  ('301-1',   '301-1', '��-�', 15);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, 
AUDITORIUM_TYPE, AUDITORIUM_CAPACITY )   
values  ('236-1',   '236-1', '��',   60);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, 
AUDITORIUM_TYPE, AUDITORIUM_CAPACITY )  
values  ('313-1',   '313-1', '��-�',   60);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, 
AUDITORIUM_TYPE, AUDITORIUM_CAPACITY )  
values  ('324-1',   '324-1', '��-�',   50);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, 
AUDITORIUM_TYPE, AUDITORIUM_CAPACITY )   
 values  ('413-1',   '413-1', '��-�', 15);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, 
AUDITORIUM_TYPE, AUDITORIUM_CAPACITY ) 
values  ('423-1',   '423-1', '��-�', 90);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, 
AUDITORIUM_TYPE, AUDITORIUM_CAPACITY )     
values  ('408-2',   '408-2', '��',  90);

  ------�������� � ���������� ������� FACULTY
  create table FACULTY
  (    FACULTY      char(10)   constraint  FACULTY_PK primary key,
       FACULTY_NAME  varchar(50) default '???'
  );
insert into FACULTY   (FACULTY,   FACULTY_NAME )
            values  ('����',   '���������� ���������� � �������');
insert into FACULTY   (FACULTY,   FACULTY_NAME )
            values  ('���',     '����������������� ���������');
insert into FACULTY   (FACULTY,   FACULTY_NAME )
            values  ('���',     '���������-������������� ���������');
insert into FACULTY   (FACULTY,   FACULTY_NAME )
            values  ('����',    '���������� � ������� ������ ��������������');
insert into FACULTY   (FACULTY,   FACULTY_NAME )
            values  ('���',     '���������� ������������ �������');
insert into FACULTY   (FACULTY,   FACULTY_NAME )
            values  ('��',     '��������� �������������� ����������');  
------�������� � ���������� ������� PROFESSION
   create table PROFESSION
  (   PROFESSION   char(20) constraint PROFESSION_PK  primary key,
       FACULTY    char(10) constraint PROFESSION_FACULTY_FK foreign key 
                            references FACULTY(FACULTY),
       PROFESSION_NAME varchar(100),    QUALIFICATION   varchar(50)  
  );  
 insert into PROFESSION(FACULTY, PROFESSION, PROFESSION_NAME, QUALIFICATION)    values    ('��',  '1-40 01 02',   '�������������� ������� � ����������', '�������-�����������-�������������' );
 insert into PROFESSION(FACULTY, PROFESSION, PROFESSION_NAME, QUALIFICATION)    values    ('��',  '1-47 01 01', '������������ ����', '��������-��������' );
 insert into PROFESSION(FACULTY, PROFESSION,  PROFESSION_NAME, QUALIFICATION)    values    ('��',  '1-36 06 01',  '��������������� ������������ � ������� ��������� ����������', '�������-��������������' );                     
 insert into PROFESSION(FACULTY, PROFESSION,  PROFESSION_NAME, QUALIFICATION)  values    ('����',  '1-36 01 08',    '��������������� � ������������ ������� �� �������������� ����������', '�������-�������' );
 insert into PROFESSION(FACULTY, PROFESSION,  PROFESSION_NAME, QUALIFICATION)      values    ('����',  '1-36 07 01',  '������ � �������� ���������� ����������� � ����������� ������������ ����������', '�������-�������' );
 insert into PROFESSION(FACULTY, PROFESSION, PROFESSION_NAME, QUALIFICATION)  values    ('���',  '1-75 01 01',      '������ ���������', '������� ������� ���������' );
 insert into PROFESSION(FACULTY, PROFESSION,  PROFESSION_NAME, QUALIFICATION)   values    ('���',  '1-75 02 01',   '������-�������� �������������', '������� ������-��������� �������������' );
 insert into PROFESSION(FACULTY, PROFESSION,     PROFESSION_NAME, QUALIFICATION)   values    ('���',  '1-89 02 02',     '������ � ������������������', '���������� � ����� �������' );
 insert into PROFESSION(FACULTY, PROFESSION, PROFESSION_NAME, QUALIFICATION)  values    ('���',  '1-25 01 07',  '��������� � ���������� �� �����������', '���������-��������' );
 insert into PROFESSION(FACULTY, PROFESSION,  PROFESSION_NAME, QUALIFICATION)      values    ('���',  '1-25 01 08',    '������������� ����, ������ � �����', '���������' );                      
 insert into PROFESSION(FACULTY, PROFESSION,     PROFESSION_NAME, QUALIFICATION)  values    ('����',  '1-36 05 01',   '������ � ������������ ������� ���������', '�������-�������' );
 insert into PROFESSION(FACULTY, PROFESSION,   PROFESSION_NAME, QUALIFICATION)   values    ('����',  '1-46 01 01',      '�������������� ����', '�������-��������' );
 insert into PROFESSION(FACULTY, PROFESSION,     PROFESSION_NAME, QUALIFICATION)      values    ('���',  '1-48 01 02',  '���������� ���������� ������������ �������, ���������� � �������', '�������-�����-��������' );                
 insert into PROFESSION(FACULTY, PROFESSION,   PROFESSION_NAME, QUALIFICATION)    values    ('���',  '1-48 01 05',    '���������� ���������� ����������� ���������', '�������-�����-��������' ); 
 insert into PROFESSION(FACULTY, PROFESSION,    PROFESSION_NAME, QUALIFICATION)  values    ('���',  '1-54 01 03',   '������-���������� ������ � ������� �������� �������� ���������', '������� �� ������������' ); 

------�������� � ���������� ������� PULPIT
  create table  PULPIT 
(   PULPIT   char(20)  constraint PULPIT_PK  primary key,
    PULPIT_NAME  varchar(100), 
    FACULTY   char(10)   constraint PULPIT_FACULTY_FK foreign key 
                         references FACULTY(FACULTY) 
);  
insert into PULPIT   (PULPIT, PULPIT_NAME, FACULTY )
  values  ('����', '�������������� ������ � ���������� ','��'  )
insert into PULPIT   (PULPIT, PULPIT_NAME, FACULTY)
    values  ('��', '�����������','���')          
insert into PULPIT   (PULPIT, PULPIT_NAME, FACULTY)
   values  ('��', '��������������','���')           
insert into PULPIT   (PULPIT, PULPIT_NAME, FACULTY)
  values  ('�����', '���������� � ����������������','���')                
insert into PULPIT   (PULPIT,  PULPIT_NAME, FACULTY)
   values  ('����', '������ ������� � ������������','���') 
insert into PULPIT   (PULPIT,  PULPIT_NAME, FACULTY)
   values  ('���', '������� � ������������������','���')              
insert into PULPIT   (PULPIT, PULPIT_NAME, FACULTY)
   values  ('������','������������ �������������� � ������-��������� �������������','���')          
insert into PULPIT   (PULPIT, PULPIT_NAME, FACULTY)
   values  ('��', '���������� ����', '����')                          
insert into PULPIT   (PULPIT, PULPIT_NAME, FACULTY)
   values  ('�����','������ ����� � ���������� �������������','����')  
insert into PULPIT   (PULPIT, PULPIT_NAME, FACULTY)
   values  ('���','���������� �������������������� �����������', '����')   
insert into PULPIT   (PULPIT, PULPIT_NAME, FACULTY)
values  ('�����','���������� � ������� ������� �� ���������','����')    
insert into PULPIT   (PULPIT, PULPIT_NAME, FACULTY)
values  ('��', '������������ �����','���') 
insert into PULPIT   (PULPIT, PULPIT_NAME, FACULTY)
 values  ('���','���������� ����������� ���������','���')             
insert into PULPIT   (PULPIT, PULPIT_NAME, FACULTY)
 values  ('�������','���������� �������������� ������� � ����� ���������� ���������� ','����') 
insert into PULPIT   (PULPIT, PULPIT_NAME, FACULTY)
    values  ('�����','��������� � ��������� ���������� �����������','����')                                               
insert into PULPIT   (PULPIT,    PULPIT_NAME, FACULTY)
values  ('����',    '������������� ������ � ����������','���')   
insert into PULPIT   (PULPIT,    PULPIT_NAME, FACULTY)
  values  ('����',   '����������� � ��������� ������������������','���')   
insert into PULPIT   (PULPIT,    PULPIT_NAME, FACULTY)
   values  ('������', '����������, �������������� �����, ������� � ������', '���')     
             
------�������� � ���������� ������� TEACHER
 create table TEACHER
 (   TEACHER    char(10)  constraint TEACHER_PK  primary key,
     TEACHER_NAME  varchar(100), 
     GENDER     char(1) CHECK (GENDER in ('�', '�')),
     PULPIT   char(20) constraint TEACHER_PULPIT_FK foreign key 
                         references PULPIT(PULPIT) 
 );
insert into  TEACHER    (TEACHER,   TEACHER_NAME, GENDER, PULPIT )
                       values  ('����',    '������ �������� �������������', '�',  '����');
insert into  TEACHER    (TEACHER,  TEACHER_NAME, GENDER, PULPIT )
                       values  ('���',     '����� ��������� ����������', '�', '���');
insert into  TEACHER    (TEACHER,  TEACHER_NAME, GENDER, PULPIT )
                       values  ('���',     '��������� ����� ��������', '�', '����');
insert into  TEACHER    (TEACHER,  TEACHER_NAME, GENDER, PULPIT )
                      values  ('���',     '����� ������� ��������', '�', '����');
insert into  TEACHER    (TEACHER,  TEACHER_NAME, GENDER, PULPIT )
                       values  ('���',     '����� ������� �������������',  '�', '����');                     
insert into  TEACHER    (TEACHER,  TEACHER_NAME, GENDER, PULPIT )
                       values  ('���',     '����� ����� �������������',  '�',   '����');                                                                                           
insert into  TEACHER    (TEACHER,  TEACHER_NAME, GENDER, PULPIT )
             values  ('������',   '���������� ��������� �������������', '�','������ ');
insert into  TEACHER    (TEACHER,  TEACHER_NAME, GENDER, PULPIT )
                       values  ('���',     '��������� ������� �����������', '�', '������ ');                       
insert into  TEACHER    (TEACHER,  TEACHER_NAME, GENDER, PULPIT )
                       values  ('����',   '������� ��������� ����������', '�', '����');
insert into  TEACHER    (TEACHER,  TEACHER_NAME, GENDER, PULPIT )
                       values  ('����',   '������ ������ ��������', '�', '��');
insert into  TEACHER    (TEACHER,  TEACHER_NAME, GENDER, PULPIT )
                       values  ('����', '������� ������ ����������',  '�',  '������');
insert into  TEACHER    (TEACHER,  TEACHER_NAME, GENDER, PULPIT )
                       values  ('���',     '���������� ������� ��������', '�', '������');
insert into  TEACHER    (TEACHER,  TEACHER_NAME, GENDER, PULPIT )
                       values  ('���',   '������ ������ ���������� ', '�', '��');                      
insert into  TEACHER    (TEACHER,  TEACHER_NAME, GENDER, PULPIT )
                       values  ('�����',   '��������� �������� ���������', '�', '����'); 
insert into  TEACHER    (TEACHER,  TEACHER_NAME, GENDER, PULPIT )
                       values  ('������',   '���������� �������� ����������', '�', '��'); 
insert into  TEACHER    (TEACHER,  TEACHER_NAME, GENDER, PULPIT )
                       values  ('�����',   '�������� ������ ����������', '�', '��'); 
	------�������� � ���������� ������� SUBJECT
create table SUBJECT
    (     SUBJECT  char(10) constraint SUBJECT_PK  primary key, 
           SUBJECT_NAME varchar(100) unique,
           PULPIT  char(20) constraint SUBJECT_PULPIT_FK foreign key 
                         references PULPIT(PULPIT)   
     )
 insert into SUBJECT   (SUBJECT,   SUBJECT_NAME, PULPIT )
                       values ('����',   '������� ���������� ������ ������', '����');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,  PULPIT)
                       values ('��',     '���� ������','����');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,  PULPIT )
                       values ('���',    '�������������� ����������','����');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,  PULPIT )
                       values ('����',  '������ �������������� � ����������������', '����');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,  PULPIT )
                       values ('��',     '������������� ������ � ������������ ��������', '����');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,  PULPIT )
                       values ('���',    '���������������� ������� ����������', '����');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,  PULPIT )
                       values ('����',  '������������� ������ ��������� ����������', '����');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,  PULPIT )
                       values ('���',     '�������������� �������������� ������', '����');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,  PULPIT )
                       values ('��',      '������������ ��������� ','����');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,  PULPIT )
           values ('�����',   '��������. ������, �������� � �������� �����', '�����');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,  PULPIT )
                       values ('���',     '������������ �������������� �������', '����');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME, PULPIT )
                       values ('���',     '����������� ��������. ������������', '�����');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME, PULPIT)
                       values ('��',   '���������� ����������', '����');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,PULPIT )
                      values ('��',   '�������������� ����������������','����');  
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME, PULPIT )
               values ('����', '���������� ������ ���',  '����');                   
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,PULPIT )
               values ('���',  '��������-��������������� ����������������', '����');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME, PULPIT )
                       values ('��', '��������� ������������������','����')
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME, PULPIT )
                       values ('��', '������������� ������','����')
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME, PULPIT )
                       values ('�������','������ ������-��������� � ������������� ���������',  '����')
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,PULPIT )
                       values ('��', '���������� �������� ','��')
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,PULPIT )
                       values ('��',    '�����������', '�����') 
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME, PULPIT )
                       values ('��',    '������������ �����', '��')   
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,PULPIT )
                       values ('���',    '���������� ��������� �������','������') 
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME, PULPIT )
                       values ('���',    '������ ��������� ����','��')
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,PULPIT )
                       values ('����',   '���������� � ������������ �������������', '�����') 
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,PULPIT )
                       values ('����',   '���������� ���������� �������� ���������� ','����')
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME, PULPIT )
                       values ('���',    '���������� ������������','����')                                                                                                                                                           
  
------�������� � ���������� ������� GROUPS
create table GROUPS 
(   IDGROUP  integer constraint GROUP_PK  primary key,              
    FACULTY   char(10) constraint  GROUPS_FACULTY_FK foreign key         
                                                         references FACULTY(FACULTY), 
     PROFESSION  char(20) constraint  GROUPS_PROFESSION_FK foreign key         
                                                         references PROFESSION(PROFESSION),
    YEAR_FIRST  smallint  check (YEAR_FIRST<=YEAR(GETDATE())),                  
  )
insert into GROUPS (IDGROUP,FACULTY,  PROFESSION, YEAR_FIRST )
         values (1,'�T','1-40 01 02', 2013), --1
                (2,'�T','1-40 01 02', 2012),
                (6,'�T','1-40 01 02', 2011),
                (3,'�T','1-40 01 02', 2010),
                (4,'�T','1-47 01 01', 2013),---5 ��
                (5,'�T','1-47 01 01', 2012),
                (7,'�T','1-47 01 01', 2011),
                (8,'�T','1-36 06 01', 2010),-----8 ��
                (9,'�T','1-36 06 01', 2013),
                (10,'�T','1-36 06 01', 2012),
                (11,'�T','1-36 06 01', 2011),
                (12,'����','1-36 01 08', 2013),---12 ��                                                  
                (13,'����','1-36 01 08', 2012),
                (14,'����','1-36 07 01', 2011),
                (15,'����','1-36 07 01', 2010),
                (16,'���','1-48 01 02', 2012), ---16 �� 
                (17,'���','1-48 01 02', 2011),
                (18,'���','1-48 01 05', 2013),
                (19,'���','1-54 01 03', 2012),
                (20,'���','1-75 01 01', 2013),--20 ��      
                (21,'���','1-75 02 01', 2012),
                (22,'���','1-75 02 01', 2011),
                (23,'���','1-89 02 02', 2012),
                (24,'���','1-89 02 02', 2011),  
                (25,'����','1-36 05 01', 2013),
                (26,'����','1-36 05 01', 2012),
                (27,'����','1-46 01 01', 2012),--27 ��
                (28,'���','1-25 01 07', 2013), 
                (29,'���','1-25 01 07', 2012),     
                (30,'���','1-25 01 07', 2010),
                (31,'���','1-25 01 08', 2013),
                (32,'���','1-25 01 08', 2012); ---32 ��       
                          
------�������� � ���������� ������� STUDENT
create table STUDENT 
(    IDSTUDENT   int  constraint STUDENT_PK  primary key,
      IDGROUP   integer  constraint STUDENT_GROUP_FK foreign key         
                      references GROUPS(IDGROUP),        
      NAME   nvarchar(100), 
      BDAY   date,
      STAMP  timestamp,
      INFO     xml,
      FOTO     varbinary
 ) 
insert into STUDENT (IDGROUP,IDSTUDENT,NAME, BDAY)
    values (1,1001, '����� ������� ��������',         '12.07.1994'),
           (2,1002, '������� �������� ����������',    '06.03.1994'),
           (3,1003, '�������� ����� �����������',     '09.11.1994'),
           (4,1004, '������� ����� ���������',        '04.10.1994'),
           (5, 1005,'��������� ��������� ����������', '08.01.1994'),
           (6,1006, '������� ������ ���������',       '02.08.1993'),
           (7,1007, '������� ��� ����������',         '07.12.1993'),
           (8, 1008,'������� ����� �����������',      '02.12.1993'),
           (9,1009, '������� ������ �����������',     '08.03.1992'),
           (10, 1010,'������� ����� �������������',    '02.06.1992'),
           (11,1011, '�������� ����� �����������',     '11.12.1992'),
           (12,1012, '�������� ������� �������������', '11.05.1992'),
           (13,1013, '����������� ������� ��������',   '09.11.1992'),
           (14, 1014,'�������� ������� ����������',    '01.11.1992'),
           (15, 1015,'�������� ����� ������������',    '08.07.1995'),
           (16,1016, '������ ������� ����������',      '02.11.1995'),
           (17,1017, '������ ��������� �����������',   '07.05.1995'),
           (18,1018, '����� ��������� ���������',      '04.08.1995'),
           (19,1019, '���������� ����� ����������',    '08.11.1994'),
           (20,1020, '�������� ������ ��������',       '02.03.1994'),
           (21,1021, '���������� ����� ����������',    '04.06.1994'),
           (22, 1022,'��������� ���������� ���������', '09.11.1994'),
           (23,1023, '����� ��������� �������',        '04.07.1994')
           --(24,1024, '����������� ����� ������������', '03.01.1993'),
           --(25,1025, '������� ���� ��������',          '12.09.1993'),
           --(26, 1026,'��������� ������ ��������',      '12.06.1993'),
           --(27, 1027,'���������� ��������� ����������','09.02.1993'),
           --(28, 1028,'������� ������ ���������',       '04.07.1993'),
           --(29,1029, '������ ������� ���������',       '08.01.1992'),
           --(30, 1030,'��������� ����� ����������',     '12.05.1992'),
           --(31,1031, '�������� ����� ����������',      '08.11.1992');
------�������� � ���������� ������� PROGRESS
create table PROGRESS
 (  SUBJECT   char(10) constraint PROGRESS_SUBJECT_FK foreign key
                      references SUBJECT(SUBJECT),                
     IDSTUDENT integer  constraint PROGRESS_IDSTUDENT_FK foreign key         
                      references STUDENT(IDSTUDENT),        
     PDATE    date, 
     NOTE     integer check (NOTE between 1 and 10)
  )
insert into PROGRESS (SUBJECT, IDSTUDENT, PDATE, NOTE)
    values  ('����', 1001,  '01.10.2013',8),
           ('����', 1002,  '01.10.2013',7),
           ('����', 1003,  '01.10.2013',5),
           ('����', 1005,  '01.10.2013',4)
insert into PROGRESS (SUBJECT, IDSTUDENT, PDATE, NOTE)
    values   ('����', 1014,  '01.12.2013',5),
           ('����', 1015,  '01.12.2013',9),
           ('����', 1016,  '01.12.2013',5),
           ('����', 1017,  '01.12.2013',4)
insert into PROGRESS (SUBJECT, IDSTUDENT, PDATE, NOTE)
    values ('��',   1018,  '06.5.2013',4),
           ('��',   1019,  '06.05.2013',7),
           ('��',   1020,  '06.05.2013',7),
           ('��',   1021,  '06.05.2013',9),
           ('��',   1022,  '06.05.2013',5),
           ('��',   1023,  '06.05.2013',6)

