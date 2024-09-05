/* CAS oturumunu başlat */
cas casauto;

/* Tüm CAS kütüphanelerini atamak */
caslib _all_ assign;

proc print data=sashelp.cars (obs=10);
run;

proc contents data=sashelp.cars;
run;

/* En yüksek MSRP değerine sahip araçları sorgulamak için nasıl bir subquery yazarsınız?*/
proc sql;
	select Make, Model, Type, MSRP from sashelp.cars where MSRP=(select max(MSRP) 
		from sashelp.cars);
quit;

/* Origin değeri 'Asia' ve DriveTrain değeri 'Front' olan araçları sorgulamak için
nasıl bir WHERE cümleciği yazarsınız?*/
proc sql;
	select * from sashelp.cars WHERE Origin="Asia" and DriveTrain="Front";
quit;

/* Marka başına ortalama MPG_City değeri 20'den büyük olan markaları sorgulamak için
nasıl bir HAVING cümleciği yazarsınız?*/
PROC SQL;
	SELECT Make, Model, Type, Origin FROM sashelp.cars having avg(MPG_City)>20;
quit;

proc sql;
	select Make, avg(MPG_City) as Avg_MPG_City from sashelp.cars group by Make 
		having avg(MPG_City) > 20;
quit;

/* MSRP değeri belirli bir aralıkta olan araçları sorgulamak için nasıl bir subquery
yazarsınız?*/
proc sql;
	select Make, Model, Type, MSRP from sashelp.cars where MSRP between (select 
		min(MSRP) from sashelp.cars) and
	(select max(MSRP) from sashelp.cars where MSRP < 30000);
quit;

proc sql;
	select Make, Model, Type, MSRP from sashelp.cars where MSRP between (select 
		min(MSRP) from sashelp.cars) and
	(select max(MSRP) from sashelp.cars where MSRP < 30000);
quit;

/* Araç türüne göre ortalama Horsepower değeri 200'den büyük olan araç türlerini
sorgulamak için nasıl bir HAVING cümleciği yazarsınız? */

proc sql;
select Type,avg(Horsepower) as  Avg_Horsepower
from sashelp.cars
group by Type
Having avg(HorsePower)>200;
quit;