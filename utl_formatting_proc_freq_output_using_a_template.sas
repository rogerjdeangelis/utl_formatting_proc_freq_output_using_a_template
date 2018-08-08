Formatting proc freq output using a template

github
https://tinyurl.com/y6vjh5m7
https://github.com/rogerjdeangelis/utl_formatting_proc_freq_output_using_a_template

see
https://tinyurl.com/ybuhryf6
https://communities.sas.com/t5/Base-SAS-Programming/Format-results-of-Pro-Freg/m-p/485004


INPUT
=====

 The frequency variable is equivalent to repeating a Sex onservation
 1,2345,678.

 Also note there are 10 Males and 10 females

 WORK.CLASS total obs=20

   SEX    FREQUENCY

    M     12345678
    F     12345678
    F     12345678
    F     12345678
    M     12345678

 EXAMPLE OUTPUT
 --------------

  FREQUENCIES IN MILLIONS

                                      Cumulative     Cumulative
  SEX     Frequency       Percent      Frequency       Percent
  -------------------------------------------------------------
  F          1,234.57       50.00        1,234.57       50.00
  M          1,234.57       50.00        2,469.14      100.00


PROCESS
=======

proc format;
picture million (round fuzz=0)
0 -high = '009,999.00' (prefix='' mult=0.001);
run;

proc template;
   edit Base.Freq.OneWayList;
     edit frequency;
       format=million.;
     end;
     edit percent;
       format=8.2;
     end;
     edit cumfrequency;
       format=million.;
     end;
   end;
run;quit;

proc freq data=class;
title "Frequencies in Millions";
tables sex / list;
weight wgt;
run;quit;


OUTPUT
======

  FREQUENCIES IN MILLIONS

                                      Cumulative     Cumulative
  SEX     Frequency       Percent      Frequency       Percent
  -------------------------------------------------------------
  F          1,234.57       50.00        1,234.57       50.00
  M          1,234.57       50.00        2,469.14      100.00

*                _               _       _
 _ __ ___   __ _| | _____     __| | __ _| |_ __ _
| '_ ` _ \ / _` | |/ / _ \   / _` |/ _` | __/ _` |
| | | | | | (_| |   <  __/  | (_| | (_| | || (_| |
|_| |_| |_|\__,_|_|\_\___|   \__,_|\__,_|\__\__,_|

;
data class;
  set sashelp.class(keep=sex) end=dne;
  wgt=12345678;
  output;
  if dne then do;sex='F';output;end;
run;quit;

*          _       _   _
 ___  ___ | |_   _| |_(_) ___  _ __
/ __|/ _ \| | | | | __| |/ _ \| '_ \
\__ \ (_) | | |_| | |_| | (_) | | | |
|___/\___/|_|\__,_|\__|_|\___/|_| |_|

;
see process


