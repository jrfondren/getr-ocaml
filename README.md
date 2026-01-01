
# `getrusage()` wrapper for casual benchmarks


## Synopsis

```
$ getr 3 ocaml -e 'print_endline "hello"'
hello
hello
hello
User time      : 0.2201 s
System time    : 0.0442 s
Time           : 264.3 ms (88.095 ms/per)
Max RSS        : 11.4 MB
Page reclaims  : 7429
Page faults    : 0
Block inputs   : 0
Block outputs  : 0
vol ctx switches   : 3
invol ctx switches : 3

$ getr -b=88.095 3 erl -noshell -eval 'io:fwrite("hello~n"), erlang:halt()'
hello
hello
hello
| 13.759x | 1 s 212 ms | 55.4 MB |

$ getr 3 ocaml -e 'exit 1'
child (pid 13728 run 1) failed with exit status 1

$ echo -e "1\n2\n3" > input
$ dune exec getr -- -b=4 -i=input 2 perl -lpe 's/^/!! /; END { print "" }'
!! 1                                
!! 2
!! 3

!! 1
!! 2
!! 3

| 2.122x | 8.5 ms | 23.2 MB |
```

## Description

`getr` wraps the `getrusage(2)` syscall for basic resource usage reports \- primarily it offers user/system time and peak memory use. A single child command is run a given amount of times, and then a `RUSAGE_CHILDREN` report is printed to standard error.

Other programs offer finer and statistically much more relaible comparison between multiple commands. I find `getr` more convenient for casual checks since it doesn't require any additional quoting or care with commands, and since it always also reports memory usage (unlike hyperfine), and since it doesn't interfere with I/O.

If any spawned processes return with a non-zero status code, `getr` prints a message about that and exits with the same code.


## Modules

`Getr.Rusage` 
`Getr.Spawn` 
`Getr.Display` 

## Installing

```bash
# one-shot-ly
$ opam install git+https://github.com/jrfondren/getr-ocaml

# persistently, if you want to see (unlikely) upgrades
$ opam pin add getr https://github.com/jrfondren/getr-ocaml
$ opam install getr

# optimistically, will work if I publish this
$ opam install getr

# vcsly
$ dune build --display=short
$ dune install  # to opam switch
$ dune install --prefix=/usr/local
```

## Developing

```bash
$ dune exec getr 3 echo hi

$ dune build @doc
$ xdg-open _build/default/_doc/_html/index.html

$ odoc compile doc/index.mld
$ odoc markdown-generate doc/page-index.odoc --output-dir=.
```

## See also

- [getrusage(2)](https://man7.org/linux/man-pages/man2/getrusage.2.html)
- [hyperfine](https://lib.rs/crates/hyperfine)
- [Performance Optimizer Observation Platform](https://github.com/andrewrk/poop/)
- `chrestomathy`, comparing implementations of `getr`