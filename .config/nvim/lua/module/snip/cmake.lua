local indent = require'snippets.utils'.match_indentation

local cmake = {
  init = indent [[
cmake_minimum_required(VERSION ${1:3.18})
project(${2:ProjectName})

find_package(${3:library})

include_directories(${3}_INCLUDE_DIRS})

add_subdirectory(${4:src})

add_executable($2)

target_link_libraries($2 ${3}_LIBRARIES})]],
  proj = [[project(${1:Name})]],
  min = [[cmake_minimum_required(VERSION ${1:3.18})]],
  include = [[include_directories(\${${1:include_dir}})]],
  find = [[find_package(${1:library} ${2:REQUIRED})]],
  glob = [[file(glob ${1:src} *.${2:cpp})]],
  subdir = [[add_subdirectory(${1:src})]],
  lib = [[add_library(${1:lib} \${${2:src}})]],
  link = [[target_link_libraries(${1:bin} ${2:somelib})]],
  bin = [[add_executable(${1:bin})]],
  set = [[set(${1:var} ${2:val})]],
  dep = indent [[
add_dependencies(${1:target}
	${2:dep}
)]],
  Ext_url = indent [[
include(ExternalProject)
ExternalProject_Add(${1:googletest}
  URL               ${2:http://googletest.googlecode.com/files/gtest-1.7.0.zip}
  URL_HASH          SHA1=${3:f85f6d2481e2c6c4a18539e391aa4ea8ab0394af}
  SOURCE_DIR        "${4:\${CMAKE_BINARY_DIR}/gtest-src}"
  BINARY_DIR        "${5:\${CMAKE_BINARY_DIR}/gtest-build}"
  CONFIGURE_COMMAND ""
  BUILD_COMMAND     ""
  INSTALL_COMMAND   ""
  TEST_COMMAND      ""
)]],
  Ext_git = indent [[
include(ExternalProject)
ExternalProject_Add(${1:googletest}
  GIT_REPOSITORY    ${2:https://github.com/google/googletest.git}
  GIT_TAG           ${3:master}
  SOURCE_DIR        "${4:\${CMAKE_BINARY_DIR}/googletest-src}"
  BINARY_DIR        "${5:\${CMAKE_BINARY_DIR}/googletest-build}"
  CONFIGURE_COMMAND ""
  BUILD_COMMAND     ""
  INSTALL_COMMAND   ""
  TEST_COMMAND      ""
)]],
  props = indent [[
set_target_properties(${1:target}
  ${2:properties} ${3:compile_flags}
  ${4:"-O3 -Wall -pedantic"}
)]],
  test = [[add_test(${1:ATestName} ${2:testCommand --options})]],
}

local m = {}

m.get_snippets = function()
  return cmake
end

return m
