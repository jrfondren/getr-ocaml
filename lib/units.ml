module P = Printf

let pp_seconds fmt = function
  | s when s < 1. -> P.fprintf fmt "%.1f ms" (s *. 1000.)
  | s when s < 60. ->
    P.fprintf fmt "%.0f s %d ms" s (int_of_float (s *. 1000.) mod 1000)
  | s ->
    P.fprintf fmt "%d min %d s" (int_of_float s / 60) (int_of_float s mod 60)

let pp_rss fmt = function
  | k when k < 1024. -> P.fprintf fmt "%.1f kB" k
  | k when k < 1024. *. 1024. -> P.fprintf fmt "%.1f MB" (k /. 1024.)
  | k -> P.fprintf fmt "%.2f GB" (k /. (1024. *. 1024.))
