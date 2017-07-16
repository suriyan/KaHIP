#!/bin/bash
set -e -x

swig -python -outdir kahipwrapper -c++ -debug-tmused kaHIP.i

# Compile wheels
for PYBIN in /opt/python/*; do
    echo ${PYBIN}
    c++ -m64 -std=c++11 -fPIC -fpermissive -c kaHIP_wrap.cxx ../../interface/kaHIP_interface.cpp -I ../../include -I ../../lib -I ../.. -I ../../lib/tools -I ../../lib/partition `${PYBIN}/bin/python-config --includes --cflags`
    c++ -m64 -shared kaHIP_wrap.o -o ./kahipwrapper/_kaHIP.so ../../deploy/libkahip.a -lgomp

    LD_LIBRARY_PATH=${PYBIN}/lib ${PYBIN}/bin/python setup.py bdist_wheel
    # https://github.com/pypa/manylinux/issues/49
    rm -rf build
done
 
# Audit wheels and write multilinux1 tag
for whl in dist/*.whl; do
    LD_LIBRARY_PATH=/opt/_internal/cpython-3.5.1/lib auditwheel repair $whl -w dist
done

