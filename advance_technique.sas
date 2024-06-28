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
character:
- LENGHT
- FIND
- CAT 
-CATS 
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



