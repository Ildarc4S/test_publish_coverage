cmake_minimum_required(VERSION 3.16)
project(HelloCoverage LANGUAGES CXX)

# Стандарт C++
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Включаем поддержку тестов
include(CTest)
enable_testing()

# Добавляем опции для сборки с покрытием
option(COVERAGE "Enable coverage reporting" OFF)
if(COVERAGE)
    message(STATUS "Building with code coverage enabled")
    add_compile_options(--coverage -O0 -g)
    link_libraries(--coverage)
endif()

find_package(GTest REQUIRED)

add_library(hello_lib src/hello.cpp src/hello.h)

add_executable(test_hello tests/test_hello.cpp)
target_include_directories(test_hello PRIVATE ${CMAKE_SOURCE_DIR}/src)
target_link_libraries(test_hello PRIVATE hello_lib GTest::gtest_main)


# Регистрируем тест для CTest
add_test(NAME HelloTest COMMAND test_hello)

# Цель для генерации отчета покрытия (использует lcov/genhtml)
find_program(LCOV lcov)
find_program(GENHTML genhtml)

if(COVERAGE AND LCOV AND GENHTML)
    set(COVERAGE_OUTPUT_DIR "${CMAKE_BINARY_DIR}/coverage")

    add_custom_target(coverage
        COMMAND ${CMAKE_COMMAND} -E remove_directory ${COVERAGE_OUTPUT_DIR}
        COMMAND ${LCOV} --capture --directory ${CMAKE_BINARY_DIR} --output-file coverage.info --ignore-errors inconsistent
        COMMAND ${LCOV} --remove coverage.info '/usr/*' --output-file coverage_filtered.info
        COMMAND ${GENHTML} --output-directory ${COVERAGE_OUTPUT_DIR} coverage_filtered.info
        COMMENT "Generating code coverage report"
    )
endif()

