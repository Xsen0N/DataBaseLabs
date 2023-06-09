--средн балл по субд >5 сообщени Ю5 и средний балл/Б 5 то же 
declare @agrnote varchar(10) = (select cast(avg(PROGRESS.NOTE) as varchar(10) )from PROGRESS where PROGRESS.SUBJECT ='СУБД')
if(@agrnote < 5)
print 'Оценка < 5'+ @agrnote
else print 'Оценка > 5: '+ @agrnote