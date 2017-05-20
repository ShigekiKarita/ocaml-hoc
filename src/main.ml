let main () =
  (* let argv   = Array.to_list Sys.argv in *)
  (* let args   = List.tl argv in *)
  (* let expr   = String.concat " " args in *)
  try
    while true do
      let expr = read_line () in
      let lexbuf = Lexing.from_string expr in
      let result = Parser.main Lexer.token lexbuf in
      Printf.printf "\t%.8g\n" result
    done
  with End_of_file -> ()


let () = main ()

