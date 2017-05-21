{
    module P = Parser

    exception Error of string
    let error fmt = Printf.kprintf (fun msg -> raise (Error msg)) fmt

    let get = Lexing.lexeme
}

let int = '-'? ['0'-'9'] ['0'-'9']*
let digit = ['0'-'9']
let frac = '.' digit*
let exp = ['e' 'E'] ['-' '+']? digit+
let float = digit* frac? exp?


rule token = parse
  | [' ' '\t' '\n']         { token lexbuf }     (* skip blanks *)
  | ['a'-'z'] as var        { P.VAR(var) }
  | float as lxm            { P.FLOAT(float_of_string lxm) }
  | '='                     { P.SET }
  | '+'                     { P.PLUS }
  | '-'                     { P.MINUS }
  | '*'                     { P.TIMES }
  | '/'                     { P.DIV }
  | '('                     { P.LPAREN }
  | ')'                     { P.RPAREN }
  | eof                     { P.EOF }
  | ';'                     { P.SEMICOLON }
  | _ { error "don't know how to handle '%s'" (get lexbuf) }
