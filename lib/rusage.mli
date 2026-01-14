(** Resource usage stats with [getrusage()] *)

type t = {
  wall_time : float;  (** added data; not part of getrusage() *)
  user_time : float;  (** seconds +. microseconds /. 1e6 *)
  system_time : float;  (** seconds +. microseconds /. 1e6 *)
  max_rss : float;  (** KB *)
  minor_fault : float;
  major_fault : float;
  block_input : float;
  block_output : float;
  vol_ctx : float;
  invol_ctx : float;
}

val get : float -> t
(** [get start_time] performs a [getrusage()] syscall for [RUSAGE_CHILDREN] *)
