/*1. SASHDAT Dosyaları
SASHDAT: CAS'ta tabloyu disk üzerinde saklamak için kullanılan dosya formatıdır. 
Tablo yapısını korur ve hızlı bir şekilde belleğe geri yüklenebilir.*/

/*2. PROC CASUTIL Kullanımı

SAVE İfadesi: Bellek içi tabloları sunucunun dosya sistemine SASHDAT formatında kaydeder.*/
proc casutil;
    promote casdata='table_name' incaslib='casuser' outcaslib='casuser';
  quit;


  proc casutil;
    save casdata='table_name' incaslib='casuser' outcaslib='casuser' replace;
  quit;

 /*DROPTABLE İfadesi: Bellek içi tabloları siler.*/
  proc casutil;
    droptable casdata='table_name' incaslib='casuser' quiet;
  quit;

  
  