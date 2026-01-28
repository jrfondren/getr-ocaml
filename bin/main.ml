open Getr

let usage_line = "[-i=<input>] [-b=<ref ms>] <runs> <command> [<args> ..]"

let usage msg =
  Printf.eprintf "%susage: %s %s\n" msg Sys.argv.(0) usage_line;
  exit 1

let argv, runs, cmd, args =
  let argv = Sys.argv in
  match
    Array.find_index (fun a -> int_of_string_opt a |> Option.is_some) argv
  with
  | Some i when i < Array.length argv - 1 ->
    ( Array.sub argv 0 i,
      int_of_string argv.(i),
      argv.(i + 1),
      Array.sub argv (i + 1) (Array.length argv - (i + 1)) )
  | Some i -> usage ("no command found after runs of " ^ argv.(i))
  | None -> usage "no runs found\n"

let input, mode =
  let input = ref None in
  let mode = ref Display.Normal in
  try
    Arg.parse_argv argv
      [
        ( "-b",
          Arg.Float (fun r -> mode := Display.Brief r),
          "brief output with comparison to reference speed in ms" );
        ( "-i",
          Arg.String (fun s -> input := Some s),
          "spawn commands with this file as standard input" );
      ]
      (fun a -> usage ("unhandled arg: " ^ a ^ "\n"))
      ("getr " ^ usage_line);
    !input, !mode
  with Arg.Bad msg ->
    Printf.eprintf "%s" msg;
    exit 1

let () =
  let before = Unix.gettimeofday () in
  Fun.protect
    ~finally:(fun () -> Display.report mode runs (Rusage.get before))
    (fun () -> Spawn.spawns ~input cmd args runs)
