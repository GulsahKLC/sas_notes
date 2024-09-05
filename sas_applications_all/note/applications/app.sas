
/* SAS TEMEL BİLGİLER ÖZETLE AŞAĞIDA ŞU ŞEKİLDE ANLATILMAKTADIR VE ÖRNEKLER EGZERSİZLERLE KENDİ NOTLARIM VARDIR */ 
/* SAS® Programming 1: Essentials programındaki datasetler kullanılmıştır ve sashelp kütüphanesindeki class dataseti kullanılmıştır.*/
/*  
1. **PROC PRINT** listeler tüm sütunları ve satırları, OBS= veri kümesi seçeneği satırları sınırlar, VAR ifadesi sütunları sınırlar ve sıralar. 
2. **PROC MEANS** her sayısal sütun için özet istatistikler üretir, VAR ifadesi analiz edilecek değişkenleri sınırlar. 
3. **PROC UNIVARIATE** daha detaylı özet istatistikler sağlar, VAR ifadesi analiz edilecek değişkenleri sınırlar. 
4. **PROC FREQ** her değişken için frekans tablosu oluşturur, TABLES ifadesi analiz edilecek değişkenleri sınırlar. 
5. **WHERE ifadesi** satırları filtrelemek için kullanılır, ifadeler doğruysa satırlar okunur. 
6. **Karakter değerleri** tırnak işaretleri içinde, sayısal değerler tırnak işareti olmadan yazılır. 
7. **Birleşik koşullar** AND veya OR ile oluşturulabilir, NOT anahtarıyla operatörlerin mantığı tersine çevrilebilir. 
8. **SAS tarih sabiti** "ddmmmyyyy"d formatında kullanılır. 
9. **IN operatörü** belirli değerler kümesine göre filtreleme yapar. 
10. **Özel WHERE operatörleri** belirli koşullara göre satırları filtreler, örneğin IS MISSING, BETWEEN AND, LIKE ... vb. 
11. **Makro değişkenler** ile satırları filtreleme, %LET ifadesi ile tanımlanır ve & işareti ile referans verilir. 
12. **FORMAT ifadesi** sütunların görüntülenme biçimini değiştirmek için kullanılır, veri değerlerini değiştirmez. 
13. **PROC SORT** verileri sıralar ve kopyaları kaldırır, OUT= seçeneği çıkış tablosunu belirtir, BY ifadesi sıralama sütunlarını belirtir. 
14. **NODUPKEY seçeneği** yinelenen satırları kaldırır, DUPOUT= seçeneği kopyaların çıkarıldığı tabloyu oluşturur. 
*/ 
 

/* casuser'a yeni bir dataset tanımladık ve bunu sashelp kütüphanesinin class verisini kullanarak yapıyor. */ 
 
data casuser.class_;   /*casuser kütüphanesine yeni bir isimle kaydediyorum */ 
set sashelp.class; 
run; 

/* bastıralım */  
proc print data=casuser.class_; 
run; 
 
 
/* şimdi yeni bir hesaplama yapalım 
vki = kilo * (boy)^2 
 */  
 
data casuser.class_; 
	set sashelp.class; 
	vki=(((Height)/100)**2) * (Weight); 
 
	/* assigment statement calculate new column */ 
	output; 
 
	/* outout ile bunu veri setinde yazdır demek istenir */ 
run; 
 
/* proc means statement ile özet istatistiklerini (ortalama min max standart sapmalarını) değişkenlerin teker teker bakılır*/ 
proc means data=casuser.class_; 
run; 
 
/* data step, proc step */ 
 
proc print data=casuser.class_; 
var Age Height ; /* var ile değişkenleri seçeriz ve tabloda o değişkenler olsun diye özellikle belirtiriz. */ 
where age or height > 20; 
run; 
 
 
/* syntax error */ 
* misspelled keywords 
* unmatched quotation marks 
* invalid options 
* missing semicolon 
* warning or error message in the log 
 
 
/* accessing data */ 
/* biz verilere kütüphaneler sayesinde erişiriz. */ 
*2 çeşit sutün çeşiti vardır numerik ve karakter tipte 
Numerik sutunlar yanlızca numerik karakterleri saklar.  
* 0-9 arası digitleri, 
* ondalık sayıları  
* - işareti ve  
* bilimsel gösterim için e işaretini  
 
karakter sutunlar yanlızca  
* karakterleri alfabe harflerini  
* sayıları 
* özel karakterleri ve  
* boşlukları kapsar. 
 
* tarihler için: 
* 01 jan 1960 ve belirli bir tarih ancak 01 jan 1960 dan önceki tarihler negatif değer olarak saklanır. 
 
/*lenght */ 
* sayısal sutunlarda her zaman 8 bayt olarak saklanır 
* kat-rakter sutunlar 1 ile 32,767 bayt arasında ve bir bayt bir karakteri saklar. 
ülke kodu gibi bir sutun iki harkli kodları içerenlerin uzunluğu tahmin edersiniz ki 2 olabilir ve ülke isminin tamamını da içerebilir sınır yoktur.*/ 
 
/* diğer bir konu ise numerik ve karakter değişkenler için eğer bu alanlarda bir değer girilmedi ise ; 
* numerik alan direk "." ile temsil edilirken karakter tipteki değişken "" direk boşluk olarak görebilirsiniz. 
 
/* listeleme ve tablo niteliklerini gözlemleme */ 
tablo niteliklerini görüntülemek için proc contents adımı yazılır. proc contents bir içerik oluşturur tablonun tanımlayıcı istatistikleri hakkında */  
 
* syntaxt:  
* proc contents data = libname.new_table_name; 
* run;             
 
proc contents data=casuser.class_; 
run; 
 
/* accessing through libraries */ 
 
*proc contents data="location"/name and type of dataset"; 
*run; 
 
/* create a library (kütüohane yaratmak için)  
*libname libref engine "path"; 
 
* bir kütüphane siz silene kadar veya sas oturumunuzu sonlandırana kadar aktif kalır.  
* Work kütüphanesi geçici bir kütüphanedir başlagıçta bu otomatik olarak tanımlanır. 
* her sas oturumu sonunda work kütüphanesindeki veriler silinir.  
* aynı zamanda eğer veri setinizin yanında kütüphane ismi belirtmediyseniz burada work kütüphanesini kullanacağınız anlamına gelir. 
*/ 
 
libname out "/shared/home/gulsah.kilic@gazi.edu.tr/sasuser.viya/data/EPG1V2"; 
 
data casuser.class_ out.class_copy2;    /*casuser kütüphanesindeki class_ isimli datayı out kütüphanesine class_copy2 diye kaydet*/ 
set sashelp.class;   /*veriyi de sashelp kütüphanesindeki class verisinden al*/ 
run; 
 
/* veri seti okuma */ 
options validvarname=v7;  /*buradaki options seçeneği adlandırmanın zorunlu kılınması içindir. sütunlar için kurallara uymaya zorlar*/  
libname xlclass xlsx "/shared/home/gulsah.kilic@gazi.edu.tr/sasuser.viya/data/EPG1V2/data/class.xlsx"; 
 
proc contents data = xlclass.class; 
run; 
 
libname xlclass clear; 
 
/* diğer bir örnek */ 
*Complete the OPTIONS statement; 
options validvarname=v7; 
 
*Complete the LIBNAME statement; 
libname xlstorm xlsx "/shared/home/gulsah.kilic@gazi.edu.tr/sasuser.viya/data/EPG1V2/data/storm.xlsx"; 
 
*Complete the DATA= option to reference the STORM_SUMMARY worksheet; 
proc contents data=xlstorm.storm_summary; 
run; 
 
/* proc import */ 
/*proc import verileri okur harici bir veri kaynağının  
datafile ını alarak,  
DBMS =Filetypeına bakarak  
ve bunu bir sas veri kümesine yazar. 
 
/* şimdi virgülle ayrılmış bir csv dosyasını içeri aktaralım bu dosya unstructured yapıdadır.*/ 
/*storm damage dosyasını alalım */ 
 
proc import datafile="/shared/home/gulsah.kilic@gazi.edu.tr/sasuser.viya/data/EPG1V2/data/storm_damage.csv"  
		dbms=csv out=storm_damage_import replace; 
run; 
 
/*bu adımlarda datafile ile veri setinin yolunu 
dbms ile hangi tür bir dosya olduğunu belirleyip 
out ile dışarı çıkacağı kütüphaneyi 
replace ile de dosyada yapılan değişiklikleri kaydet 
diyerek csv doyasını içeri almış oluyoruz.*/ 
 
/* prosedürü tamamlama için birde bastırıp içeriğini görelim 
değişken isimleri, type ları formatı, uzunluklarını görebiliriz.*/ 
proc contents data=storm_damage_import; /* worke geçici olarak kaydediyoruz. storm_damage_import adı ile*/ 
run; 
 
/*Özetle; 
Burada aslında düzensiz, yapılandırılmamış yapıdaki veri setini alıp csv formatına çevirdik. 
Kütüphaneye atadık. replace diyerek yeni halinin bu olduğunu belirttik. 
out diyerek de kütüphanede storm damage import ismi ile kayıt olsun dedik  */ 
 
***********************************************************; 
*  LESSON 2, PRACTICE 1                                   *; 
*    a) Complete the PROC IMPORT step to read             *; 
*       EU_SPORT_TRADE.XLSX. Create a SAS table named     *; 
*       EU_SPORT_TRADE and replace the table              *; 
*       if it exists.                                     *; 
*    b) Modify the PROC CONTENTS code to display the      *; 
*       descriptor portion of the EU_SPORT_TRADE table.   *; 
*       Submit the program, and then view the output data *; 
*       and the results.                                  *; 
***********************************************************; 
 
proc import datafile="/shared/home/gulsah.kilic@gazi.edu.tr/sasuser.viya/data/EPG1V2/data/eu_sport_trade.xlsx"  
		dbms=xlsx out=EU_SPORT_TRADE; 
run; 
proc contents data=EU_SPORT_TRADE; /* yine workdedir çünkü normal formatı şudur. work.EU_SPORT_TRADE, değiştirmek için farklı kütüphane yazabilirsiniz ancak burda sas session'ım kapanınca kaydetmesini istemiyorum*/ 
run; 
 
/* Another practice import data from a csv file */ 
proc import datafile="/shared/home/gulsah.kilic@gazi.edu.tr/sasuser.viya/data/EPG1V2/data/np_traffic.csv" /* içeri al*/ 
		dbms=csv out=np_traffic replace; 
run; 
 
proc contents data=np_traffic; 
run; 
 
 
/* Verileri Belirli Bir Sınırlayıcıyla İçe Aktarma */ 
proc import datafile="FILEPATH/np_traffic.dat" 
            dbms=dlm 
            out=traffic2 
            replace; 
    guessingrows=3000; 
    delimiter="|"; 
run; 
 
/* explore data 
* sas çeşitli prosedürlere saiptir 
* print:listing all rows and columns od the data 
* means: calculate simple summary statistics 
* univariate: its shows summary statistics but more detailed  
* freq: create freq table */ 
 
/* ilk 10 satırı gözlemlemek için */ 
 
proc print data=pg1.STORM_SUMMARY (OBS=10); 
VAR Season Name Basin MaxWindMPH MinPressure StartDate EndDate; 
run; 
 
/* özet istatistikler için */ 
Proc means data=pg1.storm_summary; 
var MaxWindMPH MinPressure; 
run; 
 
/* istatistiksel olarak her bilgiyi veriyor. missing değerleri de ayrıca verir. */ 
Proc univariate data=pg1.storm_summary; 
var MaxWindMPH MinPressure; 
run; 
 
proc freq data=pg1.storm_summary; 
tables Basin Type Season; 
run; 
 
 
/* where statement */ 
/*proc ... ; 
where ... ; 
run ;*/ 
 
 
/* aynı zamanda ın ve not ın kullanarak da where statement ı yazabilirsiniz*/ 
 
proc print data=pg1.storm_summary; 
where StartDate="17JUL1980" ; 
run; 
 
 
/* create macro variable */ 
/* %let makro variable=value  */ 
/* & işareti SAS'ı tetikler saklanan metin dizesini arayın  
CarType makro değişkeninde ve onu Wagon ile değiştirin kodu çalıştırmadan önce */ 
 
/* sashelp.aır sashelp kütüphanesi, dataseti için bir macro variable yazalım. */ 
proc print data=sashelp.class; 
run; 
 
/* sadece cinsiyeti F olanları alalım*/ 
%let cinsiyet=F; 
 
proc print data =sashelp.class; 
where sex="&cinsiyet"; 
var Name Sex Age Height	Weight; 
run; 
 
/* 2. yol*/ 
%let sex="F"; 
 
proc print data =sashelp.class; 
where sex="F"; 
var Name Sex Age Height	Weight; 
run; 
 
/* makro değişkenini kullanarak Satırları filtrelemek */ 
 
/* proc steps and proc means*/  
 
%let yas=10; 
%let boy =156; 
/* yukarıyı böyle tanımladık şimdi 10 yazan yere &yas gelecek ve height değişkenleri de &boy olarak değişecek.*/ 
 
 
proc print data=sashelp.class; 
where Height>="&boy" and Age > "&yas"; 
var  Name Sex Age Height Weight; 
run; 
 
proc means data=sashelp.class; 
where Height>="&boy" and Age >"&yas"; 
var  Name Sex Age Height Weight; 
run; 
 
 
/* A PRACTICE */ 
 
/* np.traffic datasını oku. 
bu veri seti içinden değişkenleri seç satırlar içinde "" geçen kelimeleri yakalasın.*/ 
 
proc import datafile="/shared/home/gulsah.kilic@gazi.edu.tr/sasuser.viya/data/EPG1V2/data/np_traffic.csv" 
dbms = "csv" out=trafik replace; 
run; 
 
proc print data=trafik; 
var  ParkType Region ReportingDate TrafficCount TrafficCounter; 
where TrafficCounter like '%Townes%'; 
run; 
 
 
***********************************************************; 
*  Formatting Data Values in Results                      *; 
***********************************************************; 
*  Syntax and Example                                     *; 
*                                                         *; 
*    FORMAT col-name(s) format;                           *; 
*                                                         *; 
*    <$>format-name<w>.<d>                                *; 
*                                                         *; 
*    Common formats:                                      *; 
*       dollar10.2 -> $12,345.67                          *; 
*       dollar10.  -> $12,346                             *; 
*       comma8.1   -> 9,876.5                             *; 
*       date7.     -> 01JAN17                             *; 
*       date9.     -> 01JAN2017                           *; 
*       mmddyy10.  -> 12/31/2017                          *; 
*       ddmmyy8.   -> 31/12/17                            *; 
***********************************************************; 
*Write a PROC PRINT step and FORMAT statement; 
proc print data=pg1.storm_damage; 
format Date mmddyyy10. cost dollar16.; 
run; 
 
proc print data=pg1.class_birthdate; 
	format Height Weight 3. Birthdate date9.; 
run;	 
 
***********************************************************; 
*  Identifying and Removing Duplicate Values              *; 
***********************************************************; 
*  Syntax and Example                                     *; 
*                                                         *; 
*    Remove duplicate rows:                               *; 
*    PROC SORT DATA=input-table <OUT=output-table>        *; 
*        NODUPKEY <DUPOUT=output-table>;                  *; 
*        BY _ALL_;                                        *; 
*    RUN;                                                 *; 
*                                                         *; 
*    Remove duplicate key values:                         *; 
*    PROC SORT DATA=input-table <OUT=output-table>        *; 
*        NODUPKEY <DUPOUT=output-table>;                  *; 
*        BY <DESCENDING> col-name (s);                    *; 
*    RUN;                                                 *; 
***********************************************************; 
 
***********************************************************; 
*  Demo                                                   *; 
*    1) Modify the first PROC SORT step to sort by all    *; 
*       columns and remove any duplicate rows. Write the  *; 
*       removed rows to a table named STORM_DUPS.         *; 
*       Highlight the step and run the selected code.     *; 
*       Confirm that there are 50,575 rows in STORM_CLEAN *; 
*       and 7 rows in STORM_DUPS.                         *; 
*    2) Run the second PROC SORT step and confirm that    *; 
*       the first row for each storm represents           *; 
*       the minimum value of Pressure.                    *; 
*       Note: Because storm names can be reused in        *; 
*             multiple years and basins, unique storms    *; 
*             are grouped by sorting by Season, Basin,    *; 
*             and Name.                                   *;   
*    3) Modify the third PROC SORT step to sort the       *; 
*       MIN_PRESSURE table and keep the first row for     *; 
*       each storm. You do not need to keep the removed   *; 
*       duplicates. Highlight the step and run the        *; 
*       selected code.                                    *; 
***********************************************************; 
 
*Step 1; 
proc sort data=pg1.storm_detail out=storm_clean nodupkey dupout=storm_dump; 
	by _all_; 
run; 
 
/* dupout=storm_dump ile duplica edenleri storm_dump adlı yeni bir tabloya kaydediyor.*/ 
 
 
 
/* minimum basıncı yakalayan bir sorgudur*/ 
 
 
*Step 2; 
proc sort data=pg1.storm_detail out=min_pressure; 
	where Pressure is not missing and Name is not missing; 
	by descending Season Basin Name Pressure; 
run; 
 
*Step 3; 
proc sort data=min_pressure; 
	by  descending Season Basin Name; 
run; 
 
/* PROC SORT */ 
 
proc sort data=PG1.NP_SUMMARY out=np_sort; 
 by Reg descending DayVisits; 
where type="NP"; 
run; 
 
/*Write a PROC SORT step that creates two tables (park_clean and park_dups), and removes the duplicate rows. 
Submit the program and view the output data.*/  
PROC SORT DATA=PG1.NP_LARGEPARKS  /*pg1 kütüphanesinden np_largeparks verisini getir */ 
          OUT=PARK_CLEAN     /* duplike olmayanları park_clean adı ile kaydet*/ 
          DUPOUT=park_dups  /* duplike olanları park_dumps adı ile kaydet*/ 
		  NODUPKEY;         /*  PROC SORT with NODUPKEY creates an output data set that has no duplicate observations. 
                                                                  Each of these observations is unique*/ 
	BY _ALL_; 
RUN; 
 
 
/*  Creating a Lookup Table from a Detailed Table */ 
 
proc sort data=pg1.eu_occ                   /* OC SORT step to sort pg1.eu_occ*/ 
		 	out=countrylist          		/* d create an output table named countrylist.*/ 
			nodupkey;      					/* Remove duplicate key values.*/  
by Geo descending Country;    		/* Sort by Geo and then Country.*/ 
run; 
 
olution: 
proc sort data=pg1.eu_occ(keep=geo country) out=countryList  /* keep değişkeni ile istediğimiz değişkenleri görmek için tut veri setinde diğerlerini çıkar diyebiliriz */ 
          nodupkey; 
    by Geo Country; 
run; 
 
