%{
    let mem =
      let max_mem = (int_of_char 'z') - (int_of_char 'a') + 1 in
      Array.make max_mem 0.0
    let mem_id c = (int_of_char c) - (int_of_char 'a')
%}

%token <float> FLOAT
%token <char> VAR
%token PLUS MINUS TIMES DIV
%token LPAREN RPAREN
%token SET
%right SET
%left PLUS MINUS        /* lowest precedence */
%left TIMES DIV         /* medium precedence */
%nonassoc UMINUS        /* highest precedence */
%start main             /* the entry point */
%token EOF
%token SEMICOLON
%left SEMICOLON
%type <float> main

%%

(* Menhir let us give names to symbol values,
   instead of having to use $1, $2, $3 as in ocamlyacc *)
main
  : e = expr EOF                { e }
  | e1=expr SEMICOLON e2=main   { e2 }
  ;

expr
  : n = FLOAT               { n }
  | v = VAR                 { Array.get mem (mem_id v) }
  | v=VAR SET e=expr        { let i = mem_id v in Array.set mem i e; Array.get mem i }
  | LPAREN e = expr RPAREN  { e }
  | e1=expr PLUS  e2=expr   { e1 +. e2 }
  | e1=expr MINUS e2=expr   { e1 -. e2 }
  | e1=expr TIMES e2=expr   { e1 *. e2 }
  | e1=expr DIV   e2=expr   { e1 /. e2 }
  | MINUS e = expr %prec UMINUS { -. e }
  ;
