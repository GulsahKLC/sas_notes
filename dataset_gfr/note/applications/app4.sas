/* Using a Subquery in the HAVING Clause */
/* division avg(PopEstimate1) >Total avg(PopEstimate1) */

***********************************;
*Explore the STATEPOPULATION table*;
***********************************;
proc sql;
    select Name, PopEstimate1
        from sq.statepopulation
        where PopEstimate1 = 6278420
        order by PopEstimate1 desc;
    quit;
    
    
    ***********************************;
    *Future Subquery                  *;
    ***********************************;
    proc sql;
    select avg(PopEstimate1)
        from sq.statepopulation;
    quit;
    
    
    ***********************************;
    *Outer Query                      *;
    ***********************************;
    proc sql;
    select Name, PopEstimate1
        from sq.statepopulation
        where PopEstimate1 > /*Add Subquery Value*/
     (select avg(Population_2010) from sashelp.us_data)
        order by PopEstimate1 desc;
    quit;
    
    proc sql;
    select Name 
    from sq.statepopulation
    where Division ='3';
    quit;
    
    proc sql;
    create table division3 as 
    select * from sq.customer
    where State in ("IL", "ın","MI", "OH", "WI");
    quit;
    
    /* outer query */
    Proc sql;
    create table division4 as 
    select *
    from sq.customer
    where State in ("IL", "IN","MI", "OH", "WI");
    quit;
    
    /* Using Correlated Subqueries*/
    /*
    SELECT 
    FROM
    WHERE
    GROUP BY
    HAVING
    ORDER BY;
    */
    
    proc sql;
    select count(*) as TotalCustomer
    from sq.customer as c 
    where '1' = (select Division from sq.statepopulation as a ehre a.Name =c.State);
    quit;
    
    
    /* Subquery That Returns Multiple Values */
    
    Proc sql;
    create table division5 as 
    select *
    from sq.customer
    where State in (select Name
                    from sq.statepopulation where Division ='3');
    quit;
    
    
    proc sql inobs=10;
    select FirstName, MiddleName, LastName, State
        from sq.customer;
    select Name, EstimateBase
        from sq.statepopulation;
    quit;
    
    
    proc sql;
    create table totalcustomer as
    select State, count(*)  as TotalCustomer
        from sq.customer
        group by State
        order by TotalCustomer desc;
    quit;
    
    proc sql;
    select c.State, 
           c.TotalCustomer, 
           s.EstimateBase, 
           c.TotalCustomer/s.EstimateBase as PctCustomer format=percent7.3
        from totalcustomer as c inner join 
             sq.statepopulation as s
        on c.State = s.Name
        order by PctCustomer;
    quit;
    
    /* In-line view'lara tablo isimleri atanmaz ve başka sorgularda veya 
    SAS prosedürlerinde tabloymuş gibi referans gösterilemezler. 
    Sadece tanımlandıkları sorguda kullanılabilirler. */
    /*#### Alıştırma 1: her çalışanın maaşını ve adını listeleyelim.*/
    proc sql;
    select EmployeeName, Salary
    from sq.employee;
    quit;
    
    
    /*1. İlk tablo olan "Customer" tablosunda herhangi bir müşterinin ortalama kredi skoru ne kadar?*/
    
    proc sql;
    create table ortalama_kredi_skor as 
    select CreditScore,FirstName,	MiddleName,	LastName,	Gender  from sq.customer (obs=10)
    where CreditScore> (select avg(CreditScore) from sq.customer );
    quit;
    
    proc print data=sq.employee (obs=5);
    run;
    proc contents data=sq.employee;
    run;
    
    proc sql;
    select EmployeeID, EmployeeName, Department, Salary
    from sq.employee
    where Salary between 20000 and	50000
    order by salary desc ;
    quit;
    
    /* data step yaz enddate ve startdate in tipini değiştir startdate ve enddate 
    numerik değişkenlerdi bunların tipini karaktere çevirdik */
    data employee;
    set sq.employee;
    startdate1= put(StartDate, $6.);
    enddate1 =put(EndDate, $6.);
    run;
    /* enddate içinde 4 geçenleri getir çünkü yukarıdaki değişikliği yapmamızın sebebi like komutundan sonra "içerisi karakter tipinde olmalı" uyarısı idi. */
    proc sql;
    select *
    from employee 
    where enddate1 like "%4%";
    quit;
    
    
    /* Example 2: Converting Character Values to Numeric Values Using the INPUT 
    Function with CAS
    
    data casuser.testinn;
       set casuser.testin;
       fmtsale=input(sale, comma9.);
       put fmtsale=;
    run;
    
    */
    
    
    /* Example 3: Using PUT and INPUT Functions
    In this example, PUT returns a numeric value as a character string. The value 122591 is assigned to the CHARDATE variable. INPUT returns the value of the character string as a SAS date value by using a SAS date informat. The value 11681 is stored in the SASDATE variable.
       numdate=122591;
       chardate=put(numdate, z6.);
       sasdate=input(chardate, mmddyy6.);
    */
    
    proc print employee (obs=5);
    run;
    
    proc sql;
    select EmployeeName "Employee", salary "Monthly Salary" 
    from employee
    where salary between 25000 and 50000 
    and EmployeeID in (20, 50);
    quit;
    
    /*
    proc sql;
    select EmployeeID, EmployeeName, Department, Salary,round(Salary*1.15, 0) as new_salary
    from sq.employee;
    quit;
    */
    proc print data=sq.bank (obs=5);
    title "bank";
    run;
    
    proc print data=sq.customer (obs=5);
    title "customer";
    run;
    
    proc print data=sq.employee (obs=5);
    title "employee";
    run;
    proc print data=sq.transaction (obs=5);
    title "transaction";
    run;
    
    proc print data=sq.uspopulation (obs=5);
    title "uspopulation";
    run;
    
    
    
    /* customer bank transaction arasında BankID den bir bağ var
    TransactionID	DateTime	"BankID"	MerchantID	AccountID	Amount	Phone --- transaction 
    FirstName MiddleName LastName	Gender	DOB	Employed	Race	Married	StreetNumber	StreetName	City
    State Zip HomePhone	CellPhone	StateID	UserID	CustomerID	"BankID"	Income	AccountID	CreditScore----------------------customer
    */
    proc sql outobs=5;
    select t.transactionID, t.Amount, t.BankID, c.Gender, c.City, c.UserID,
     c.CustomerID, c.Income
    from sq.customer as c 
    inner join sq.transaction as t on  t.BankID=c.BankID;
    quit;
    
    
    
    /*
    
    Hangi müşteriler hem e-posta hem de telefon isteklerine yanıt verdi?
     Hangi müşteriler telefona ve/veya e-postaya yanıt verdi?
     Hangi müşteriler yalnızca e-posta isteğine yanıt verdi?
     Ve tüm müşteri yanıtlarının tam bir listesi var mı?Hangi müşteriler hem e-posta hem de telefon isteklerine yanıt verdi? Hangi müşteriler telefona ve/veya e-postaya yanıt verdi? Hangi müşteriler yalnızca e-posta isteğine yanıt verdi?
     Ve tüm müşteri yanıtlarının tam bir listesi var mı?
    */
    
    /* set operators 
    ıntersect:kesişimi
    except:dışındakiler, 1. sorguda olan 2. sorguda olmayan 
    unıon:birleşimi 2 query nin sonucudur.*outer unıon: hiçbir kesişme yok. 
    INTERSECT operatörü, ikinci sorguda da ortaya çıkan ilk sorgudaki satırları döndürür.
    Başka bir deyişle, her iki sorguda da ortak olan benzersiz satırlar. Bu Venn şemasının
     örtüşen alanıdır.
    
    EXCEPT operatörü, ikinci sorgudan değil, ilk sorgudan kaynaklanan satırları döndürür.
    Başka bir deyişle, yalnızca ilk sorgudaki benzersiz satırlar. Bu, Venn şemasının en 
    üstteki dairesidir.
    
    UNION operatörü iki sorgu sonucunu birleştirir. Her iki sorgudan kaynaklanan tüm
    benzersiz satırları üretir. Yani, birinci tabloda, ikinci tabloda veya her ikisinde 
    de meydana gelirse bir satır döndürür. Bunlar Venn şemasının üst ve alt daireleridir. 
    UNION yinelenen satırları döndürmez. Bir satır birden fazla kez meydana gelirse, 
    yalnızca bir olay döndürülür.
    
    OUTER UNION operatörü her iki sorgunun sonuçlarını birleştirir. Tüm satırları ve
    sütunları içerir ve hiçbir şey çakışmaz. Bu nedenle diyagramda iki ayrı daire 
    gösterilmektedir.
    SELECT query
            UNION | EXCEPT | INTERSECT | OUTER UNION <ALL> <CORR>
    SELECT query...;
    
    
    CORR anahtar sözcüğü, her iki tabloda da aynı ada sahip sütunları ( MüşteriKimliği) hizalar ve her iki tabloda da bulunmayan sütunları kaldırır. 
    */
    /* NOREMERGE seçeneği özet istatistiklerin yeniden birleştirilmesini devre dışı bırakır.*/
    
    proc sql ;
    select Region, sum(PopEstimate1) as TotalRegion format=comma14.
    from sq.statepopulation;
    quit;
    
    
    /* sql macro variable */
    
    macrolar %let diye başlar.
    %let macro-değişkenin = değeri;
    
    %let State=GA;
    %let CreditMin = 650;
    
    /* normalde sql query i bööyle yazarız ama */
    proc sql;
    create table CustomerGA as 
    select CustomerID, Employed, Race,Married, State, CreditScore
    from sq.customer
    where State="GA" and CreditScore>650;
    quit;
     /* macro dilinde yazımı */
    proc sql;
        create table Customer&State as 
            select CustomerID, Employed, Race, Married, 
            State, CreditScore 
            from sq.customer
            where State="&State" and 
            CreditScore > &CreditMin;
    quit;
    
    proc sql ;
    select max(EstYear3Pop) as Population format=10., count(distinct CountryCode) as TotalCtry
        into :MaxPop trimmed, :TotalCtry trimmed
        from sq.globalfull;
    quit;
    %put &=MaxPop &=TotalCtry;
    
    
    title "Country with the Largest 3 Year Estimated Population";
    title2 "Out of &TotalCtry Countries";
    proc sql;
    select distinct CountryCode, ShortName, Region, 
           EstYear3Pop format=comma16.
        from sq.globalfull
        where EstYear3Pop = &MaxPop;
    quit;
    title;
    
    /*
    select col-name
    ınto :macvar Seperated by "delimiter"
    from table;
    */
    %let Division=3;
    
    proc sql;
    select Name
    into :StateList SEPARATED BY ","
    from sq.statepopulation
    where Division = "&Division";
    quit;
    %put &=Division ;
    %put &=StateList;
    
    
    %let Division=3;
    proc sql;
    select quote(strip(Name))
    into :StateList SEPARATED BY ","
    from sq.statepopulation
    where Division = "&Division";
    quit;
    %put &=Division ;
    %put &=StateList;
    
    options symbolgen;
    proc sql;
    create table division&Division as 
    select *
        from sq.customer
        where State in (&StateList);
    quit;
    options nosymbolgen;
    
    