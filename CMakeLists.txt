cmake_minimum_required(VERSION 3.3)
project(lua-5.3.1)

set(LUA_ROOT "${CMAKE_SOURCE_DIR}")
set(OUTPUT_ROOT "${LUA_ROOT}/output")

set(LUA_HEADER
	src/lapi.h
	src/lauxlib.h
	src/lcode.h
	src/lctype.h
	src/ldebug.h
	src/ldo.h
	src/lfunc.h
	src/lgc.h
	src/llex.h
	src/llimits.h
	src/lmem.h
	src/lobject.h
	src/lopcodes.h
	src/lparser.h
	src/lprefix.h
	src/lstate.h
	src/lstring.h
	src/ltable.h
	src/ltm.h
	src/lua.h
	src/luaconf.h
	src/lualib.h
	src/lundump.h
	src/lvm.h
	src/lzio.h
)
set(LUA_SOURCE
	src/lapi.c
	src/lauxlib.c
	src/lbaselib.c
	src/lbitlib.c
	src/lcode.c
	src/lcorolib.c
	src/lctype.c
	src/ldblib.c
	src/ldebug.c
	src/ldo.c
	src/ldump.c
	src/lfunc.c
	src/lgc.c
	src/linit.c
	src/liolib.c
	src/llex.c
	src/lmathlib.c
	src/lmem.c
	src/loadlib.c
	src/lobject.c
	src/lopcodes.c
	src/loslib.c
	src/lparser.c
	src/lstate.c
	src/lstring.c
	src/lstrlib.c
	src/ltable.c
	src/ltablib.c
	src/ltm.c
	src/lundump.c
	src/lutf8lib.c
	src/lvm.c
	src/lzio.c
)

if(MSVC)
	set(CMAKE_DEBUG_POSTFIX "d")
	add_definitions(-D_CRT_SECURE_NO_DEPRECATE)
    add_definitions(-D_CRT_NONSTDC_NO_DEPRECATE)
    include_directories(${CMAKE_CURRENT_SOURCE_DIR})
endif()


set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${OUTPUT_ROOT}/bin)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${OUTPUT_ROOT}/lib)
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${OUTPUT_ROOT}/lib)


add_library(lualib STATIC
	${LUA_HEADER}
	${LUA_SOURCE}
)
if(UNIX)
    target_link_libraries(lualib m)
endif()
set_target_properties(lualib PROPERTIES OUTPUT_NAME lua)
add_custom_target(lualib_prebuild ALL)
add_custom_command(TARGET lualib_prebuild PRE_BUILD
	COMMAND ${CMAKE_COMMAND} -E copy ${LUA_ROOT}/src/lua.h ${OUTPUT_ROOT}/include/lua.h
    COMMAND ${CMAKE_COMMAND} -E copy ${LUA_ROOT}/src/luaconf.h ${OUTPUT_ROOT}/include/luaconf.h
	COMMAND ${CMAKE_COMMAND} -E copy ${LUA_ROOT}/src/lualib.h ${OUTPUT_ROOT}/include/lualib.h
	COMMAND ${CMAKE_COMMAND} -E copy ${LUA_ROOT}/src/lauxlib.h ${OUTPUT_ROOT}/include/lauxlib.h
	COMMAND ${CMAKE_COMMAND} -E copy ${LUA_ROOT}/src/lua.hpp ${OUTPUT_ROOT}/include/lua.hpp
	COMMENT "Copy lua public headers to include directory."
)
add_custom_target(lualib_core_prebuild)
add_dependencies(lualib_prebuild lualib_core_prebuild)
add_dependencies(lualib lualib_prebuild)


# stand-alone lua interpret
add_executable(lua src/lua.c)
target_link_libraries(lua lualib)


# lua byte code compiler
add_executable(luac src/luac.c)
target_link_libraries(luac lualib)
