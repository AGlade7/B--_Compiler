#B--_Compiler

This is our project for Programming Paradigms and Pragmatics course

The complete problem statement can be found here : https://drive.google.com/file/d/1ghC3pPRKmZu_No7SS81dpSQhg83KtFw5/view?usp=drive_web&authuser=0

Contributors : 
1. Shobhit Juglan 
2. Aryaman Gupta

Running Commands : 

flex BMM_Scanner.l && bison -d BMM_Parser.y && gcc lex.yy.c BMM_Parser.tab.c && a.exe

Assumptions : 
1. The ordering of the addresses is given correctly in the input file

















#################################################

ERRORS TO IMPLEMENT : 
    1. Incorrect Keyword
    2. Tabs not permitted
    3. Last line must be end
    4. LowerCase not permitted
    5. Invalid Variable Name
    6.
VARIABLES
1. Variable Names: Single Upper-Case Letter (A – Z) followed by an optional single digit (0 – 9).Examples: A, F, H, A0, Z9
2. Data Types: Numeric – Integer (%), Single Precision (!), Double Precision (#) & Strings ($)
3. Type declaration uses special characters along with variable names as given above (with default being integer)
a. Examples: P1# (double precision), N$ (string), A9 (integer), M! (single precision)