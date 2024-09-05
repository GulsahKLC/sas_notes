cas casoto;
caslib _all_ assign;

FILENAME REFFILE FILESRVC FOLDERPATH='/Users/gulsah.kilic@gazi.edu.tr/My Folder/churn_analysis'  FILENAME='Churn_Predictions.csv';

PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV
	OUT=WORK.IMPORT;
	GETNAMES=YES;
RUN;

PROC CONTENTS DATA=WORK.IMPORT; RUN;



proc print data=work.import (obs=5);
run;

proc means data=work.import;
    var CreditScore Age Tenure Balance EstimatedSalary;
run;

proc freq data=work.import;
    tables Geography Gender HasCrCard IsActiveMember Exited;
run;

proc sgplot data=work.import;
    histogram Age;
    density Age;
run;

proc sgscatter data=work.import;
    matrix Age Balance CreditScore EstimatedSalary;
run;

data cleaned;
    set work.import;
    /* Feature engineering example */
    ExperienceScore = Age * Tenure;
    /* Handle missing values */
    if missing(Balance) then Balance = 0;
run;

/* region da bulunan ülkeler hangileri */
proc sql;
    select distinct Geography
    from work.import;
quit;

/* Geography
France
Germany
Spain
These are the countries found in the dataset.

Let's name these countries as:
FR
GR
SPN
*/

data casuser.churn;
    set work.import;
  if Geography = 'France' then Geo = 'FR';
    else if Geography = 'Germany' then Geo = 'GR';
    else if Geography = 'Spain' then Geo = 'SPN';
run;


/* If we don't want "France" to appear in the Geography column:
data your_new_dataset;
    set your_dataset;
    if Geography = 'France' then Geography = 'FR';
    else if Geography = 'Germany' then Geography = 'GR';
    else if Geography = 'Spain' then Geography = 'SPN';
run;
This code will now display FR, GR, and SPN in the Geography column. You can try it. */

/* Let's write the shortened values of the Gender column into a new column */

data casuser.churn;
    set casuser.churn;
    ShortGender = substr(Gender, 1, 1);
run;

/* Saving the dataset in the CAS library */

proc casutil sessref=casoto;
    load casdata="casuser.churn" incaslib="casuser" outcaslib="CASUSER" casout="churn" promote;
    save casdata="churn"  incaslib="CASUSER" outcaslib="CASUSER" casout="churn"  replace;
run;

/*
The CAS (Cloud Analytic Services) library in SAS is used for several important reasons, particularly in environments that require large-scale data management and advanced analytics. Here are some key reasons for using a CAS library:

1. Scalability: CAS libraries are designed to handle large volumes of data efficiently. They enable distributed processing, which allows for scaling up analytics tasks to accommodate large datasets.
2. Performance: By leveraging in-memory processing, CAS can significantly speed up data access and analytics operations compared to traditional disk-based systems. This leads to faster data processing and query execution.
3. Integration: CAS integrates seamlessly with other SAS components and tools, such as SAS Viya, which provides a unified environment for data analytics, machine learning, and reporting.
4. Flexibility: CAS libraries support a variety of data formats and sources, including SAS datasets, databases, and external data sources. This flexibility allows users to work with diverse data types and structures.
5. Security: CAS provides robust security features, including user authentication, access controls, and data encryption, ensuring that sensitive data is protected while being processed and analyzed.
6. Collaboration: CAS enables collaborative work by allowing multiple users to access and work with the same datasets simultaneously, which is beneficial for team-based analytics projects.
7. Data Management: CAS libraries facilitate efficient data management, including data loading, transformation, and storage. This helps in maintaining data integrity and optimizing data workflows.

Overall, using a CAS library helps in managing and analyzing large-scale data more effectively and efficiently, providing a strong foundation for advanced analytics and business intelligence.*/