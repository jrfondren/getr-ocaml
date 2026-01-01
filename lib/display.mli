(** Display [getrusage()] reports *)

type display =
  | Normal
  | Brief of float

val report : display -> int -> Rusage.t -> unit
(** [report mode runs ru] prints a [Rusage.t] report to standard error. [runs]
    is used to indicate per-run resource cost. *)
