let eval expr =
  let lexbuf = Lexing.from_string expr in
  let result = Parser.main Lexer.token lexbuf in
  Printf.printf "\t%.8g\n" result

let print_usage name = begin
    Printf.eprintf "usage:\n";
    Printf.eprintf "  %s < file\n" name;
    Printf.eprintf "  %s -c \"a = 1; a * 3\"\n" name
  end


let main () =
  let argv   = Array.to_list Sys.argv in
  let name   = List.hd argv in
  let args   = List.tl argv in
  if args = [] then
    try
      while true do
        try
          read_line () |> eval
        with
        | Division_by_zero -> print_endline "Division_by_zero"
        | Errors.Overflow_Exception msg -> Printf.printf "Overflow: %s" msg
      done
    with End_of_file -> ()
  else if List.hd args = "-c" then
    String.concat " " (List.tl args) |> eval
  else if List.hd args = "-h" then
    print_usage name
  else
    begin
      Printf.eprintf "invalid option %s\n" (String.concat " " args);
      print_usage name
    end

let () = main ()

