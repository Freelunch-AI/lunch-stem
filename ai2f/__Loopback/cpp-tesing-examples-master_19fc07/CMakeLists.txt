cmake_minimum_required(VERSION 2.6)
PROJECT(testing)

ENABLE_TESTING()

ADD_DEFINITIONS(-g -Wall -ansi -Wno-deprecated -DBOOST_TEST_DYN_LINK)

SET(Boost_USE_STATIC_LIBS OFF)
SET(Boost_USE_MULTITHREAD ON)
FIND_PACKAGE(Boost 1.37.0 REQUIRED COMPONENTS unit_test_framework)
IF(Boost_FOUND)
  INCLUDE_DIRECTORIES(${Boost_INCLUDE_DIRS})
  LINK_DIRECTORIES(${Boost_LIBRARY_DIRS})
ENDIF(Boost_FOUND)

#FIND_PACKAGE(GTest REQUIRED)
# TODO: also add cmake detector for Google Mock

ADD_EXECUTABLE(boost-test1 boost-test1.cpp)
IF(UNIX)
  TARGET_LINK_LIBRARIES(boost-test1 ${Boost_UNIT_TEST_FRAMEWORK_LIBRARY})
ENDIF(UNIX)
ADD_TEST(boost-test1 boost-test1)

ADD_EXECUTABLE(boost-test2 boost-test2.cpp)
IF(UNIX)
  TARGET_LINK_LIBRARIES(boost-test2 ${Boost_UNIT_TEST_FRAMEWORK_LIBRARY})
ENDIF(UNIX)
ADD_TEST(boost-test2 boost-test2)

ADD_EXECUTABLE(boost-test3 boost-test3.cpp)
IF(UNIX)
  TARGET_LINK_LIBRARIES(boost-test3 ${Boost_UNIT_TEST_FRAMEWORK_LIBRARY})
ENDIF(UNIX)
ADD_TEST(boost-test3 boost-test3)

ADD_EXECUTABLE(test-gmock test-gmock.cpp)
TARGET_LINK_LIBRARIES(test-gmock gmock gtest)
IF(UNIX)
  TARGET_LINK_LIBRARIES(test-gmock ${Boost_UNIT_TEST_FRAMEWORK_LIBRARY})
ENDIF(UNIX)
ADD_TEST(test-gmock test-gmock)


