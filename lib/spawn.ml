let spawn ~stdin cmd args =
  Unix.create_process cmd args stdin Unix.stdout Unix.stderr |> Unix.waitpid []

let check_exit run = function
  | _, Unix.WEXITED 0 -> ()
  | pid, Unix.WEXITED n ->
    Printf.fprintf Out_channel.stderr
      "child (pid %d run %d) failed with exit status %d\n" pid run n;
    exit n
  | pid, Unix.WSIGNALED _ ->
    Printf.fprintf Out_channel.stderr
      "child (pid %d run %d) failed with signal\n" pid run;
    exit 1
  | pid, Unix.WSTOPPED _ ->
    Printf.fprintf Out_channel.stderr
      "child (pid %d run %d) stopped with signal\n" pid run;
    exit 1

let spawns ~input cmd args runs =
  match input with
  | None ->
    for i = 1 to runs do
      spawn ~stdin:Unix.stdin cmd args |> check_exit i
    done
  | Some file ->
    for i = 1 to runs do
      let stdin = Unix.openfile file Unix.[O_RDONLY; O_CLOEXEC] 0o400 in
      Fun.protect
        ~finally:(fun () -> Unix.close stdin)
        (fun () -> spawn ~stdin cmd args |> check_exit i)
    done
