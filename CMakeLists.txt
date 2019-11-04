cmake_minimum_required(VERSION 3.0)

project(hello C ASM) 

set(CMAKE_VERBOSE_MAKEFILE ON)

set(OBJS ${CMAKE_CURRENT_SOURCE_DIR}/objects)

set (CMAKE_C_FLAGS "-fno-stack-protector")

set_source_files_properties(boot.S PROPERTIES COMPILE_FLAGS "-fpic")
set_source_files_properties(stub.S PROPERTIES COMPILE_FLAGS "-fpic")

set(SRC_LIST source/boot.S source/main.c source/stub.S setup.ld)

set(LINKER_SCRIPT ${CMAKE_SOURCE_DIR}/setup.ld)

set(OBJECTS ${CMAKE_CURRENT_BINARY_DIR}/CMakeFiles/${PROJECT_NAME}.so.dir/source)

set(CMAKE_C_LINK_EXECUTABLE "ld -T ${LINKER_SCRIPT} ${OBJECTS}/main.c.o ${OBJECTS}/boot.S.o ${OBJECTS}/stub.S.o -o ${PROJECT_NAME}.so")

add_executable(${PROJECT_NAME}.so ${SRC_LIST})

add_custom_command(TARGET  ${PROJECT_NAME}.so COMMAND objcopy -j .header -j .text -j .init -j .data -j .rodata -j .reloc -O binary ${PROJECT_NAME}.so ${PROJECT_NAME}.efi DEPENDS ${PROJECT_NAME}.so)

add_custom_target(${PROJECT_NAME}.efi ALL DEPENDS ${PROJECT_NAME}.so) 
