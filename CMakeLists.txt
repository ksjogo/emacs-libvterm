# CMake build script for emacs-libvterm

PROJECT(emacs-libvterm C)
CMAKE_MINIMUM_REQUIRED(VERSION 2.8)

SET(CMAKE_POSITION_INDEPENDENT_CODE TRUE CACHE BOOL "pic" FORCE)

INCLUDE_DIRECTORIES(${CMAKE_SOURCE_DIR}/include)
INCLUDE_DIRECTORIES(${CMAKE_SOURCE_DIR}/libvterm/include)

IF(APPLE)
  SET(CMAKE_SHARED_LIBRARY_SUFFIX ".so")
  SET(CMAKE_SKIP_RPATH true)

ENDIF()

ADD_LIBRARY(vterm-core SHARED libvterm-core.c)

SET(VTERM_C_FLAGS ${CMAKE_C_FLAGS} "-fPIC")

ADD_CUSTOM_TARGET(
   libvterm
   COMMAND env CC="gcc" CFLAGS="${VTERM_C_FLAGS}" make
   WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}/libvterm
)

ADD_CUSTOM_TARGET(superclean
  COMMAND make clean
  COMMAND cd "${CMAKE_SOURCE_DIR}/libvterm" && make clean
)

ADD_DEPENDENCIES(vterm-core libvterm)
TARGET_LINK_LIBRARIES(vterm-core ${CMAKE_SOURCE_DIR}/libvterm/.libs/libvterm.a)

ADD_CUSTOM_COMMAND(
  OUTPUT include/emacs-module.h
  COMMAND curl -SL https://github.com/emacs-mirror/emacs/raw/master/src/emacs-module.h --create-dirs -o include/emacs-module.h)
ADD_CUSTOM_TARGET(curl_emacs_module DEPENDS include/emacs-module.h)
ADD_DEPENDENCIES(vterm-core curl_emacs_module)
