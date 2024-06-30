/* SAS® Programming 3: Advanced Techniques */
/* Data Step Review
Lesson 2: Using Advanced Functions
- Using a Variety of Advanced Functions
- Performing Pattern Matching with Perl Regular Expressions
Lesson 3: Defining and Processing Arrays
- Defining and Referencing One-Dimensional Arrays
- Doing More with One-Dimensional Arrays
- Defining and Referencing Two-Dimensional Arrays
Lesson 4: Defining and Processing Hash Objects
- Declaring Hash Objects
- Defining Hash Objects
- Finding Key Values in a Hash Object
- Writing a Hash Object to a Table
- Using Hash Iterator Objects
Lesson 5: Using Utility Procedures
- Creating Picture Formats with the FORMAT Procedure
- Creating Functions with the FCMP Procedure
*/


/* Data Step Review */
/* compilation : establish data attributes and rules for execution
program data vector (PDV) 
execution: read manipulate and write data 
/* syntax
data outtable;
    set input-table;
    other statement;
run;*/

/* putlog _all_;     - PDV'deki tüm sütunları ve değerleri loga yazar.
putlog columns = ;   - PDV'deki seçilen sütunları ve değerleri loga yazar.
putlog "message";    - Bir metin dizesini loga yazar. 
*/
data work.PctGrowth18Yrs;
    length Continent $ 13 Country $ 18;
    set pg3.population_top25countries;
    Country=scan(CountryCodeName, 2, '-');
    PctGrowth18Yrs=(Pop2017-Pop2000)/Pop2000*100;
    drop CounrtyCodeName;
    format Pop2000 Pop2017 comma16. PctGrowth18Yrs 5.1;
    run;
/* comma16. formatı virgül formatı uygular.
 5.1 formatı uygular (5 basamak, 1 ondalık).*/


 /* Group by continent */
proc sort data=pg3.population_top25countries
          out=work.continent_sorted;
    by Continent descending Pop2017;
run;


/* using functions 
CHARACTER:
- LENGHT
- FIND
- CAT 
- CATS 
- CATX 
-SUBSTR

DATE AND TIME:
- YEAR
- DATEPART
- MDY
- TODAY

TRUNCATION:
-ROUND
-CEIL
-INT
-FLOOR

SPECIAL:
-INPUT
-PUT

DESCRIPTIVE STATISTICS:
-SUM
-MIN
-MAX
-MEDIAN
-MEAN

Additional Functions
- COUNT
- COUNTC
- COUNTW
- LAG
- FINDC
- FINDW


/* Definitions of Functions and CALL Routines */
Functions are used in DATA step programming statements
CALL routines are similar to functions, but differ from functions
in that you cannot use them in assignment statements or expressions.


/* LAG FUNCTIONS */
LAG <n> (argument)*/
data one;
    input x @@;
    y=lag1(x);
    z=lag2(x);
    datalines;
 1 2 3 4 5 6
 ;
 proc print data=one;
    title 'LAG Output';
 run;

data work.china_temps;
    set pg3.weather_china_daily2017(keep=City Date TavgC);
	by City;
    TavgCPrevDay=lag1(TavgC);
	if first.City=1 then TavgCPrevDay=.;
    TempIncrease=TavgC-TavgCPrevDay;
run;

/* calculatıng moving average- hareketli ortalama hesaplama */

data work.stockmovingavg;
    set pg3.stocks_ABC(drop=Close);
    Open1MnthBack=lag1(Open);
    Open2MnthBack=lag2(Open);
   if _N_ ge 3 then
    Open3MnthAvg=mean(Open,lag1(Open),lag2(Open));
    format Open3MnthAvg 8.2;
run;

/* 
if _N_ ge 3 then
_N_ otomatik değişkeni, şu anda işlenen satırın numarasını tutar. _N_ ge 3 koşulu,
yalnızca üçüncü satırdan itibaren işlem yapar 
(yani, en az iki önceki satırın mevcut olduğu durumlar).
*/

title 'Three Month Moving Average on Opening Stock Price'; 
proc print data=work.stockmovingavg noobs;
run;

/* Count:COUNT fonksiyonu, bir karakter dizisinde belirli bir alt dizinin kaç kez geçtiğini sayar.

COUNT(string, substring) 

Countw :COUNTW fonksiyonu, bir karakter dizisinde kaç kelime olduğunu sayar.
Kelimeler, varsayılan olarak boşluk, virgül, nokta gibi belirli ayırıcı karakterlerle ayrılmış olarak kabul edilir. 
Fakat, özel ayırıcı karakterler de belirtilebilir.

COUNTW(string, <delimiters>)

FIND FUNCTION:
FINDW 
*/

data work.narrative;
    set pg3.tornado_2017narrative;
    /* COUNT Functions */
    NumEF=count(Narrative,'EF');
    NumWord=countw(Narrative,' ');
    /* FIND Functions */
    EFStartPos=find(Narrative,'EF');
    EFWordNum=findw(Narrative,'EF');
    /* SCAN Function */
    if EFWordNum>0 then 
       AfterEF=scan(Narrative,EFWordNum+1,'012345- .,');
run;

proc print data=work.narrative;
run;

proc means data=work.narrative maxdec=2;
    var NumEF NumWord ;
run;

proc freq data=work.narrative order=freq;
    tables AfterEF;
run;
 
/* Practice Level 1: Using the LAG Function*/
data work.ParkTraffic2016;
    set pg3.np_2016traffic;
    by ParkCode;
PrevMthTC= lag1(TrafficCount);
if first.ParkCode=1 then PrevMthTC=.;
OneMthChange = TrafficCount-PrevMthTC ;
run;

title '2016 National Park Traffic Counts';
proc print data=work.ParkTraffic2016;
run;

/* Practice Level 2: Using the COUNT and FINDW Functions */ 

data work.SouthRim;
    set pg3.np_grandcanyon;
    NumSouth=count(Comments,'South','i');  /* comments sütunu içerisinde South kelimesini saydıralım*/ 
    if NumSouth>0;
run;

title 'Grand Canyon Comments Regarding South Rim';
proc print data=work.SouthRim;
run;
title;


data work.SouthRim;
    set pg3.np_grandcanyon;
    NumSouth=count(Comments,'South','i');  /* comments sütunu içerisinde South kelimesini saydıralım*/ 
	if NumSouth>0;	
	SouthWordPos=findw(Comments, 'South', '');  
/* 'e': Bu, findw fonksiyonunun, kelimenin tam olarak eşleşmesini araması için kullanılır. 
Yani, kelimenin başı ve sonu belirtilen sınırlayıcılarla ayrılmış olmalıdır.
'i': Bu, aramanın büyük/küçük harf duyarsız olmasını sağlar. 
Yani, 'South', 'south', 'SOUTH' vb. gibi her türlü varyasyonu bulunabilir.*/
	 AfterSouth=scan(Comments,SouthWordPos+1,' .');
run;

/* Challenge Practice: Using the COUNTC Function */
 
/* Scientific_Name isimleri  ve Common_Names isimleri aynı olan değişkenleri sırayla say */
data work.Mammal_Names;
    set pg3.np_mammals(keep=Scientific_Name Common_Names);
    SpecCharNum=countc(Common_Names,',/*');
    if SpecCharNum=0 then do;
       Name=Common_Names;
       output;
    end;
    else do i=1 to SpecCharNum+1;     
       Name=scan(Common_Names,i,',/*');	
       output;
    end;
run;


/* Performing Pattern Matching with Perl Regular Expressions (PRX) */
/* - PRXCHANGE - PRXMATCH -PRXPARSE FUNCTION  */ 



/*          /^([2-9]\d\d)-([2-9]\d\d)-(\d{4})$/         */ 
/* 
\d : DİGİTS (0-9)
() : FOR GROUPING.
. : MATCH ANY CHARACTER 
[] : MATCH CHARACTER 
^ : beginnig of the string
$ : match the end of the string /^([2-9]\d\d)-([2-9]\d\d)-(\d{4})$/

Exp= ' /^([2-9]\d\d)-([2-9]\d\d)-(\d{4})$/o ';  
 o ifadesi sadece bir kere compiled edileceğini söyler 
Pid=prxparse(Exp);
Loc=prxmatch(Pid, Phone);
*/

/* PRXPARSE */

data work.ValidPhoneNumbers;
    set pg3.phonenumbers_us;
    Loc=prxmatch('/([2-9]\d\d)-([2-9]\d\d)-(\d{4})/ ', Phone);
    run;
    
    data work.ValidPhoneNumbers;
        set pg3.phonenumbers_us;
        Loc = prxmatch('/([2-9]\d{2})-([2-9]\d{2})-(\d{4})/', Phone);
        LocStartedEnd = prxmatch('/^([2-9]\d{2})-([2-9]\d{2})-(\d{4})$/', strip(Phone));
        LocParen = prxmatch('/\(([2-9]\d{2})\)\s*-([2-9]\d{2})-(\d{4})/', strip(Phone));
    run;
    
/* PRXCHANGE (perl-regular-expression, times, source)
 SAS'ta düzenli ifadeler kullanarak bir metin içinde belirli bir deseni arar ve bulduğu bu deseni başka bir metinle değiştirir.

's/ INT( |L |L. )/ INTERNATIONAL /i'
s: Bu, düzenli ifade işleminin bir değiştirme (substitution) işlemi olduğunu belirtir.
/: Bu, düzenli ifadenin başlangıç ve bitişini belirleyen sınırlayıcıdır (delimiter).
Arama Deseni:
INT: Boşlukla başlayan ve ardından büyük harflerle "INT" gelen bir desen arar.
(: Bir grubu başlatır.
|: Boşlukla devam eden bir deseni arar.
L : "INT" den sonra bir boşluk ve "L" harfi arar.
|: Veya operatörü; alternatif desenleri belirtir.
L.: "INT" den sonra bir boşluk, "L" harfi ve bir nokta arar.
): Grubu kapatır.
Değiştirme Deseni:
/: Orta sınırlayıcı, arama desenini değiştirme deseninden ayırır.
INTERNATIONAL: Boşlukla başlayan, ardından "INTERNATIONAL" kelimesi ve sonunda tekrar boşluk olan bir desenle değiştirir.
/: Bitiş sınırlayıcı, düzenli ifadenin sonunu belirtir.
i: Harflerin büyük/küçük harf duyarlılığını göz ardı eder (case-insensitive arama yapar).


's/(-?\d+\.\d*)(@)(-?\d+\.\d*)/$3$2$1/' 

$3$2$1 bunlar buffer ters yazarsak da bunu 123 sırası ile değil de 321 sırası ile getiririz.
*/


data work.tornadoEF;
    set pg3.tornado_2017narrative;
    length Narrative_New $ 4242;
    Loc=prxmatch('/EF-/',Narrative);       /* prxmatch fonksiyonu, Narrative değişkeninde 'EF-' desenini arar ve bu deseni bulan konumun indeksini Loc değişkenine atar. */
    /*Eğer 'EF-' deseni bulunmazsa, Loc değişkeni sıfır değerini alır.*/
	Narrative_New=prxchange('s/EF-/EF/',-1,Narrative);  /* prxchange fonksiyonu, Narrative değişkenindeki tüm 'EF-' desenlerini 'EF' ile değiştirir ve sonucu Narrative_New değişkenine yazar.*/
run;

title 'US Tornados';
proc print data=work.tornadoEF;
run;
title;  

/* Using the PRXMATCH and PRXCHANGE Functions*/ 
data work.NationalPreserves;
    set pg3.np_acres;
    Position=prxmatch('/N PRES\s|N PRESERVE\s|NPRES\s|NPRE\s/',ParkName);
    if Position ne 0;
run;

title 'National Preserves (NPRE)';
proc print data=work.NationalPreserves;
run;
title;


data work.BaseballPlayers; 
    set sashelp.baseball(keep=Name);  
    FirstLastName=prxchange('s/(\w+\D*\w*)(, )(\w+\s*\w*\b)/$3 $1/',-1,Name); 
run; 
/* -1: Tüm eşleşmelerin değiştirilmesini belirtir.*/ 

title 'Names of Baseball Players'; 
proc print data=work.BaseballPlayers; 
run; 
title;

/*
\w: Kelime karakterleriyle eşleşir. Bu karakterler şunlardır:
A-Z (büyük harfler)
a-z (küçük harfler)
0-9 (rakamlar)
Alt çizgi _


\w+ deseni, aşağıdaki gibi metinlerle eşleşir:
hello
world123
_underscore
A1B2C3
*/

/* Lesson 3: Defining and Processing Arrays*/
/* Defining and Referencing One-Dimensional Arrays*/


    
    

