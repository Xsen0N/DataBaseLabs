--����� ���� �� ���� >5 �������� �5 � ������� ����/� 5 �� �� 
declare @agrnote varchar(10) = (select cast(avg(PROGRESS.NOTE) as varchar(10) )from PROGRESS where PROGRESS.SUBJECT ='����')
if(@agrnote < 5)
print '������ < 5'+ @agrnote
else print '������ > 5: '+ @agrnote