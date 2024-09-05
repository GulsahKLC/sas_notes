/* Define the path to your data */
%let path=/shared/home/gulsah.kilic@gazi.edu.tr/sasuser.viya/data/EPG3M6;
libname  pg3 "&path/data";
%include "&path/data/pg3m6.sas";

/*
Her programa başlarken yazılmalı
cas session_name;
veya 
cas;

İki farklı session açarak iki farklı session üzerinden devam edilebilir ve sessionlar karşılaştırabilir.

caslib all assign;
tüm kod boyu casliblerin hepsine erişmek için kullanılır, burada spesifik libraryler de kullanılabilir.
*/

cas mysession;
caslib _all_ assign;
cas mysession listsessopts; *listing the sessions options;
options compress=yes; *for compress the files;

/* Promote a session scope table to global scope*/
proc casutil;
    promote casdata   = 'cars'  incaslib  = 'public'  outcaslib = 'public';
run;