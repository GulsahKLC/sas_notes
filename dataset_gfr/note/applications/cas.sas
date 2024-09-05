/* Accelerating SAS® Code on the SAS® Viya® Platform*/
/*
Lesson 1: SAS Viya Platform Overview
It's the story of starting with real questions, and then using your data to make decisions based on understandable, actionable insights.
Questions like: Is this drug safe? How do our customers feel? What is the financial risk and more? The process takes us through three
primary phases:
manage data
develop models
and deploy insights.

1.1  SAS Viya Platform Overview 1-5 Access Access data, regardless of size or complexity Prepare Transform raw data,
including AI powered suggestions Govern Build trust in data, understand lineage and gain transparency
First, the Manage Data phase provides an agile approach to data access, preparation, and governance.
It enables greater reliability, speed and collaboration in your efforts to operationalize data and analytic workflows. 
Build Build models with AI techniques to solve real-world problems Optimize Embed models into operational systems and monitor
them Validate Ensure model’s input and output variables align with business' expectations Second, in the Develop Models phase,
data scientists use a combination of techniques to understand the data and build predictive models.
They use machine learning, natural language processing, forecasting, optimization, and other techniques to answer real-world questions.

Automate Automate manual tasks for feature engineering and model tuning Monitor Monitor model's performance over time, 
leveraging built-in alerts Retrain Revise, retrain or replace models to ensure optimal performance And third,
the Deploy Insights phase focuses on getting AI models through validation, testing, and deployment as quickly as possible, 
while ensuring quality results. It also focuses on ongoing monitoring, retraining, and governance of models to ensure peak 
performance and that decisions are transparent.  Your role in the analytics life cycle is unique. 
You might be focused on a particular step, such as manage data, … … or you might oversee the entire process.  
Regardless of your role, the unified collection of applications and programming languages on the SAS Viya platform enables you to use the subset
of tools that you need for your job and then seamlessly share and collaborate with others.  

Lesson 2: Running SAS Code on the SAS Compute Server
-- Running SAS Code on the Compute Server
*/
*********************************************;
* Demo: Running a SAS Program in SAS Studio *;
*********************************************;

%let homedir=%sysget(HOME);
%let path=&homedir/Courses/PGVY01;

libname pvbase "&path/data";

data profit;
    set pvbase.orders;
    Profit=RetailPrice-(Cost*Quantity);
    format Profit dollar8.;
run;

ods excel file="&path/output/customer_report.xlsx";
title "Profit per Order";
proc means data=profit sum mean;
    var Profit;
    class Continent;
run;

proc sgplot data=profit;
    hbar Continent / response=Profit stat=sum 
                     categoryorder=respdesc;
run;
ods excel close;

/*
Lesson 3: SAS Cloud Analytic Services (CAS) Overview
-- CAS Fundamentals
-- Understanding Caslibs
*/
caslib _all_ assign;  /* all existing caslib */

libname casuser cas caslibs=casuser;

proc means data=casuser.orders;
run;
/*
Lesson 4: Managing Data in SAS Cloud Analytic Services
-- Loading Data to In-Memory Tables
-- Accessing DBMS Data
-- Saving and Dropping In-Memory Tables
*/
/* Binds all CAS librefs and default CASLIBs to your SAS client */
caslib _all_ assign;

/* Two ways to save a CAS table as a SAS7BDAT */
proc cas;
   table.save / caslib='sas7bdat'
   table={name='baseball', caslib='casuser'},
   name='baseball.sas7bdat'
   replace=True;
quit;

/*How to save a CAS table as a compress sas7bdat */
proc casutil;
   save casdata='baseball' incaslib='casuser'
   casout='baseball.sas7bdat' outcaslib='sas7bdat'
   exportoptions=(filetype='basesas', compress='yes' debug='dmsglvli') 
   replace;
quit;


/* Binds all CAS librefs and default CASLIBs to your SAS client */
caslib _all_ assign;

/* Two ways to save a CAS table to SASHDAT */
proc cas;
   table.save / caslib='sashdat'
   table={name='baseball', caslib='casuser'},
   name='baseball.sashdat'
   replace=True;
quit;

proc casutil;
   save casdata='baseball' incaslib='casuser'
   casout='baseball.sashdat' outcaslib='sashdat' replace;
quit;

/* load an excel file to a table*/
proc cas;
    table.addCaslib / 
        name="pvcas" path="&path/data";
    table.loadTable / 
        path="customers.xlsx" caslib="pvcas",
        casout={caslib="casuser", name="custFrance", 
                replace="true"},
	    where="Country='France'";
    table.tableDetails / 
        caslib="casuser", name="custFrance";
quit;


