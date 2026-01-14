type display =
  | Normal
  | Brief of float

let report mode runs (ru : Rusage.t) =
  let time = ru.user_time +. ru.system_time in
  let ms_per = 1000. *. time /. Float.of_int runs in
  match mode with
  | Normal ->
    let p = Printf.fprintf in
    let e = Out_channel.stderr in
    p e "Real time      : %a\n" Units.pp_seconds ru.wall_time;
    p e "User time      : %.4f s\n" ru.user_time;
    p e "System time    : %.4f s\n" ru.system_time;
    p e "Time           : %a (%.3f ms/per)\n" Units.pp_seconds time ms_per;
    p e "Max RSS        : %a\n" Units.pp_rss ru.max_rss;
    p e "Page reclaims  : %.0f\n" ru.minor_fault;
    p e "Page faults    : %.0f\n" ru.major_fault;
    p e "Block inputs   : %.0f\n" ru.block_input;
    p e "Block outputs  : %.0f\n" ru.block_output;
    p e "vol ctx switches   : %.0f\n" ru.vol_ctx;
    p e "invol ctx switches : %.0f\n" ru.invol_ctx
  | Brief refms ->
    Printf.fprintf Out_channel.stderr "| %5.3fx | %a | %a |\n" (ms_per /. refms)
      Units.pp_seconds
      (time /. Float.of_int runs)
      Units.pp_rss ru.max_rss
