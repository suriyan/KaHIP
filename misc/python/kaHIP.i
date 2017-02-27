%module kaHIP

%apply int *INPUT { int *nparts };
%apply double *INPUT { double *imbalance };

/* Set the input argument to point to a temporary variable */
%typemap(in, numinputs=1) int *n (int temp) {
  temp = PyInt_AsLong($input);
  $1 = &temp;
  if (strcmp("$symname", "node_separator") != 0) {
    *_global_part = (int *) malloc((temp+1)*sizeof(int));
  }
  else {
    *_global_separator = (int **) malloc((temp+1)*sizeof(int *));
  }
}

%typemap(in,numinputs=0) int *edgecut (int temp) {
    $1 = &temp;
}

%typemap(in,numinputs=0) int *part (int **_global_part, int ***_global_separator) {
    _global_part = &$1;
}
%typemap(freearg) (int *part) {
  free((int *) $1);
}

%typemap(in,numinputs=0) int *num_separator_vertices (int temp) {
    $1 = &temp;
}

%typemap(in,numinputs=0) int **separator (int **_global_part, int ***_global_separator) {
    _global_separator = &$1;
}
%typemap(freearg) (int **separator) {
  free((int *)$1);
}

%typemap(argout, numinputs=2) (int *edgecut, int *part) {
  int i;

  PyObject *list = PyList_New(temp1);
  for (i = 0; i < temp1; i++) {
    PyObject *o = PyInt_FromLong((int) $2[i]);
    PyList_SetItem(list, i, o);
  }

  $result = PyTuple_New(2);
  PyTuple_SetItem($result, 0, PyInt_FromLong(*$1));
  PyTuple_SetItem($result, 1, list);
}

%typemap(argout, numinputs=2) (int *num_separator_vertices, int **separator) {
  int i;
  int n = *$1;
  PyObject *list = PyList_New(n);
  for (i = 0; i < n; i++) {
    PyObject *o = PyInt_FromLong((int) *(*$2 + i));
    PyList_SetItem(list, i, o);
  }

  $result = PyTuple_New(2);
  PyTuple_SetItem($result, 0, PyInt_FromLong(n));
  PyTuple_SetItem($result, 1, list);
}

%typemap(in) (int *xadj) {
  /* Check if is a list */
  if (PyList_Check($input)) {
    int i, n;
    n = PyList_Size($input);
    $1 = (int *) malloc((n+1)*sizeof(int));
    for (i = 0; i < n; i++) {
        $1[i] = PyInt_AsLong(PyList_GetItem($input,i));
    }
    $1[i] = 0;
  } else {
    PyErr_SetString(PyExc_TypeError,"xadj not a list");
    return NULL;
  }
}
%typemap(freearg) (int *xadj) {
  free((int *) $1);
}


%typemap(in) (int *vwgt) {
  /* Check if is a list */
  if ($input == Py_None) {
    $1 = NULL;
  }
  else {
      if (PyList_Check($input)) {
        int i, n;
        n = PyList_Size($input);
        $1 = (int *) malloc((n+1)*sizeof(int));
        for (i = 0; i < n; i++) {
            $1[i] = PyInt_AsLong(PyList_GetItem($input,i));
        }
        $1[i] = 0;
      } else {
        PyErr_SetString(PyExc_TypeError,"vwgt not a list");
        return NULL;
      }
  }
}
%typemap(freearg) (int *vwgt) {
  free((int *) $1);
}

%typemap(in) (int *adjncy) {
  /* Check if is a list */
  if (PyList_Check($input)) {
    int i, n;
    n = PyList_Size($input);
    $1 = (int *) malloc((n+1)*sizeof(int));
    for (i = 0; i < n; i++) {
        $1[i] = PyInt_AsLong(PyList_GetItem($input,i));
    }
    $1[i] = 0;
  } else {
    PyErr_SetString(PyExc_TypeError,"adjncy not a list");
    return NULL;
  }
}
%typemap(freearg) (int *adjncy) {
  free((int *) $1);
}

%typemap(in) (int *adjcwgt) {
  /* Check if is a list */
  if ($input == Py_None) {
    $1 = NULL;
  }
  else {
      if (PyList_Check($input)) {
        int i, n;
        n = PyList_Size($input);
        $1 = (int *) malloc((n+1)*sizeof(int));
        for (i = 0; i < n; i++) {
            $1[i] = PyInt_AsLong(PyList_GetItem($input,i));
        }
        $1[i] = 0;
      } else {
        PyErr_SetString(PyExc_TypeError,"adjcwgt not a list");
        return NULL;
      }
  }
}
%typemap(freearg) (int *adjcwgt) {
  free((int *) $1);
}

%{
/* Includes the header in the wrapper code */
#include "../../interface/kaHIP_interface.h"
%}

/* Parse the header file to generate wrappers */
%include "../../interface/kaHIP_interface.h"
