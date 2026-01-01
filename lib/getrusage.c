#include <caml/alloc.h>
#include <caml/fail.h>
#include <caml/memory.h>
#include <sys/resource.h>

#ifdef __APPLE__
#define RSS(x) x / 1024.0
#else
#define RSS(x) x
#endif

CAMLprim value getrusage_helper(value unit) {
  CAMLparam0();
  struct rusage usage;
  if (-1 == getrusage(RUSAGE_CHILDREN, &usage))
    caml_failwith("getrusage() failed - this should never happen");
  value arr = caml_alloc_float_array(9);
  Store_double_field(arr, 0,
                     (double)usage.ru_utime.tv_sec +
                         (double)usage.ru_utime.tv_usec * 1e-6);
  Store_double_field(arr, 1,
                     (double)usage.ru_stime.tv_sec +
                         (double)usage.ru_stime.tv_usec * 1e-6);
  Store_double_field(arr, 2, RSS((double)usage.ru_maxrss));
  Store_double_field(arr, 3, (double)usage.ru_minflt);
  Store_double_field(arr, 4, (double)usage.ru_majflt);
  Store_double_field(arr, 5, (double)usage.ru_inblock);
  Store_double_field(arr, 6, (double)usage.ru_oublock);
  Store_double_field(arr, 7, (double)usage.ru_nvcsw);
  Store_double_field(arr, 8, (double)usage.ru_nivcsw);
  CAMLreturn(arr);
}
