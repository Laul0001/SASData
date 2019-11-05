* Bhanu Laul  20052652;
*Q1. A);
data Q1;
informat MyBirthDate date7.;
format MyBirthDate date7.;
label MyBirthDate = 'Birthday';
input MyBirthDate;
datalines;

1jun99
;
RUN;

*Q1.B);

data Q1;
informat MyBirthDate date7.;
input MyBirthDate;
CurrDate = today();
NumYears = (intck('day', MyBirthDate , CurrDate, 'c'))/365.25;
format currdate date7.;
format mybirthdate date7.;
format NumYears 5.2;
datalines;
1jun99
;
run;


*Q3. C);

data Q1;
informat MyBirthDate date7.;
input MyBirthDate;
CurrDate = today();
NumYears = (intck('day', MyBirthDate , CurrDate, 'c'))/365.25;
format currdate date7.;
format mybirthdate date7.;
format NumYears 5.1;
PUT 'I was born on ' MyBirthDate date7. '.' " I am " NumYears ' years old.';
*due to confusion regarding what date format to use, i have put in both the outputs;
put 'I was born on' MyBirthDate worddate12. '.' " I am " NumYears ' years old.';
datalines;
1jun99
;
run;

*Q2);
data Q2 Errors;
infile '/folders/myfolders/GradStudentsWebPage.html' dlm = '"<' ;
input @'mailto:' Email: $25. @'>' Name: $37. /@'program:</strong>' Program: $10. @'supervisor(s):</strong>' Supervisor: $45. @'area:</strong>' Area: $35.;
array Emaillis $email;
do i = 1 to dim(emaillis);
if (FindC(emaillis[i], '@') = 0) then output Errors;
if (FindC(emaillis[i], '@') >0) then output Q2;
END;

PROC PRINT DATA = q2;
title 'GradStudents';
var Email:Name:Program:Supervisor:Area;
run;

proc print data = errors;
title 'Errors';
var Email:Name:Program:Supervisor:Area;
run;

*Q3);
*Q3. A);
data q3;
y = 1- probbnml (.2, 20, 0);
run;
proc print;
run;

*Q3. 1B);

DATA q3_1b;
do Chips= 0 to 20;
	ProbChips = 1- CDF ('BINOM', CHIPS, 0.2, 20 );
	output;
end;
run;

*Q3. 2A);
DATA Q3_2A;
Y = 1- CDF('POISSON', 25, 20);
RUN;

*Q3. 2B);
data Q3_2B;
X = QUANTILE('poisson', .025, 20);
RUN;

*Q4);
*Q4. A &B);
DATA Q4;
INFILE '/folders/myfolders/weather.txt' ;
INPUT CODE $1 @2 NAME $2-22  @23 Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec; 
avg_temp = mean(of Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec);
format avg_temp 6.3;
label avg_temp = 'Average annual temperature'
;
RUN;

*Q4. C);

DATA Q4a  ;
INFILE '/folders/myfolders/weather.txt' ;
INPUT CODE $1 @2 NAME $2-22 @23 Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec;
format _numeric_ 6.3;
ARRAY MonNam [12] Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec;
do i = 1 to 12;
	 MonNam [i] = (( MonNam [i]- 32)*5)/9;
end;
drop i;
run;

*Q4. D);
LIBNAME formats '/folders/myfolders';
proc format lib= formats.code_ee;
	value $codeee
	'N' = 'North'
	'W'= 'West'
	'O' = 'Ontario'
	'P' = 'Prairie'
	'Q' = 'Quebec'
	'A' = 'Atlantic'	
;
run;
DATA Q4  ;
INFILE '/folders/myfolders/weather.txt' ;
INPUT CODE $1.  NAME $2-22 @23 Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec;
length code $15.;
run;
proc print data = Q4;
format  code $codeee.;
run;

*Q4. E);

DATA Q4a  ;
INFILE '/folders/myfolders/weather.txt' ;
INPUT CODE $1 @2 NAME $2-22 @23 Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec ;
format _numeric_ 6.3;
ARRAY MonNam [12] Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec;
do i = 1 to 12;
	 MonNam [i] = (( MonNam [i]- 32)*5)/9;
end;
drop i;
run;

proc format ;
	value TempFor
	-30 - -10  = 'Brutally Cold'
	-10 -  0 = 'Cold'
	0 - 10 = 'Cool'
	10 - 20 = 'Mild'
	20 - 30 = 'Warm'
;
run;
options fmtsearch= (formats.code_ee);
proc print data = Q4a;
FORMAT CODE $codeee. Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec TempFor. ;
run;

*Q4. F);

DATA Q4;
INFILE '/folders/myfolders/weather.txt' ;
INPUT CODE $1 @2 NAME $2-22  @23 Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec; 
avg_temp = mean(of Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec);
format _numeric_ 6.3;
label avg_temp = 'Average annual temperature'
;
ARRAY MonNam [13] Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec avg_temp;
do i = 1 to 13;
	 MonNam [i] = (( MonNam [i]- 32)*5)/9;
end;
drop i;
run;
proc format ;
	value TempFor
	-30 - -10  = 'Brutally Cold'
	-10 -  0 = 'Cold'
	0 - 10 = 'Cool'
	10 - 20 = 'Mild'
	20 - 30 = 'Warm'
;
run;
options fmtsearch= (formats.code_ee);
proc print data = Q4;
FORMAT CODE $codeee. Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec avg_temp TempFor. ;
run;


