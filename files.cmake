
set(KIT_MOC_SRCS)

#file(GLOB_RECURSE KIT_MOC_SRCS RELATIVE "${CMAKE_CURRENT_SOURCE_DIR}" "${CMAKE_CURRENT_SOURCE_DIR}/src/*.h")

file(GLOB_RECURSE KIT_MOC_SRCS RELATIVE "${CMAKE_CURRENT_SOURCE_DIR}" "${CMAKE_CURRENT_SOURCE_DIR}/include/*")

#list(APPEND KIT_MOC_SRCS ${KIT_INCLUDE})

file(GLOB_RECURSE KIT_SRCS RELATIVE "${CMAKE_CURRENT_SOURCE_DIR}" "${CMAKE_CURRENT_SOURCE_DIR}/src/*.cpp")

#list(APPEND KIT_SRCS ${KIT_MOC_SRCS})

message("KIT_SRCS = ${KIT_SRCS}")
message("")
message("KIT_MOC_SRCS = ${KIT_MOC_SRCS}")
message("")
if(DEFINED SK_NOSCRIPT)
  message("SK_NOSCRIPT COOL!")
  list(REMOVE_ITEM KIT_SRCS "src/script/WScript.cpp")
  list(REMOVE_ITEM KIT_SRCS "src/script/WScript_p.h")
  list(REMOVE_ITEM KIT_SRCS "src/script/WScript.h")
  list(REMOVE_ITEM KIT_MOC_SRCS "src/script/WScript.cpp")
  list(REMOVE_ITEM KIT_MOC_SRCS "src/script/WScript_p.h")
  list(REMOVE_ITEM KIT_MOC_SRCS "src/script/WScript.h")
endif()