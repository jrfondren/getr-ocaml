type t = {
  user_time : float;
  system_time : float;
  max_rss : float;
  minor_fault : float;
  major_fault : float;
  block_input : float;
  block_output : float;
  vol_ctx : float;
  invol_ctx : float;
}

external get_helper : unit -> float array = "getrusage_helper"

let get () =
  let a = get_helper () in
  {
    user_time = a.(0);
    system_time = a.(1);
    max_rss = a.(2);
    minor_fault = a.(3);
    major_fault = a.(4);
    block_input = a.(5);
    block_output = a.(6);
    vol_ctx = a.(7);
    invol_ctx = a.(8);
  }
