project(baserpc)
cmake_minimum_required(VERSION 2.8)
set(CMAKE_VERBOSE_MAKEFILE on)

include(ExternalProject)
externalproject_add(protobuf_proj
    DOWNLOAD_DIR ${CMAKE_SOURCE_DIR}/third_party
    DOWNLOAD_NAME protobuf-cpp-3.0.0.tar.gz
    URL https://github.com/google/protobuf/releases/download/v3.0.0/protobuf-cpp-3.0.0.tar.gz
    URL_MD5 8f2a8786503459375fcf33517ce7f29b
    CONFIGURE_COMMAND ./configure --prefix=<INSTALL_DIR> --disable-shared CFLAGS=-O2\ -fPIC CXXFLAGS=-O2\ -fPIC
    TEST_BEFORE_INSTALL 0
    BUILD_IN_SOURCE 1
    INSTALL_DIR ${CMAKE_BINARY_DIR}
    BUILD_COMMAND make -j2
    INSTALL_COMMAND make install
)
externalproject_add(phxrpc_proj
    DEPENDS protobuf_proj
    DOWNLOAD_DIR ${CMAKE_SOURCE_DIR}/third_party
    DOWNLOAD_NAME phxrpc-master.zip
    URL https://codeload.github.com/tencent-wechat/phxrpc/zip/master
    URL_MD5 c453b6053397f32bb04f823e7f51db40
    CONFIGURE_COMMAND ${PROJECT_SOURCE_DIR}/phxrpc_build_config_patch.sh <INSTALL_DIR>
    TEST_BEFORE_INSTALL 0
    BUILD_IN_SOURCE 1
    INSTALL_DIR ${CMAKE_BINARY_DIR}
    BUILD_COMMAND make -j2
    INSTALL_COMMAND make install
)
externalproject_add(gtest_proj
    DOWNLOAD_DIR ${CMAKE_SOURCE_DIR}/third_party
    DOWNLOAD_NAME gtest-1.7.0.tar.gz
    URL https://github.com/google/googletest/archive/release-1.7.0.tar.gz
    URL_MD5 4ff6353b2560df0afecfbda3b2763847
    CONFIGURE_COMMAND cmake .
    TEST_BEFORE_INSTALL 0
    BUILD_IN_SOURCE 1
    INSTALL_DIR ${CMAKE_BINARY_DIR}
    BUILD_COMMAND make -j2
    INSTALL_COMMAND ${PROJECT_SOURCE_DIR}/gtest_build_install_patch.sh <INSTALL_DIR>
)
externalproject_add(gperftools_proj
        DOWNLOAD_DIR ${CMAKE_SOURCE_DIR}/third_party
        DOWNLOAD_NAME perftools-2.5.tar.gz
        URL https://github.com/gperftools/gperftools/releases/download/gperftools-2.5/gperftools-2.5.tar.gz
        URL_MD5 aa1eaf95dbe2c9828d0bd3a00f770f50
        CONFIGURE_COMMAND ./configure --prefix=<INSTALL_DIR> --disable-shared CFLAGS=-O2\ -fPIC CXXFLAGS=-O2\ -fPIC
        TEST_BEFORE_INSTALL 0
        BUILD_IN_SOURCE 1
        INSTALL_DIR ${CMAKE_BINARY_DIR}
        BUILD_COMMAND make -j2
        INSTALL_COMMAND make install
)
add_subdirectory(calculator)

export(PACKAGE baserpc)
export(TARGETS cal FILE baserpc-exports.cmake)
set(CONF_INCLUDE_DIRS "${CMAKE_BINARY_DIR}/include")
configure_file(baserpc-config.cmake.in baserpc-config.cmake)
