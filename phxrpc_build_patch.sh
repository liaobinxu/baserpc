#!/bin/bash

prefix=$1

echo "append install task to Makefile"
echo -e "" >> ./Makefile
echo -e "PREFIX=$prefix" >> ./Makefile

cat >> ./Makefile <<'EOF'

install:
	@(echo create lib directory to $(PREFIX)/lib; )
	@(echo create codegen binary to $(PREFIX)/bin; )
	@(echo create phxrpc header to $(PREFIX)/include/phxrpc; )
	@(mkdir -p $(PREFIX)/include/phxrpc/file; )
	@(mkdir -p $(PREFIX)/include/phxrpc/http; )
	@(mkdir -p $(PREFIX)/include/phxrpc/network; )
	@(mkdir -p $(PREFIX)/include/phxrpc/rpc; )
	@(cp lib/*  $(PREFIX)/lib -rf; )
	@(cp phxrpc.pc  $(PREFIX)/lib/pkgconfig; )
	@(cp codegen/phxrpc_pb2service  $(PREFIX)/bin; )
	@(cp codegen/phxrpc_pb2client  $(PREFIX)/bin; )
	@(cp codegen/phxrpc_pb2tool  $(PREFIX)/bin; )
	@(cp codegen/phxrpc_pb2server  $(PREFIX)/bin; )
	@(cp phxrpc/*.h  $(PREFIX)/include/phxrpc; )
	@(cp phxrpc/file/*.h  $(PREFIX)/include/phxrpc/file; )
	@(cp phxrpc/http/*.h  $(PREFIX)/include/phxrpc/http; )
	@(cp phxrpc/network/*.h  $(PREFIX)/include/phxrpc/network; )
	@(cp phxrpc/rpc/*.h  $(PREFIX)/include/phxrpc/rpc; )
	@(cp phxrpc/rpc/*.proto  $(PREFIX)/include/phxrpc/rpc; )

EOF

mkdir -p third_party
if [ ! -d third_party/protobuf ]; then
    ln -s $1 third_party/protobuf
fi


touch ./phxrpc.pc
>./phxrpc.pc

echo -e "prefix=$prefix" >> ./phxrpc.pc
echo -e 'exec_prefix=${prefix}' >> ./phxrpc.pc
echo -e 'libdir=${exec_prefix}/lib' >> ./phxrpc.pc
echo -e 'includedir=${prefix}/include' >> ./phxrpc.pc
echo -e '' >> ./phxrpc.pc

echo -e 'Name: Phxrpc' >> ./phxrpc.pc
echo -e 'Description: PhxRPC是微信后台团队推出的一个非常简洁小巧的RPC框架，编译生成的库只有450K' >> ./phxrpc.pc
echo -e 'Version: 0.8.0' >> ./phxrpc.pc
echo -e 'Libs: -L${libdir} -lphxrpc -lprotobuf -pthread  -lpthread -lstdc++ -lm' >> ./phxrpc.pc
echo -e 'Cflags: -I${includedir} -std=c++11 -Wall -D_REENTRANT -D_GNU_SOURCE -D_XOPEN_SOURCE -fPIC -m64 -g2' >> ./phxrpc.pc
echo -e 'Conflicts: phxrpc' >> ./phxrpc.pc
echo -e '' >> ./phxrpc.pc
