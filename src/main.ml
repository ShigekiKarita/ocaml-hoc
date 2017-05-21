let main () =
  let argv   = Array.to_list Sys.argv in
  let args   = List.tl argv in
  if args = [] then
    try
      while true do
        let expr = read_line () in
        let lexbuf = Lexing.from_string expr in
        let result = Parser.main Lexer.token lexbuf in
        Printf.printf "\t%.8g\n" result
      done
    with End_of_file -> ()
  else if List.hd args = "-c" then
    let expr   = String.concat " " (List.tl args) in
    let lexbuf = Lexing.from_string expr in
    let result = Parser.main Lexer.token lexbuf in
    Printf.printf "\t%.8g\n" result
  else
    let () = Printf.eprintf "invalid option %s\n" (String.concat " " args) in
    let () = Printf.eprintf "\nusage:\n  %s < file\n" (List.hd argv) in
    Printf.eprintf "  %s -c \"a = 1; a * 3\"\n" (List.hd argv)

let () = main ()

