#==================================================================================================#
#                                                                                                  #
#  Copyright 2014 MaidSafe.net limited                                                             #
#                                                                                                  #
#  This MaidSafe Software is licensed to you under (1) the MaidSafe.net Commercial License,        #
#  version 1.0 or later, or (2) The General Public License (GPL), version 3, depending on which    #
#  licence you accepted on initial access to the Software (the "Licences").                        #
#                                                                                                  #
#  By contributing code to the MaidSafe Software, or to this project generally, you agree to be    #
#  bound by the terms of the MaidSafe Contributor Agreement, version 1.0, found in the root        #
#  directory of this project at LICENSE, COPYING and CONTRIBUTOR respectively and also available   #
#  at: http://www.maidsafe.net/licenses                                                            #
#                                                                                                  #
#  Unless required by applicable law or agreed to in writing, the MaidSafe Software distributed    #
#  under the GPL Licence is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF   #
#  ANY KIND, either express or implied.                                                            #
#                                                                                                  #
#  See the Licences for the specific language governing permissions and limitations relating to    #
#  use of the MaidSafe Software.                                                                   #
#                                                                                                  #
#==================================================================================================#
#                                                                                                  #
#  Module used to locate clang-format executable.                                                  #
#                                                                                                  #
#  Variables set and cached by this module are:                                                    #
#    ClangFormatExe                                                                                #
#                                                                                                  #
#==================================================================================================#


set(ClangFormatMinimumVersion 3.6)

macro(CheckClangFormatVersion)
  execute_process(COMMAND ${ClangFormatExe} --version RESULT_VARIABLE ResultVar OUTPUT_VARIABLE OutputVar ERROR_QUIET)
  string(REGEX MATCH "version ([0-9]\\.[0-9]\\.[0-9])" OutputVar "${OutputVar}")
  set(ClangFormatVersion "${CMAKE_MATCH_1}")
  if("${ClangFormatVersion}" VERSION_LESS "${ClangFormatMinimumVersion}")
    set(ClangFormatExe "ClangFormatExe-NOTFOUND" CACHE FILEPATH "Path to clang-format version ${ClangFormatMinimumVersion} or greater." FORCE)
    if(NeedsMessageOnFailure)
      message(STATUS "Found clang-format version ${ClangFormatVersion}, but the included .clang-format file requires ${ClangFormatMinimumVersion} minimum.")
    endif()
  endif()
endmacro()

if(ClangFormatExe)
  # Check the exe path and version is still correct
  CheckClangFormatVersion()
  if(ClangFormatExe)
    return()
  endif()
  set(NeedsMessageOnFailure ON)
endif()

if(NOT DEFINED ClangFormatExe)
  set(NeedsMessageOnFailure ON)
endif()

find_program(ClangFormatExe NAMES clang-format)

if(ClangFormatExe)
  CheckClangFormatVersion()
  if(ClangFormatExe)
    message(STATUS "Found clang-format version ${ClangFormatVersion}")
  endif()
elseif(NeedsMessageOnFailure)
  message(STATUS "Couldn't find clang-format.")
endif()
