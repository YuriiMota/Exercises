use labor_sql;

-- 4.1
-- SELECT  maker FROM product WHERE maker  IN (SELECT maker from product WHERE type='pc' ) 
-- AND maker NOT IN(SELECT maker from product WHERE type='laptop') ; 
-- 4.2
 -- SELECT DISTINCT maker, type FROM product WHERE maker  != ALL(SELECT maker from product where type='laptop') AND type  LIKE 'pc';
-- 4.3 SELECT distinct p.maker FROM labor_sql.product as p where p.maker NOT IN (SELECT distinct p.maker FROM labor_sql.product as p where p.maker = any   
-- (SELECT distinct pp.maker FROM labor_sql.product as pp where pp.type like 'Laptop'))  and p.type like 'PC';
-- 4.4
-- SELECT distinct p.maker FROM labor_sql.product as p where p.maker in  
-- (SELECT pp.maker FROM labor_sql.product as pp where pp.type like 'Laptop' and p.type like 'PC');
-- 4.5
--  SELECT * FROM product pr WHERE 
--  NOT pr.model != ALL(SELECT pc.model FROM pc)
--  AND
--  NOT pr.maker !=ALL(SELECT pr2.maker FROM laptop JOIN product as pr2 ON laptop.model = pr2.model WHERE pr2.maker = pr.maker);
-- 4.6
--  SELECT * FROM product pr WHERE 
--  pr.model = ANY(SELECT pc.model FROM pc )
--  AND
--  pr.maker = ANY(SELECT pr2.maker FROM laptop JOIN product as pr2 ON laptop.model = pr2.model WHERE pr2.maker = pr.maker);
-- 5.1
--  SELECT maker,type  from product  WHERE EXISTS (SELECT maker from pc.model  where product.model= pc.model)  ;
-- 5.2
 -- SELECT maker FROM product AS p WHERE  EXISTS( SELECT * from pc where p.model= pc.model and pc.speed>=750);
 -- 5.3
 --  SELECT  maker FROM product p WHERE EXISTS (SELECT * from pc where p.model= pc.model and pc.speed>=750)
 -- AND exists (SELECT * from laptop l where l.speed>=750 and EXISTS(SELECT * from product p where p.model= l.model));
 -- 5.4 
-- SELECT maker from product  p WHERE EXISTS (SELECT * FROM printer pr where p.model=pr.model) AND 
-- SELECT  DISTINCT maker FROM PC JOIN Product p3 ON p3.model=PC.model WHERE EXISTS(SELECT * FROM Product  p 
-- WHERE p.model=PC.model and EXISTS(SELECT * FROM Product p2 WHERE p2.maker = p.maker AND p2.type = 'Printer')) 
-- AND speed = (SELECT MAX(speed) FROM PC );
-- 6.1
-- SELECT CONCAT("Average price ", FORMAT(AVG(price),'E')) AS Average_price FROM laptop;
-- 6.2
-- SELECT CONCAT("model:",model) AS model, CONCAT("price: ",price) AS price FROM PC;
-- 6.3
--  SELECT DATE_FORMAT(date, '%Y.%m.%d') AS date FROM income;
-- 6.4
 -- SELECT ship, battle, replace(replace(replace(result,'sunk','potonuv'),'damaged','poshkodjenuy'),'OK','Dobre ye') AS Translated FROM outcomes;
-- 6.5
-- SELECT CONCAT('Row:', SUBSTRING(place, 1, 1)) AS row, CONCAT('Place:', SUBSTRING(place, 2, 1)) AS place  FROM pass_in_trip;
-- 6.6
-- SELECT CONCAT("From ",town_from, " to ",town_to) AS direction  FROM trip;
 -- 7.1
 -- SELECT model, max(price) FROM printer ;
 -- 7.2
 -- SELECT  type, l.model, speed from laptop l JOIN  product p on p.model=l.model AND   speed<any(SElect speed from pc);
 -- 7.3
 -- SELECT p.maker, printer.price FROM product p JOIN printer  ON p.model=printer.model AND printer.price=(SELECT min(price) from printer) ;
 -- 7.4
 -- SELECT p.maker, printer.price FROM product p JOIN printer  ON p.model=printer.model AND printer.price=(SELECT min(price) from printer) ;
 -- 7.5
 -- SELECT AVG(hd) as avg_hd FROM product  p JOIN pc ON p.model = pc.model WHERE EXISTS(SELECT * FROM product WHERE type = 'printer' and maker = p.maker)
-- 8.1
-- SELECT maker,
--            (SELECT COUNT(*) FROM  pc JOIN product pr ON pc.model = pr.model WHERE pr.maker = product.maker) as pc,
--          (SELECT COUNT(*) FROM  laptop JOIN product pr ON laptop.model = pr.model WHERE pr.maker = product.maker) as laptop,
--         (SELECT COUNT(*) FROM  printer JOIN product pr ON printer.model = pr.model WHERE pr.maker = product.maker) as printer
--  FROM product  GROUP  BY  maker
-- 8.2
-- p.maker,avg(screen) FROM product as p join laptop as l on p.model=l.model group by p.maker;
-- 8.3
-- SELECT maker, (SELECT MAX(price) FROM  pc  JOIN product pr ON pc.model = pr.model WHERE pr.maker = product.maker   ) as price from product  group by maker;
-- 8.4
 -- SELECT maker, (SELECT MIN(price) FROM  pc  JOIN product pr ON pc.model = pr.model WHERE pr.maker = product.maker   ) as price from product  groupby maker;
 -- 8.5
-- 9.1
-- SELECT p.maker, case When (SELECT COUNT(*) FROM  pc JOIN product pr ON pc.model = pr.model WHERE pr.maker = p.maker)>0 
-- THEN CONCAT('YES(',FORMAT((SELECT COUNT(*) FROM  pc JOIN product pr ON pc.model = pr.model WHERE pr.maker = p.maker),'E'),')') 
-- ELSE 'NO' END  as pc FROM product p group by maker;
-- 9.2
-- SELECT point, date, 
--         CASE  
 --       WHEN  subquery.inc IS NULL THEN 0
 --               ELSE subquery.inc
 --               END as 'inc', 
 --               CASE  
 --       WHEN  subquery.out IS NULL THEN 0
--                ELSE subquery.out
--                END as 'out' 
                
-- FROM (SELECT i.point, i.date, inc, o.out FROM income_o i left join outcome_o   o on i.date = o.date 
--  UNION
-- SELECT o.point, o.date, inc, o.out FROM income_o i right join outcome_o  o on i.date = o.date) as subquery;
-- 9.3
 -- SELECT * FROM ships s JOIN classes c ON s.class= c.class 
 --   WHERE    case WHEN numGuns = 8 OR bore = 15 OR displacement= 32000 OR type= 'bb'THEN true
 --  ELSE false 
--   end;
-- 9.4
-- SELECT trip_no, plane, town_from, town_to ,  
 -- 	case WHEN EXTRACT(HOUR FROM time_in)-EXTRACT(HOUR FROM time_out)>0 THEN
-- 		(CONCAT(HOUR(time_in)-HOUR(time_out),' hour'))   ELSE 
-- 		(CONCAT(24-HOUR(time_out)+HOUR(time_in),' hour')) END AS HOUR,
-- 	case WHEN EXTRACT(MINUTE FROM time_in)-EXTRACT(MINUTE FROM time_out)>0 THEN
-- 		(CONCAT(MINUTE(time_in)-MINUTE(time_out),' minute'))   ELSE 
-- 		(CONCAT(60-MINUTE(time_out)+MINUTE(time_in),' minute')) END AS MINUTE
-- from trip;
-- -- 10.
-- 10.1
-- SELECT maker, product.model, product.type, price FROM product   JOIN pc ON pc.model = product.model WHERE maker = 'B'
-- UNION ALL
-- SELECT maker, product.model, product.type, price FROM product   JOIN laptop ON laptop.model = product.model WHERE maker = 'B'
-- UNION ALL
-- SELECT maker, product.model, product.type, price FROM product   JOIN printer ON printer.model = product.model WHERE maker = 'B';
-- 10.2
 -- SELECT  product.model, product.type, MAX(price) FROM product   JOIN pc ON pc.model = product.model 
 -- UNION 
 -- SELECT product.model, product.type, MAX(price) FROM product   JOIN laptop ON laptop.model = product.model 
-- UNION 
-- SELECT product.model, product.type, MAX(price) FROM product   JOIN printer ON printer.model = product.model;
-- 10.3
 -- SELECT AVG(price) FROM(
 --   SELECT  price FROM product   JOIN pc ON pc.model = product.model WHERE maker = 'A'
  --    UNION 
  --  SELECT  price FROM product   JOIN laptop ON laptop.model = product.model WHERE maker = 'A') as s;
-- 10.4
-- SELECT name, class FROM ships WHERE class=name 
 --  UNION 
-- SELECT ship, ship FROM outcomes WHERE EXISTS(SELECT * FROM ships WHERE outcomes.ship = ships.class); 
-- 10.5
 -- SELECT * FROM(SELECT name FROM ships WHERE class=name 
 -- UNION ALL
-- SELECT ship FROM outcomes WHERE EXISTS(SELECT * FROM ships WHERE outcomes.ship = ships.class)) as s  GROUP BY name HAVING  COUNT(*)=1;
