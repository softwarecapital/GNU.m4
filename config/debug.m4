##                                                           -*- Autoconf -*-
## debug.m4 -- massage compiler flags for debugging/optimisation
##
## Copyright 1999-2000 Ralf S. Engelschall
## Written by <rse@engelschall.com>
## Modified for M4 by Gary V. Vaughan <gary@gnu.org>
##
## This program is free software; you can redistribute it and/or modify
## it under the terms of the GNU General Public License as published by
## the Free Software Foundation; either version 2 of the License, or
## (at your option) any later version.
##
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
##
## You should have received a copy of the GNU General Public License
## along with this program; see the file COPYING.  If not, write to
## the Free Software Foundation, Inc., 59 Temple Place - Suite 330,
## Boston, MA 02111-1307, USA.

# serial 4

# M4_AC_CHECK_DEBUGGING
# ---------------------
# Debugging Support
AC_DEFUN([M4_AC_CHECK_DEBUGGING],
[AC_REQUIRE([AC_PROG_CC])
AC_ARG_ENABLE([debug], [AC_HELP_STRING([--enable-debug],
                           [build for debugging [default=no]])])
AC_MSG_CHECKING(for compilation debug mode)
AC_MSG_RESULT([${enable_debug-no}])

set dummy $CC
compiler="${compiler-[$]2}"
test -n "$rm" || rm="rm -f"

if test "X$enable_debug" = Xyes; then
  AC_DISABLE_SHARED
  AC_DEFINE([DEBUG], 1,
      [Define this to enable additional runtime debugging])
  if test "$GCC" = yes; then
    case "$CFLAGS" in
      *-O* ) CFLAGS=`echo $CFLAGS | sed 's/-O[[^ ]]* / /;s/-O[[^ ]]*$//'` ;;
    esac
    case "$CFLAGS" in
        *-g* ) ;;
         * ) AC_LIBTOOL_COMPILER_OPTION([if $compiler accepts -ggdb3],
                 [m4_cv_prog_compiler_ggdb3],
                 [-ggdb3 -c conftest.$ac_ext], [],
                 [CFLAGS="$CFLAGS -ggdb3"],
               [CFLAGS="$CFLAGS -g"])
             ;;
    esac
    CFLAGS="$CFLAGS -Wall"
    WMORE="-Wshadow -Wpointer-arith -Wcast-align -Wnested-externs"
    WMORE="$WMORE -Wmissing-prototypes -Wmissing-declarations -Winline"
    AC_LIBTOOL_COMPILER_OPTION([if $compiler accepts $WMORE],
        [m4_cv_prog_compiler_warning_flags],
        [$WMORE -c conftest.$ac_ext], [],
        [CFLAGS="$CFLAGS $WMORE"])

    AC_LIBTOOL_COMPILER_OPTION([if $compiler accepts -Wno-long-long],
        [m4_cv_prog_compiler_wnolonglong],
        [-Wno-long-long -c conftest.$ac_ext], [],
        [CFLAGS="$CFLAGS -Wno-long-long"])
  else
    case "$CFLAGS" in
        *-g* ) ;;
           * ) CFLAGS="$CFLAGS -g" ;;
    esac
  fi
else
  AC_ENABLE_SHARED
  case "$CFLAGS" in
    *-g* ) CFLAGS=`echo "$CFLAGS" |\
               sed -e 's/ -g / /g;s/ -g$//;s/^-g //g;s/^-g$//'`
           ;;
  esac
  case "$CXXFLAGS" in
    *-g* ) CXXFLAGS=`echo "$CXXFLAGS" |\
               sed -e 's/ -g / /g;s/ -g$//;s/^-g //g;s/^-g$//'`
           ;;
  esac
fi
])# M4_AC_CHECK_DEBUGGING
