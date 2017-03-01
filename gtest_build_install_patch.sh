#!/bin/bash

prefix=$1

cp -r include/gtest ${prefix}/include
cp lib*.a ${prefix}/lib

touch ./gtest.pc
>./gtest.pc

echo -e "prefix=$prefix" >> ./gtest.pc
echo -e 'exec_prefix=${prefix}' >> ./gtest.pc
echo -e 'libdir=${exec_prefix}/lib' >> ./gtest.pc
echo -e 'includedir=${prefix}/include' >> ./gtest.pc
echo -e '' >> ./gtest.pc

echo -e 'Name: gtest' >> ./gtest.pc
echo -e "Description: Google's C++ test framework!" >> ./gtest.pc
echo -e 'Version: 1.7.0' >> ./gtest.pc
echo -e 'Libs: -L${libdir} -lgtest -lgtest_main -pthread  -lpthread' >> ./gtest.pc
echo -e 'Cflags: -I${includedir} -std=c++11 -Wall -D_REENTRANT -D_GNU_SOURCE -D_XOPEN_SOURCE -fPIC -m64 -g2' >> ./gtest.pc
echo -e 'Conflicts: gtest' >> ./gtest.pc
echo -e '' >> ./gtest.pc

cp ./gtest.pc ${prefix}/lib/pkgconfig