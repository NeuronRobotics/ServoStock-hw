# Install script for directory: /home/hpham/the-technocopia-project/third-party/free-cad/src

# Set the install prefix
IF(NOT DEFINED CMAKE_INSTALL_PREFIX)
  SET(CMAKE_INSTALL_PREFIX "/usr/local")
ENDIF(NOT DEFINED CMAKE_INSTALL_PREFIX)
STRING(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
IF(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  IF(BUILD_TYPE)
    STRING(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  ELSE(BUILD_TYPE)
    SET(CMAKE_INSTALL_CONFIG_NAME "")
  ENDIF(BUILD_TYPE)
  MESSAGE(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
ENDIF(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)

# Set the component getting installed.
IF(NOT CMAKE_INSTALL_COMPONENT)
  IF(COMPONENT)
    MESSAGE(STATUS "Install component: \"${COMPONENT}\"")
    SET(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  ELSE(COMPONENT)
    SET(CMAKE_INSTALL_COMPONENT)
  ENDIF(COMPONENT)
ENDIF(NOT CMAKE_INSTALL_COMPONENT)

# Install shared libraries without execute permission?
IF(NOT DEFINED CMAKE_INSTALL_SO_NO_EXE)
  SET(CMAKE_INSTALL_SO_NO_EXE "1")
ENDIF(NOT DEFINED CMAKE_INSTALL_SO_NO_EXE)

IF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/doc" TYPE FILE FILES
    "/home/hpham/the-technocopia-project/third-party/free-cad/src/Doc/Start_Page.html"
    "/home/hpham/the-technocopia-project/third-party/free-cad/src/Doc/freecad.qhc"
    "/home/hpham/the-technocopia-project/third-party/free-cad/src/Doc/freecad.qch"
    )
ENDIF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")

IF(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for each subdirectory.
  INCLUDE("/home/hpham/the-technocopia-project/third-party/free-cad-build/src/Build/cmake_install.cmake")
  INCLUDE("/home/hpham/the-technocopia-project/third-party/free-cad-build/src/3rdParty/cmake_install.cmake")
  INCLUDE("/home/hpham/the-technocopia-project/third-party/free-cad-build/src/Base/cmake_install.cmake")
  INCLUDE("/home/hpham/the-technocopia-project/third-party/free-cad-build/src/App/cmake_install.cmake")
  INCLUDE("/home/hpham/the-technocopia-project/third-party/free-cad-build/src/Main/cmake_install.cmake")
  INCLUDE("/home/hpham/the-technocopia-project/third-party/free-cad-build/src/Mod/cmake_install.cmake")
  INCLUDE("/home/hpham/the-technocopia-project/third-party/free-cad-build/src/Gui/cmake_install.cmake")
  INCLUDE("/home/hpham/the-technocopia-project/third-party/free-cad-build/src/Doc/cmake_install.cmake")

ENDIF(NOT CMAKE_INSTALL_LOCAL_ONLY)
