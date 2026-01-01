(** Spawn subprocesses *)

val spawn :
  stdin:Unix.file_descr -> string -> string array -> int * Unix.process_status

val spawns : input:string option -> string -> string array -> int -> unit
(** [spawns input cmd args runs] sequentially spawns [cmd] with [args], [runs]
    number of times, waiting for each child to exit. [args] must include the
    command's own [Sys.argv.(0)]. [input] if provided is reopened for each run
    and passed as the child's standard input.*)
