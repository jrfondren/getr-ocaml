(lang dune 3.20)
(name getr)
(generate_opam_files true)
(source
 (github jrfondren/getr-ocaml))
(authors "Julian Fondren <julian.fondren@gmail.com>")
(maintainers "Julian Fondren <julian.fondren@gmail.com>")
(license MIT)
(documentation https://github.com/jrfondren/getr-ocaml/doc)

(package
 (name getr)
 (synopsis "benchmarking wrapper around getrusage")
 (description "getr wraps the getrusage(2) syscall for basic resource usage reports - primarily it offers user/system time and peak memory use. A single child command is run a given amount of times, and then a RUSAGE_CHILDREN report is printed to standard error.

Other programs offer finer and statistically much more relaible comparison between multiple commands. I find getr more convenient for casual checks since it doesn't require any additional quoting or care with commands, and since it always also reports memory usage (unlike hyperfine), and since it doesn't interfere with I/O.

Basic usage: getr 3 ocaml -e 'print_endline \"hello\"'")
 (depends ocaml)
 (tags ("cli" "benchmark")))
