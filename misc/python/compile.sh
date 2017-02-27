#!/usr/bin/env bash

swig -python -outdir kahipwrapper -c++ -debug-tmused kaHIP.i
c++ -std=c++11 -fPIC -c kaHIP_wrap.cxx -I/usr/include/python2.7 -I/usr/include/x86_64-linux-gnu/python2.7 ../../interface/kaHIP_interface.cpp -I ../../include -I ../../lib -I ../../lib/tools -I ../../lib/partition
c++ -shared kaHIP_wrap.o -o ./kahipwrapper/_kaHIP.so ../../deploy/libkahip.a -lgomp
python test.py

