/* SAS Data Processing and Analysis

Bu proje, SAS kullanarak veri işleme ve analiz tekniklerini göstermektedir. Projede, veri setleri üzerinde çeşitli işlemler gerçekleştirilmiş ve farklı SAS prosedürleri kullanılmıştır. Aşağıda, her bir bölümün içeriği ve açıklaması bulunmaktadır.

## İçindekiler

1. [Veri Setini Hazırlama](#veri-setini-hazırlama)
2. [Veri Okuma ve Filtreleme](#veri-okuma-ve-filtreleme)
3. [Data Step Prosedürü](#data-step-prosedürü)
4. [If-Then ve If-Then-Do Yapıları](#if-then-ve-if-then-do-yapıları)
5. [Veri Manipülasyonu ve Yeni Kolonlar Oluşturma](#veri-manipülasyonu-ve-yeni-kolonlar-oluşturma)
6. [Karakter Fonksiyonları Kullanma](#karakter-fonksiyonları-kullanma)
7. [Tarih Fonksiyonları Kullanma](#tarih-fonksiyonları-kullanma)
8. [SAS'ta SQL Kullanımı](#sas'ta-sql-kullanımı)
9. [Analiz ve Raporlama](#analiz-ve-raporlama)
10. [Excel Dosyasına Veri Aktarma](#excel-dosyasına-veri-aktarma)

## Veri Setini Hazırlama

Bu bölümde, `pg1.storm_summary` veri seti okunarak `Storm_cat5` isimli yeni bir veri seti oluşturulmuştur. Veri seti, belirli kriterlere göre filtrelenmiş ve gerekli sütunlar seçilmiştir.

## Veri Okuma ve Filtreleme

Veri setindeki `CpRatio` ve `EqRatio` değişkenlerine göre yeni bir `Performance` değişkeni oluşturulmuştur. Ayrıca, `NOx` ve `Fuel` değişkenlerine göre `EmissionsLevel` isimli yeni bir değişken eklenmiştir.

## Data Step Prosedürü

Bu bölümde, `sashelp.BASEBALL` veri seti kullanılarak `Sporcu` değişkeni oluşturulmuş ve maaş değerine göre kategorilere ayrılmıştır.

## If-Then ve If-Then-Do Yapıları

`sashelp.cars` veri setinde, `DriveTrain` değişkenine göre veri filtrelenmiş ve `FWD` ve `RWD` değerleri atanmıştır. Ayrıca, `sashelp.baseball` veri setinde maaşa göre oyuncular kategorize edilmiştir.

## Veri Manipülasyonu ve Yeni Kolonlar Oluşturma

Bu bölümde, yeni kolonlar oluşturularak mevcut kolonlardan türetilmiş değerler kullanılmıştır. Örneğin, `Acres` kolonundan `SqMiles` hesaplanmış ve çeşitli kamp türlerinden `Camping` kolonuna değerler atanmıştır.

## Karakter Fonksiyonları Kullanma

Bu bölümde, karakter fonksiyonları kullanılarak belirli değişkenler üzerinde işlemler gerçekleştirilmiştir. `Basin` değişkeninin belirli karakterlerinden yola çıkarak filtreleme yapılmıştır.

## Tarih Fonksiyonları Kullanma

Tarih fonksiyonları kullanılarak yeni değişkenler türetilmiştir. Örneğin, `YEAR`, `MONTH`, `DAY` fonksiyonları kullanılarak tarih bilgileri ayrıştırılmıştır.

## SAS'ta SQL Kullanımı

SAS'ta SQL kullanarak veri setleri üzerinde sorgulamalar gerçekleştirilmiştir. `PROC SQL` kullanılarak veri setlerinde filtreleme, gruplama ve sıralama işlemleri yapılmıştır.

## Analiz ve Raporlama

`PROC MEANS` ve `PROC FREQ` gibi prosedürler kullanılarak veri setleri üzerinde özet istatistikler ve frekans raporları oluşturulmuştur. Ayrıca, grafiksel analizler için `PROC SGSCATTER` kullanılmıştır.

## Excel Dosyasına Veri Aktarma

`ODS EXCEL` kullanılarak, analiz sonuçları ve veri setleri Excel dosyasına aktarılmıştır. Excel dosyası, belirli bir stil kullanılarak oluşturulmuş ve çeşitli raporlar eklenmiştir.

---

Her bir bölümün detaylı açıklamaları ve kod örnekleri için ilgili SAS dosyalarına göz atabilirsiniz.
*/

/* prepare data */
/* Reading and Filtering Data */
/* data set prosedure */

/*
data output-table;
set input-table ;
run;
*/

/* Complication (derleme) and Execution (Yürütme)*/

/*Complication (derleme)
programdaki söz dizimi hataları
sutun özellikleri 
yeni bir tablo oluştururken meta bilgileri derler 
Execution (Yürütme)
verileri okuma 
veri manipülasyonu sergileme, hesaplama ve dahası 
*/

/* data output-table; set input-table ; where expression; *filters rows based on the expression run; */

/*where - drop -keep - format */

/* 
1. Write a DATA step that reads the pg1.storm_summary table and creates an output table named Storm_cat5. Note: If you are using SAS Studio, try creating storm_cat5 as a permanent table in the EPG1V2/output folder.

2. Include only Category 5 storms (MaxWindMPH greater than or equal to 156) with StartDate on or after 01JAN2000.

3. Add a statement to include the following columns in the output data: Season, Basin, Name, Type, and MaxWindMPH.

/* 1 */
data pg1.storm_cat5 ;
set pg1.storm_summary;
run;

/* 2 */
data pg1.storm_cat5 ;
set pg1.storm_summary;
where StartDate ="01jan2000"d or MaxWindMPH >= 156;
run;

/* 3 */
data pg1.storm_cat5 ;
set pg1.storm_summary;
where StartDate ="01jan2000"d or MaxWindMPH >= 156;
keep Season Basin Name Type MaxWindMPH;
run;


/* often data does not have all the columns that you need and you need to calculate or derive new columns from existing columns */
 ***********************************************************;
* Using Character Functions                               *; 
***********************************************************;
*   Syntax and Example                                    *;
*     DATA output-table;                                  *;
*         SET input-table;                                *;
*         new-column=function(arguments);                 *;
*     RUN;                                                *;
*                                                         *;
*  Numeric Functions:                                     *;
*    SUM(num1, num2, ...)                                 *;
*    MEAN(num1, num2, ...)                                *;
*    MEDIAN(num1, num2, ...)                              *;
*    RANGE(num1, num2, ...)                               *;
*                                                         *;
*  Character Functions:                                   *;
*    UPCASE(char)                                         *;
*    PROPCASE(char, <delimiters>)                         *;
*    CATS(char1, char2, ...)                              *;
*    SUBSTR(char, position, <length>:how many character)                     *;
***********************************************************;
data pacific;
    set pg1.storm_summary;
    drop type Hem_EW Hem_NS MinPressure Lat Lon;
    where substr(Basin,2,1)="P";
run;  


***********************************************************;
*  Using Date Functions                                   *;
***********************************************************;
*  Syntax                                                 *;
*                                                         *;
*  Date function examples:                                *;
*    YEAR (SAS-date)                                      *;
*    MONTH (SAS-date)                                     *;
*    DAY (SAS-date)                                       *;
*    WEEKDAY (SAS-date)                                   *;
*    TODAY ()                                             *;
*    MDY (month, day, year)                               *;
*    YRDIF (startdate, enddate, 'AGE')                    *;
***********************************************************;
***********************************************************;
*  LESSON 4, PRACTICE 4                                   *;
*    a) Create a new column named SqMiles by multiplying  *;
*       Acres by .0015625.                                *;
*    b) Create a new column named Camping as the sum of   *;
*       OtherCamping, TentCampers, RVCampers, and         *;
*       BackcountryCampers.                               *;
*    c) Format SqMiles and Camping to include commas and  *;
*       zero decimal places.                              *;
*    d) Modify the KEEP statement to include the new      *;
*       columns. Run the program.                         *;
***********************************************************;

data np_summary_update;      /* work kütüphanesine kaydedilecek casuser.np_summary_update diyip cas'a da kaydedebilirdik.*/
	set pg1.np_summary;      /* pg1 libinde np_summary e kaydet*/
	keep Reg ParkName DayVisits OtherLodging Acres SqMiles Camping;	/* bu kolonları tut*/
	*Add assignment statements;
	SqMiles=Acres*.0015625;   /* kolon adı SqMiles */
	Camping=sum(OtherCamping,TentCampers,
                RVCampers,BackcountryCampers);
	format SqMiles comma6. Camping comma10.;    /* comma binlik ayıraç olarak virgül kullanır
run;


/* format type ları bir daha hatırlayalım */
/*
Sayısal Formatlar
w.d:

w: Alan genişliğini (kaç karakter yer kaplayacağını) belirler.
d: Ondalık noktadan sonra kaç basamak gösterileceğini belirler.
Örnek: 8.2 formatı, 1234.567 sayısını 1234.57 olarak gösterir.
commaw.d:

Sayıları virgülle binlik ayıracı kullanarak gösterir.
w: Alan genişliği.
d: Ondalık basamak sayısı.
Örnek: comma10.2 formatı, 1234567.89 sayısını 1,234,567.89 olarak gösterir.
dollarw.d:

Sayıları dolar işareti ve virgülle binlik ayıracı kullanarak gösterir.
w: Alan genişliği.
d: Ondalık basamak sayısı.
Örnek: dollar10.2 formatı, 1234567.89 sayısını $1,234,567.89 olarak gösterir.
yenw.d:

Sayıları Japon yeni sembolü ve virgülle binlik ayıracı kullanarak gösterir.
w: Alan genişliği.
d: Ondalık basamak sayısı.
Örnek: yen10.2 formatı, 1234567.89 sayısını ¥1,234,567.89 olarak gösterir.
eurow.d:

Sayıları Euro sembolü ve virgülle binlik ayıracı kullanarak gösterir.
w: Alan genişliği.
d: Ondalık basamak sayısı.
Örnek: euro10.2 formatı, 1234567.89 sayısını €1,234,567.89 olarak gösterir.
Tarih Formatları
date7.:

Tarihi DDMONYY formatında gösterir.
Örnek: date7. formatı, 22MAY24 olarak gösterir.
date9.:

Tarihi DDMONYYYY formatında gösterir.
Örnek: date9. formatı, 22MAY2024 olarak gösterir.
mmddyy10.:

Tarihi MM/DD/YYYY formatında gösterir.
Örnek: mmddyy10. formatı, 05/22/2024 olarak gösterir.
ddmmyy8.:

Tarihi DD/MM/YY formatında gösterir.
Örnek: ddmmyy8. formatı, 22/05/24 olarak gösterir.
monyy7.:

Tarihi MONYYYY formatında gösterir.
Örnek: monyy7. formatı, MAY2024 olarak gösterir.
monname.:

Ayın ismini gösterir.
Örnek: monname. formatı, May olarak gösterir.
weekdate.:

Tarihi Day-of-week, Month DD, YYYY formatında gösterir.
Örnek: weekdate. formatı, Wednesday, May 22, 2024 olarak gösterir.
*/



/* ıf then statment */
data CASUSER.baseballsashelp;
set sashelp.BASEBALL;
if Salary>2000 then Sporcu=1;
if Salary<=2000 then Sporcu =0;
if Salary =. then Sporcu=.;
run;


/* NOT */
/* or kullanıyorsan biri doğru olsa yeter and kullanıyorsan iki sorgu da doğru olmalı.*/
/* LENGTH char-column $lenght 
ex: lenght cartype $6 6 karakter uzunluğunda olan cartypeları getirir.
*/
data under40 over40;
set sashelp.cars;
keep Make Model msrp cost_group;
if MSRP<2000 then do;
Cost_group =1;
output under40;
end;

proc contents data=sashelp.baseball;
run;

/* for baseball 
maaşı yüksek olanları ayrı bir tabloda tut
maası <500 ise x  */
data maaşı_yuksek x ;
	set sashelp.baseball;
	keep League Name Position Salary Team nHits nHome;

	if Salary<=500 then do; x="under_expectation";
		output x;
		end;
	else if Salary<1000 then do; x="average_expectation";
		output x;
		end;
	else do; x="overrate_expectation";
		output maaşı_yuksek;
		end;
run;

/* 2. bir deneme */
data under_expectation average_expectation maasi_yuksek;
	set sashelp.baseball;
	keep League Name Position Team nHits nHome;
	if Salary<=500 then do; x=1;
		output under_expectation;
		end;
	else if Salary<1000 then do; x=2;
		output average_expectation;
		end;
	else do;
         x=3;
		output maasi_yuksek;
		end;
run;

/* her if else if else do statement sonunda end ile bitir;
 run; quit; gibi */

proc print data=sashelp.GAS;
run;

proc CONTENTS data=sashelp.GAS;
RUN;

/* Tabii ki! İşte SAS'ta if-else yapıları kullanarak `SASHELP.GAS` veri setiyle çalışabileceğiniz sorular. Bu sorular, veri seti içeriği hakkında bilgi sahibi olmanızı ve if-else yapılarını öğrenmenizi sağlayacaktır.
Fuel	CpRatio	EqRatio	NOx
### Soru 1:
Veri setindeki `CpRatio` değişkeni motorun sıkıştırma oranını temsil eder. Yeni bir değişken `Performance` oluşturun ve aşağıdaki koşullara göre değerlendirerek bu değişkende saklayın:
- Eğer `CpRatio` 10'dan büyükse ve `EqRatio` 1'e eşitse, `Performance` değeri "High Efficiency" olsun.
- Eğer `CpRatio` 8 ile 10 arasında (10 dahil) ve `EqRatio` 0.8 ile 1 arasında (1 dahil) ise, `Performance` değeri "Medium Efficiency" olsun.
- Eğer `CpRatio` 8'den küçükse veya `EqRatio` 0.8'den küçükse, `Performance` değeri "Low Efficiency" olsun.
- Diğer durumlarda, `Performance` değeri "Unknown" olsun.*/

data gas_performance;
set sashelp.gas;
if CpRatio>10 and EqRatio=1 then  Performance = "High Efficiency";
else if 8<= CpRatio <= 10 and 0.8 <= EqRatio <1 then Performance = "Medium Efficiency" ;
else if  8< CpRatio and EqRatio<0.8 then Performance = "Low Efficiency" ;
else Performance = "Unknown";
run;




/*### Soru 2:
Veri setindeki `NOx` değişkeni azot oksit emisyonlarını temsil eder.
Yeni bir değişken `EmissionsLevel` oluşturun ve aşağıdaki koşullara göre değerlendirerek bu değişkende saklayın:
- Eğer `NOx` 50'den büyükse ve `Fuel` "Gasoline" ise, `EmissionsLevel` değeri "High Emission" olsun.
- Eğer `NOx` 30 ile 50 arasında (50 dahil) ve `Fuel` "Diesel" ise, `EmissionsLevel` değeri "Moderate Emission" olsun.
- Eğer `NOx` 30'dan küçükse ve `Fuel` "NaturalGas" ise, `EmissionsLevel` değeri "Low Emission" olsun.
- Diğer durumlarda, `EmissionsLevel` değeri "Undefined" olsun. */

data gas_emissions;
	set sashelp.gas;

	if NOx > 50 and Fuel="Gasoline" then
		EmissionsLevel="High Emission";
	else if 30 <=NOx <=50 and Fuel="Diesel" then
		EmissionsLevel="Moderate Emission";
	else if NOx < 30 and Fuel="NaturalGas" then
		EmissionsLevel="Low Emission";
	else
		EmissionsLevel="Undefined";
run;

/*
*******	SQL
>> sadece görmemizi sağlar
select ---> hangi sütunlarla ilgileniyorum
from -----> nereden
...
--------------------
create table NEREYE.NEYİ AS
select sütun1, sütun2
from 

-------------
SELECT
--- tutacağın/inceleyeceğin sütunları seçersin
--- yeni sütunlar yaratırsın
--- sütunların adını değiştirebilirsin
--- sütunların formatını değiştirebilirsin



---------------
FROM
-- işleyeceğin/göreceğin veriyi seçiyorsun
-- tek de olabilir, bir sürü de olabilir
-- JOIN --> farklı verileri birbirine bağlayabilirsin
-- INNER QUERY --> 
	select ...
	from (select ..., yeni_sutun from tablo where ...)

	select
	from A
	where a.id in (select id from B where şehir="Ankara")

--------
JOIN
-- left join	---> a left join b on a.id = b.id
-- inner join
-- right join
-- outer join
-- full join (join)

-------------
WHERE
-- satırları filtrelersin

...
where şehir in ("Ankara", "İstanbul", "İzmir");
where şehir = "Ankara" or şehir="İstanbul" or şehir="İzmir";

proc sql; ---> procedure of sql --> macro function gibi
--> obs

---------
OBS
50k satır		-	10
-- INOBS	---> inobs = 10
		---> sadece datasetinin ilk 10 satırını alır
		---> senin işlemin 10 satır içerisinde gerçekleştirilir.
	**---> test yapmak için
-- OUTOBS	---> outobs = 10
			----> 50k satırın tamamında çalışıyor.
			---> diyelimki işlem sonucunda 46k satırlık veri oluşuyor
			---> sana sadece 10 satırını gösteriyor
*** NOT ***
hiçbir zaman, asıl veri üzerinde değişiklik yapma!
mutlaka ama mutlaka, yeni oluşturduğun sütunların isimi farklı olsun!!

*/
proc print data=gas_emissions (obs=10); /* İlk 10 gözlemi yazdır */
run;


proc print data=sashelp.cars;
run;

data front rear;
    set sashelp.cars;
    if DriveTrain="Front" then do;
        DriveTrain="FWD";
        output front;
    end;
    else if DriveTrain='Rear' then do;
        DriveTrain="RWD";
        output rear;
   end;
run;


/*  Processing Statements Conditionally with IF-THEN/ELSE */ 
proc print data=pg1.np_summary (obs=10);
run;
/* 1. */  
data parktype; 
set pg1.np_summary;
if type ="NM" then ParkType ="Monument";
else if type="NP" THEN pARKtYPE = "Park";
else if type = "NPRE, PRE, or PRESERVE" then ParkType = "Preserve";
else if Type in ('RVR', 'RIVERWAYS') then ParkType='River';
    else if Type='NS' then ParkType='Seashore';
run;
proc freq data=parktype;
    tables Type;     /* type tablosu yapıyor */ 
run;


/* 2. Modify the PROC FREQ step to generate a frequency report for ParkType. Submit the program.*/
data park_type;
    set pg1.np_summary;
    length ParkType $ 8;
    if Type='NM' then ParkType='Monument';
    else if Type='NP' then ParkType='Park';
    else if Type in ('NPRE', 'PRE', 'PRESERVE') then
        ParkType='Preserve';
    else if Type in ('RVR', 'RIVERWAYS') then ParkType='River';
    else if Type='NS' then ParkType='Seashore';
run;

proc freq data=park_type;
    tables ParkType;       /* arkların tablosunu yapıyoruz */ 
run;

/* Analyzing and Reporting on Data */
/* title, footnote, ods nonproctitle */

title "Storm Analysis";
title2 "Summary Statistics for MaxWind and MinPressure";
proc means data=pg1.storm_final;
   var MaxWindMPH MinPressure;
run;
title2 "Frequency Report for Basin";
proc freq data=pg1.storm_final;
   tables BasinName;
run; 

/* BY Statement */
proc sort data=sashelp.cars;
by Origin;
run;

/* creating summary reports and data */
proc means data=pg1.storm_final noprint;
    var MaxWindMPH;
    class BasinName;
    ways 1;
    output out=wind_stats;
run;


title1 'Weather Statistics by Year and Park';
proc means data=pg1.np_westweather mean min max maxdec=2;
    var Precip Snow TempMin TempMax;
    class Year Name;
run;


Solution:
proc means data=pg1.np_westweather noprint;
    where Precip ne 0;
    var Precip;
    class Name Year;
	ways 2;
	output out=rainstats n=RainDays sum=TotalRain;
run;



Solution:
title1 'Rain Statistics by Year and Park';
proc print data=rainstats label noobs;
    var Name Year RainDays TotalRain;
    label Name='Park Name'
          RainDays='Number of Days Raining'
          TotalRain='Total Rain Amount (inches)';
run;
title

/* export data */
libname xl_lib xlsx "&outpath/storm.xlsx";

data xl_lib.storm_final;
    set pg1.storm_final;
    drop Lat Lon Basin OceanCode;
run;

libname xl_lib clear;

/*Add ODS statements to create an Excel file named pressure.xlsx. Use &outpath to provide the path to the file. Be sure to close the ODS location at the end of the program.

Run the program and open the Excel file.
SAS Studio: In your output folder, select pressure.xlsx and click Download.
Enterprise Guide: Click the Results tab. Under Open with Default Application, double-click the Excel icon.

Add the STYLE=ANALYSIS option in the first ODS EXCEL statement. Run the program again and open the Excel file.*/
ods excel file="&outpath/pressure.xlsx" style=analysis;

title "Minimum Pressure Statistics by Basin";
ods noproctitle;
proc means data=pg1.storm_final mean median min maxdec=0;
    class BasinName;
    var MinPressure;
run;

title "Correlation of Minimum Pressure and Maximum Wind";
proc sgscatter data=pg1.storm_final;
	plot minpressure*maxwindmph;
run;
title;  

ods proctitle;
ods excel close;
 