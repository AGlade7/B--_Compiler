<h1> B-- Compiler </h1>
 
This is our project for Programming Paradigms and Pragmatics course

The complete problem statement can be found here : https://drive.google.com/file/d/14WbU55wT20g_5vUm45CbeYqhrSaNCgnU/view?usp=drivesdk

<h3> Contributors : </h3>

  1. Shobhit Juglan 
  2. Aryaman Gupta

<h3> Running Commands : </h3> 
    
    flex BMM_Scanner.l
This will create a lex.yy.c file.     

    bison -d BMM_Parser.y
This will form BMM_Parser.tab.c and BMM_Parser.tab.h files.   
   
    gcc lex.yy.c BMM_Parser.tab.c
This will compile the C files together to give the executable file a.exe.

    ./a.exe
This will run the executable file.
The program in input.txt will be checked for errors! If no errors are found, then the program just prints all the functions it found and exit the program.  

<h3> Assumptions : </h3>

  1. The ordering of the addresses is given correctly in the input file.
  2. The code is run for the purpose of detection for basic syntax errors and not semantic and logical errors. 

<h3> ERRORS IMPLEMENTED : </h3> 

  1. Incorrect Keyword
  2. Last line not at end
  3. End absent in code
  4. Presence of LowerCase letters 
  5. Invalid Variable Name
  6. Declared Variable type not matching with assigned value
  7. Address not given
  8. Incorrect function/no function provided
  9. Syntax error in function call
    
<h3>  VARIABLE ASSIGNMENT : </h3> 

  1. Variable Names: Single Upper-Case Letter (A – Z) followed by an optional single digit (0 – 9).E xamples: A, F, H, A0, Z9
  2. Data Types: Numeric – Integer (%,), Single Precision (!), Double Precision (#) & Strings ($)
  3. Type declaration uses special characters along with variable names as given above (with default being integer)
  Examples: P1# (double precision), N$ (string), A9 (integer), B1% (also integer), M! (single precision)
