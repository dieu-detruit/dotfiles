cmake_minimum_required(VERSION 3.10)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

project(rc_compile LANGUAGES C CXX)

add_definitions(-DBINARY_PATH="${CMAKE_CURRENT_BINARY_DIR}")
add_executable(rc_compile main.cpp)
