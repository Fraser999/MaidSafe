project(Docopt)

include(${CMAKE_SOURCE_DIR}/cmake_modules/standard_setup.cmake)
include(${CMAKE_SOURCE_DIR}/cmake_modules/standard_flags.cmake)

file(GLOB Sources "${CMAKE_CURRENT_SOURCE_DIR}/*.cpp")
file(GLOB Headers "${CMAKE_CURRENT_SOURCE_DIR}/*.h")
add_library(docopt STATIC ${Sources} ${Headers})
target_include_directories(docopt PUBLIC "${PROJECT_SOURCE_DIR}")
set_target_properties(docopt PROPERTIES FOLDER "Third Party/Docopt")
