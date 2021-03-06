cmake_minimum_required (VERSION 3.9)
project (nix-plugins)
set (nix-plugins_VERSION_MAJOR 6)
set (nix-plugins_VERSION_MINOR 0)
set (nix-plugins_VERSION_PATCH 0)

find_package(PkgConfig)

pkg_check_modules(NIX REQUIRED nix-expr>=2.1.1 nix-main>=2.1.1 nix-store>=2.1.1)

find_path(BOOST_INCLUDE_DIR boost/format.hpp)
if(BOOST_INCLUDE_DIR STREQUAL "BOOST_INCLUDE_DIR-NOTFOUND")
  message(FATAL_ERROR "Could not find Boost formatting library.")
endif()
include_directories(${BOOST_INCLUDE_DIR})

if(APPLE)
  set(CMAKE_MODULE_LINKER_FLAGS "${CMAKE_MODULE_LINKER_FLAGS} -flat_namespace -undefined suppress")
endif()

add_library(unsafePlugins MODULE unsafePlugins.cc)
target_include_directories(unsafePlugins PUBLIC ${CMAKE_CURRENT_BINARY_DIR})
target_include_directories(unsafePlugins PUBLIC ${NIX_INCLUDE_DIRS})
target_compile_options(unsafePlugins PUBLIC ${NIX_CFLAGS_OTHER})

install(TARGETS unsafePlugins DESTINATION lib/nix/plugins)
