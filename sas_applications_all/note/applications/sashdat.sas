/*1. SASHDAT Files
SASHDAT: This is the file format used to store tables on disk in CAS. It preserves the table structure and can be quickly reloaded into memory.*/

/*2. PROC CASUTIL Usage
SAVE Statement: Saves in-memory tables to the server's file system in SASHDAT format.*/

proc casutil;
    promote casdata='table_name' incaslib='casuser' outcaslib='casuser';
  quit;

  proc casutil;
    save casdata='table_name' incaslib='casuser' outcaslib='casuser' replace;
  quit;

  proc casutil;
    droptable casdata='table_name' incaslib='casuser' quiet;
  quit;
/*DROPTABLE Statement: Deletes in-memory tables.*/

  
  