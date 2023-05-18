%{
    #include <stdio.h>
    #include<stdlib.h>
    #include <string.h>
    #define YYSTYPE char * // important to convert yylval's value to allow string types also
    extern FILE *yyin;
    int yylex(void);
    void yyerror();
%}

%token NUM FLOAT DOUBLE ERROR DATA DEF DIM END FOR TO STEP NEXT GOSUB GOTO IF THEN LET INPUT PRINT REM RETURN STOP NOTEQUAL SIZE BEQ BNE BGE BLE BGT BLT NOT AND OR XOR EQUAL ADD SUB PRO DIV POWER SEMCOM COMMA OPA CPA FUNC VARINT VARFLOAT VARSTRING VARDOUBLE STRING PRTEXP IGN EOL 

%%

program:
    subprogram {exit(0);}
subprogram:
    stmt subprogram
    |stmt 
    ;
stmt: 
    NUM END EOL {printf("Error : END not at the end\n"); exit(0);}
    | NUM END {printf("========================EXITING================================"); exit(0);}
    | NUM subst EOL
    | NUM subst {printf("Program without END! Error!\n");exit(0);}
    | subst EOL {printf("Error: No Address given\n");exit(0);}
    | subst {printf("Error: No Address given\n");exit(0);}
    ;
subst:
    {printf("Comment!\n");} REM
    | data {printf("Data added\n");}
    | returntomain
    | stop
    | {printf("Let initialisation found!\n");} let
    | inputvar
    | gotoline
    | {printf("Defining a function!\n");} def
    | {printf("Branch if!\n");} ifthen
    | {printf("Print statement!\n");} PRINT
    | dim
    | {printf("Loop detected!\n");} forloop
    | {printf("Wrong Command Given"); exit(0);}
    ;
def:
    DEF FUNC varint EQUAL equation
    | DEF FUNC varfloat EQUAL equation
    | DEF FUNC vardouble EQUAL equation
    | DEF FUNC EQUAL equation
    ;
ifthen:
    IF logicalequation THEN NUM
    ;
logicalequation:
    inequation
    | NOT logicalequation
    | logicalequation AND inequation
    | logicalequation OR inequation
    | logicalequation XOR inequation
    ;
inequation:
    equation
    | equation BEQ equation
    | equation BNE equation
    | equation BGE equation
    | equation BLE equation
    | equation BGT equation
    | equation BLT equation
    ;
equation: {printf("Encountered an equation!\n");}
    factor
    | equation ADD factor
    | equation SUB factor
    ;
factor:
    term
    | factor PRO term
    | factor DIV term
    ;
term:
    num 
    | ADD num
    | SUB num
    ;
num:
    number
    | number POWER number
    ;
number:
    value
    | OPA equation CPA
    ;
value:
    NUM 
    | FLOAT
    | DOUBLE
    | STRING
    | VARINT 
    | VARFLOAT 
    | VARDOUBLE 
    | VARSTRING
    | VARINT OPA equation CPA
    | VARFLOAT OPA equation CPA
    | VARDOUBLE OPA equation CPA
    | FUNC
    ;
returntomain:
    RETURN    
    {
        printf("Return hit\n");
    }
    ;
stop: 
    STOP 
    {
        printf("======STOP=======\n");
    }
    ;
dim:
    DIM dimb {printf("DIM run!\n");}
    ;
dimb: dimb COMMA VARINT OPA NUM CPA
    | dimb COMMA VARINT OPA NUM COMMA NUM CPA
    | VARINT OPA NUM CPA
    | VARINT OPA NUM COMMA NUM CPA
    ;
let:
    LET VARINT EQUAL NUM 
    | LET varint EQUAL varint
    | LET VARFLOAT EQUAL FLOAT 
    | LET varfloat EQUAL varfloat 
    | LET VARSTRING EQUAL STRING 
    | LET varstring EQUAL varstring 
    | LET VARDOUBLE EQUAL DOUBLE
    | LET vardouble EQUAL vardouble 
    | LET leterror
    ;
leterror: VARINT EQUAL varint 
    | VARFLOAT EQUAL varfloat 
    | VARSTRING EQUAL varstring 
    | VARDOUBLE EQUAL vardouble 
    ;
varint: VARINT 
    | equation
    | VARINT OPA equation CPA 
    | VARINT OPA equation CPA ADD equation
    | OPA equation CPA
    | FLOAT {printf("Error! Unmatching Type!\n"); exit(0);}
    | VARFLOAT {printf("Error! Unmatching Type!\n"); exit(0);}
    | STRING {printf("Error! Unmatching Type!\n"); exit(0);}
    | VARSTRING {printf("Error! Unmatching Type!\n"); exit(0);}
    | DOUBLE {printf("Error! Unmatching Type!\n"); exit(0);}
    | VARDOUBLE {printf("Error! Unmatching Type!\n"); exit(0);}
    ;
varfloat: VARFLOAT 
    | equation
    | VARFLOAT OPA equation CPA 
    | OPA equation CPA
    | NUM {printf("Error! Unmatching Type!\n"); exit(0);}
    | VARINT {printf("Error! Unmatching Type!\n"); exit(0);}
    | STRING {printf("Error! Unmatching Type!\n"); exit(0);}
    | VARSTRING {printf("Error! Unmatching Type!\n"); exit(0);}
    | DOUBLE {printf("Error! Unmatching Type!\n"); exit(0);}
    | VARDOUBLE {printf("Error! Unmatching Type!\n"); exit(0);}
    ;
varstring: VARSTRING 
    | equation
    | VARSTRING OPA equation CPA 
    | FLOAT {printf("Error! Unmatching Type!\n"); exit(0);}
    | VARFLOAT {printf("Error! Unmatching Type!\n"); exit(0);}
    | NUM {printf("Error! Unmatching Type!\n"); exit(0);}
    | VARINT {printf("Error! Unmatching Type!\n"); exit(0);}
    | DOUBLE {printf("Error! Unmatching Type!\n"); exit(0);}
    | VARDOUBLE {printf("Error! Unmatching Type!\n"); exit(0);}
    ;
vardouble: VARDOUBLE
    | equation
    | VARDOUBLE OPA equation CPA
    | OPA equation CPA
    | FLOAT {printf("Error! Unmatching Type!\n"); exit(0);}
    | VARFLOAT {printf("Error! Unmatching Type!\n"); exit(0);}
    | STRING {printf("Error! Unmatching Type!\n"); exit(0);}
    | VARSTRING {printf("Error! Unmatching Type!\n"); exit(0);}
    | NUM {printf("Error! Unmatching Type!\n"); exit(0);}
    | VARINT {printf("Error! Unmatching Type!\n"); exit(0);}
    ;
inputvar:
    INPUT varb
    ;
varb: varb COMMA var
    | var
    ;
var: VARINT {printf("Int Input found!\n");}
    | VARFLOAT {printf("Float Input found!\n");}
    | VARDOUBLE {printf("Double Input found!\n");}
    | VARSTRING {printf("String Input found!\n");}
    | VARINT OPA VARINT CPA
    ;
gotoline:
    GOSUB NUM {printf("Gosub found!\n");} //Push RA to stack, which is next in line to this stmt after jumping to the given address
    | GOTO NUM {printf("Goto found!\n");} //Just jump to this address 
    ;
data:
    data COMMA NUM
    | data COMMA STRING
    | data COMMA FLOAT
    | data COMMA DOUBLE
    | DATA NUM
    | DATA STRING
    | DATA FLOAT
    | DATA DOUBLE
    ;
forloop:
    FOR VARINT EQUAL NUM TO equation STEP NUM EOL subcode NUM NEXT VARINT
    | FOR VARINT EQUAL NUM TO equation STEP SUB NUM EOL subcode NUM NEXT VARINT
    | FOR VARINT EQUAL NUM TO equation EOL subcode NUM NEXT VARINT
    | FOR VARINT EQUAL NUM TO equation EOL NUM NEXT VARINT
    | FOR VARINT EQUAL NUM TO equation STEP NUM EOL NUM NEXT VARINT
    | FOR VARINT EQUAL NUM TO equation STEP SUB NUM EOL NUM NEXT VARINT
    ;
subcode: subcode stmt
    | stmt
    ;
%%


void yyerror(char *str){
    printf("%s",yylval);
    fprintf(stderr,"Error : %s\n",str);
}

int main(){

    //counting lines in file
    
    char filename[] = "input.txt";
    FILE *fp; int i; int temp= -1;
    fp = fopen(filename,"r");
    yyin = fp;
    yyparse();
    return 0;
}
