SELECT Наименование_товара
FROM     ЗАКАЗЫ
WHERE  (Дата_доставки > CONVERT(DATETIME, '2023-03-01 00:00:00', 102));

SELECT Цена
FROM     ТОВАРЫ
WHERE  (Цена > 50 AND Цена < 200);

SELECT Заказчик
FROM     ЗАКАЗЫ
WHERE  (Наименование_товара = 'Монитор');

SELECT Наименование_товара
FROM     ЗАКАЗЫ
WHERE  (Заказчик = N'Юг')
ORDER BY Дата_доставки