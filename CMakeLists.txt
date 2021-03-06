cmake_minimum_required(VERSION 3.18)

project(SkyCore)

set(CMAKE_DEBUG_POSTFIX d)
set(CMAKE_CXX_VISIBILITY_PRESET hidden)
set(CMAKE_VISIBILITY_INLINES_HIDDEN 1)

#
# 3rd party dependencies
#
find_package(Qt5 COMPONENTS
  Core Gui Widgets Qml Script ScriptTools
  Network Widgets Xml XmlPatterns
  REQUIRED
)
set(SK_NOSCRIPT TRUE)

include(macroWrapQtResources.cmake)
include(files.cmake)

set(SkyCore_TARGET_LIBRARIES)

if(QT_DEFAULT_MAJOR_VERSION GREATER 4)
  message("QT_DEFAULT_MAJOR_VERSION = ${QT_DEFAULT_MAJOR_VERSION}")
  list(APPEND SkyCore_TARGET_LIBRARIES
    Qt5::Core Qt5::Gui Qt5::Script Qt5::ScriptTools Qt5::Network Qt5::Widgets Qt5::Qml
    Qt5::Xml Qt5::XmlPatterns)
  message("SkyCore_TARGET_LIBRARIES = ${SkyCore_TARGET_LIBRARIES}")
else()
  list(APPEND SkyCore_TARGET_LIBRARIES QT_LIBRARIES)
endif()

list(APPEND SkyCore_TARGET_LIBRARIES QuaZip)

if(NOT DEFINED BUILD_SHARED_LIBS)
  set(TYPE_OF_LIBRARY "STATIC")
else()
  set(TYPE_OF_LIBRARY "SHARED")
endif()

#[[
wrapQtResources(
  NAME ${PROJECT_NAME}
  SRCS ${KIT_SRCS}
  MOC_SRCS ${KIT_MOC_SRCS}
  #UI_FORMS ${KIT_UI_FORMS}
  #GENERATE_MOC_SRCS ${KIT_MOC_SRCS}
  #RESOURCES 
  LIBRARY_TYPE ${TYPE_OF_LIBRARY}
  LINKED_LIBRARIES ${SkyCore_TARGET_LIBRARIES}
  INCLUDES
    PUBLIC|${PROJECT_BINARY_DIR}  
    PUBLIC|${PROJECT_SOURCE_DIR}
    PUBLIC|include
    #PRIVATE|include/private
    PRIVATE|${QuaZip_Library_SOURCE_DIR}
    PRIVATE|src/3rdparty/qtsingleapplication
    #PRIVATE|src/global
    ##[[
    PRIVATE|src/controllers
    PRIVATE|src/io
    PRIVATE|src/kernel
    PRIVATE|src/network
    PRIVATE|src/plugin
    #PRIVATE|src/script
    PRIVATE|src/thread
    #]
    
  EXPORT_NAME "SKY_CORE_EXPORT"
  
)
]]
if(QT_DEFAULT_MAJOR_VERSION VERSION_GREATER "4")
  foreach(moc_src ${KIT_MOC_SRCS})
    message("moc_src = ${moc_src}")
    qt5_wrap_cpp(MY_MOC_CPP ${moc_src})
  endforeach()
else()
  foreach(moc_src ${KIT_MOC_SRCS})
    QT4_WRAP_CPP(MY_MOC_CPP ${moc_src})
  endforeach()
endif()


add_library(${PROJECT_NAME} SHARED ${KIT_SRCS} ${KIT_MOC_SRCS} ${MY_MOC_CPP})

target_link_libraries(${PROJECT_NAME} ${SkyCore_TARGET_LIBRARIES})

include_directories(
  ${PROJECT_BINARY_DIR}
  include
  include/3rdparty/qtsingleapplication
  include/global
  include/private
  #include/thread
  )

#target_include_directories(${PROJECT_NAME} PUBLIC include)
#target_include_directories(${PROJECT_NAME} PRIVATE include/private)

add_definitions(-DQT_${QT_DEFAULT_MAJOR_VERSION} -DQT_LATEST -DSK_NO_SCRIPT -DSK_NO_CONTROLLERFILE)

target_compile_features(${PROJECT_NAME} PUBLIC cxx_std_11)

include(GenerateExportHeader)
generate_export_header(${PROJECT_NAME}
  BASE_NAME "SkyCore"
  EXPORT_MACRO_NAME "SKY_CORE_EXPORT"
  EXPORT_FILE_NAME "SkyCoreExports.h"
  )
  #[[
install(
  TARGETS
    ${PROJECT_NAME}
  ARCHIVE
    DESTINATION ${INSTALL_LIBDIR}
    COMPONENT lib
  RUNTIME
    DESTINATION ${INSTALL_BINDIR}
    COMPONENT bin
  LIBRARY
    DESTINATION ${INSTALL_LIBDIR}
    COMPONENT lib
  PUBLIC_HEADER
    DESTINATION ${INSTALL_INCLUDEDIR}/src
    COMPONENT dev
  )
  ]]
  
add_subdirectory(externals)