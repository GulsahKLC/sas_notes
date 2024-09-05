/* macro facility */
/* macro değişken */
CAS MYSESSION;
CASLIB _ALL_ ASSIGN; /* Assigns the caslib _all_ to access the library */


/* proc print ile macro yazımı*/

%let type=Truck; /* Assigns the value "Truck" to the macro variable type */
%let hp=250; /* Assigns the value 250 to the macro variable hp */

proc print data=sashelp.cars;
   var Make Model MSRP Horsepower; /* Specifies variables to be printed */
   where Type="&type" and Horsepower>&hp; /* Filters the data */
run;


/* %put */
%let myVar=Hello World;

%put NOTE: This is a note message.;
%put &myVar;
/* --- output: Hello World */

/*
SAS oturumunda önemli bilgileri ve sistem durumlarını izlemek veya raporlamak için kullanılırlar. İşte bu makro değişkenlerin kullanılabileceği bazı yerler:

1. **SAS Program Günlüğü ve Raporlama**:
   - **SYSDAY**, **SYSDATE9**, ve **SYSTIME** gibi değişkenler, programın ne zaman çalıştırıldığını raporlamak için kullanılabilir.
 Örneğin, bir raporun başına oturumun başlatıldığı tarih ve saat bilgilerini eklemek.

   ```sas
   %put NOTE: Program started on &SYSDAY, &SYSDATE9 at &SYSTIME.;
   ```

2. **Sistem ve Kullanıcı Bilgileri**:
   - **SYSHOSTNAME**, **SYSUSERID**, **SYSSCP**, ve **SYSSCPL** gibi değişkenler, oturumun çalıştığı makine ve kullanıcı hakkında bilgi sağlar.
 Bu bilgiler, sistem yöneticileri veya güvenlik analizleri için yararlı olabilir.

   ```sas
   %put NOTE: SAS session is running on &SYSHOSTNAME by user &SYSUSERID.;
   %put NOTE: Operating system is &SYSSCP (&SYSSCPL).;
   ```

3. **Versiyon ve Bakım Bilgileri**:
   - **SYSVLONG** değişkeni, SAS sürümünü ve bakım sürümünü raporlamak için kullanılabilir. 
Bu, kodun belirli SAS sürümleriyle uyumluluğunu kontrol etmek için faydalı olabilir.

   ```sas
   %put NOTE: SAS version is &SYSVLONG.;
   ```

4. **Son Tablo ve Hata Durumları**:
   - **SYSLAST** değişkeni, son oluşturulan tablonun adını verir ve bu tablo üzerinde ek işlemler yapmak için kullanılabilir.

   ```sas
   %put NOTE: The last created table is &SYSLAST.;
   ```

   - **SYSERR** değişkeni, adımın başarıyla tamamlanıp tamamlanmadığını kontrol etmek için kullanılabilir. 
Örneğin, bir hata durumunda özel bir işlem yapmak isteyebilirsiniz.

   ```sas
   data test;
      set sashelp.cars;
   run;

   %if &SYSERR ne 0 %then %put ERROR: The data step did not complete successfully.;
   ```

Bu değişkenler, SAS oturumunun çeşitli yönlerini izlemek ve raporlamak için geniş bir yelpazede kullanılabilir
. Programın çalışmasını, hata durumlarını ve sistem bilgilerini dinamik olarak kontrol etmek için oldukça kullanışlıdırlar.
*/

/* updating macro  var */
%LET COUNTRY=US;

title '&COUNTRY Customers Ages 18 to 24'; 
proc print data=mc1.customers; 
    var Name Age Type; 
    where Country = '&COUNTRY'
        and Age between 18 and 24;
run; 
title; 


%LET COUNTRY=FR;
title "&country customers ages 18 to 24";
proc print data=mc1.customers;
var Name Age Type;
where Country ="&country"
and Age between 18 and 24;
run;
title;


%let Country=AU;
%let age1=25;
%let age2=34;
title "&Country Customers Ages &age1 to &age2";
proc print data=mc1.customers;
    var Name Age Type;
    where Country = "&Country" 
          and Age between &age1 and &age2;
run;
title;

/*  Using Macro Variable References with Delimiters*/ 
%let lib=mc1;
%let dsn=newhires;
%let var=Employee;

title "Listing of All Employees From &lib..&dsn";
proc print data=&lib..&dsn;
    var &var._Name &var._ID;
run;
title;

/* Storing and Processing Text*/
/* Working with Macro Programs*/
/* %UPCASE: Verileri karşılaştırmadan önce standart hale getirmek için kullanılabilir.
Örneğin, kullanıcı girişlerini büyük/küçük harf duyarlılığını ortadan kaldırmak için.

%SUBSTR: Bir metin dizesinin belirli bir kısmını almak için kullanılabilir.
Örneğin, bir tarih dizesinden yıl, ay veya gün bilgilerini almak.

%SCAN: Uzun bir metin dizesindeki belirli kelimeleri veya parçaları elde etmek için kullanılabilir.
Örneğin, dosya yollarını veya ad-soyad bilgilerini ayrıştırmak.

%SYSFUNC: SAS fonksiyonlarını makro ortamında kullanmak gerektiğinde kullanılır.
Örneğin, tarih ve zaman işlemleri, metin manipülasyonları gibi.

%SYSEVALF: Matematiksel hesaplamalar yapmak veya mantıksal ifadeleri değerlendirmek için kullanılır.
Örneğin, makro değişkenlerin değerlerine dayalı olarak koşullu işlemler yapmak.*/


%let text=class list;
title "%upcase(&text)";
proc print data=sashelp.class;
run;

/* expression */
-- %upcase(front);
-- %let df=front;
-- %upcase(&dt)
-- scan(sashelp.cars, 2, .)
-- %substr(CA123,1 ,2)

/* upcase methodu ve data set içerisinde macro kullanımı */
%let dt=front;
data cars_subset;
set sashelp.cars;
where upcase(DriveTrain)="FRONT";
run;

title "Front Wheel Drive Cars";
footnote "Listining from CARS_SUBSET Table";
proc print data=&syslast;
run;


%let season=2019;
%let nextseason=%sysevalf(&season+1);


/*
%sysevalf(10/3.5) 2.85714285714285
%sysevalf(10/3.5,ceil) 3
%sysevalf(10/3.5,floor) 2
%sysevalf(10/3.5,integer) 2
%sysevalf(1.2<3,boolean) 1
*/


%let location=%str(Buenos Aires, Argentina);
%let city=%scan(&location, 1,,);
%put &=city;

/* CITY=Buenos Aires, Argentina- output*/

%let location=%str(Buenos Aires, Argentina);
%let city=%scan(&location, 1, %str(,));
%put &=city;
/* CITY=Buenos Aires*/ 
/* Bu kod parçası, bir makro değişkenin değerini önce tamamen büyük harflere dönüştürmekte, 
sonra bu büyük harfli değeri proper case (her kelimenin ilk harfi büyük, geri kalanı küçük)
 hale getirmektedir.*/

%let fullname=AnTHoNY MilLeR;
%put &fullname;

%let fullname=%upcase(&fullname);
%put &fullname in proper case is %sysfunc(propcase(&fullname)).;

/* Using SQL to Create Macro Variables */

proc sql;
	select Model, MPG_Highway 
	from sashelp.cars 
	where MPG_Highway>50
	order by MPG_Highway;
quit;

proc sql;
select distinct Origin
into :originlist seperated by ", "
from sashelp.cars;
quit;

proc sql;
select mean(cost) format=dollar20.
into :avgcost trimmed
from mc1.storm_damage;
quit;

%put &=avgcost;

%macro filter_data_sql(table, column, value);
    proc sql;
        create table filtered_data as
        select *
        from &table
        where &column = "&value";
    quit;
%mend filter_data_sql;

%let my_table = sashelp.class;
%let my_column = sex;
%let my_value = M;

%filter_data_sql(&my_table, &my_column, &my_value);


/* Creating Macro Variables with the DATA Step */ 
%let make=Honda;

data &make;
	set sashelp.cars end=lastrow;
	where upcase(Make)="%upcase(&make)";
	retain HybridFlag;

	if Type="Hybrid" then
		HybridFlag=1;

	if lastrow then
		do;

			if HybridFlag=1 then
				do;
					%let foot=&make Offers Hybrid Cars;
				end;
			else
				do;
					%let foot=&make Does Not Have a Hybrid Car;
				end;
		end;
run;

/* */ 
%let dept=Administration;
data staff;
    keep Employee_ID Department Job_Title Salary;
    set mc1.newhires;
    where Department="&dept";
run;

title "New Staff: &dept Department";
proc print data=staff;
    sum salary;
run;
title;

/***/
%let dept=Sales;
data staff;
    keep Employee_ID Department Job_Title Salary;
    set mc1.newhires;
    where Department="&dept";
run;

title "New Staff: &dept Department";
proc print data=staff;
    sum salary;
run;
title;
/**/

%let dept=Sales;
data staff;
    keep Employee_ID Department Job_Title Salary;
    set mc1.newhires end=last;
    where Department="&dept";
    total+salary;
    if last=1 then 
        call symputx("avg",put(total/_n_,dollar9.));
run;

footnote "Average Salary: &avg";
title "New Staff: &dept Department";
proc print data=staff;
    sum salary;
run;
title;footnote;


%let code=LU;
title "Customers Residing in &code";
proc print data=mc1.customers;
    id ID;
    var Name Age_Group;
    where Country="&code";
run;
title;
data _null_;
    set mc1.country_codes;
    call symputx(CountryCode,CountryName);
run;

%let code=LU;
title "Customers Residing in &&&code";
proc print data=mc1.customers;
    id ID;
    var Name Age_Group;
    where Country="&code";
run;
title;%let code=LU;
title "Customers Residing in &&&code";
proc print data=mc1.customers;
    id ID;
    var Name Age_Group;
    where Country="&code";
run;
title;



%let code=ZA;
title "Customers Residing in &&&code";
proc print data=mc1.customers;
    id ID;
    var Name Age_Group;
    where Country="&code";
run;
title;



%let name=Alice;
%put "my name is &name";

/* iki sayısı tolayan bir makro */


%macro add(a,b);
%let result=%eval(&a + &b);   /*  %eval fonksiyonu, sayısal ifadeleri değerlendirir.*/
%put result of adding &a and &b is: &result;

%mend add;
%add (5, 7);

/* 
1'den 10'a kadar olan sayıları loga yazdırmak için bir makro döngüsü oluşturun.
*/

%macro print_numbers;
	%do i=1 %to 10;
		%put Number: &i;
		%end;
	%mend print_numbers;

	%print_numbers;

/* veri setindeki değişkenlerin tüm isimleri dinamik olarak makro değişkenlere atayın ve bu makro değişkenlerin değerlerini loga yazdırın */

%macro assign_names;
    /* PROC SQL kullanarak Name değişkenindeki tüm isimleri al */
    proc sql noprint;
        select distinct Name
        into :name1- separated by ' '
        from sashelp.class;
    quit;

    /* Her bir isim için bir makro değişkeni oluştur ve değerlerini loga yazdır */
    %let i = 1;
    %do %while (%scan(&name&i, 1, ' ') ne );

        %let name = %scan(&name&i, 1, ' ');
        %put Name&i: &name;

        %let i = %eval(&i + 1);
    %end;
%mend assign_names;

%assign_names;

/* conditional processing */

/*ıf-then statment enable conditional process data */

/* 
%ıf expression %then action-1
%else action-2
*/

/*
%ıf %then  %do 
%end
%else %IF %then %do 
%end 
%else %do 
%end
*/


DATA Europe USA Asia;
set sashelp.cars;
if Origin="Europe" then output Europe;
else if Origin="USA" then output USA;
else output Asia;
run;
/*
%let myVar = Hello, World;
%put &myVar;
Yukarıdaki örnekte, %let myVar = Hello, World; ifadesi myVar isimli bir makro değişken oluşturur ve ona "Hello, World" değerini atar. %put &myVar; ifadesi ise bu makro değişkenin değerini log'a yazar.*/
/*
SAS'ta %local makrosu, makro değişkenlerin yerel (local) kapsamda tanımlanmasını sağlar. Bu, bir makro içinde tanımlanan değişkenlerin sadece o makro içinde geçerli olmasını ve o makro tamamlandığında otomatik olarak bellekten silinmesini sağlar.

%local Makrosunun Kullanımı
Yerel Değişkenler Tanımlamak: %local makrosu, değişkenin sadece tanımlandığı makro içinde geçerli olmasını sağlar. Böylece, aynı isimdeki global değişkenlerle çakışma (conflict) önlenir.

Bellek Yönetimi: Makro tamamlandığında yerel değişkenler bellekten otomatik olarak silinir, bu da bellek yönetimini kolaylaştırır.

Örnek Kullanım

%macro example;
   %local localVar;
   %let localVar = This is a local variable;
   %put &localVar;
%mend example;

%example;
Yukarıdaki örnekte:

%macro example; ile example isimli bir makro tanımlanır.
%local localVar; ile localVar isimli bir yerel değişken tanımlanır.
%let localVar = This is a local variable; ifadesi ile localVar değişkenine değer atanır.
%put &localVar; ifadesi ile localVar değişkeninin değeri log'a yazdırılır.
Makro tamamlandığında, localVar değişkeni bellekten silinir.
Yerel ve Global Değişken Farkı
Yerel (local) ve global değişkenler arasındaki farkları anlamak önemlidir:

Global Değişkenler: %global makrosu ile tanımlanır ve tüm SAS oturumu boyunca geçerlidir. Başka makrolar içinde de kullanılabilir.


%global globalVar;
%let globalVar = This is a global variable;
Yerel Değişkenler: %local makrosu ile tanımlanır ve sadece tanımlandığı makro içinde geçerlidir. Makro tamamlandığında bellekten silinir.

%macro example;
   %local localVar;
   %let localVar = This is a local variable;
%mend example;
*/

