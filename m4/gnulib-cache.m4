# Copyright (C) 2002-2009 Free Software Foundation, Inc.
#
# This file is free software, distributed under the terms of the GNU
# General Public License.  As a special exception to the GNU General
# Public License, this file may be distributed as part of a program
# that contains a configuration script generated by Autoconf, under
# the same distribution terms as the rest of that program.
#
# Generated by gnulib-tool.
#
# This file represents the specification of how gnulib-tool is used.
# It acts as a cache: It is written and read by gnulib-tool.
# In projects using CVS, this file is meant to be stored in CVS,
# like the configure.ac and various Makefile.am files.


# Specification in the form of a command-line invocation:
#   gnulib-tool --import --dir=. --local-dir=local --lib=libm4 --source-base=lib --m4-base=m4 --doc-base=doc --tests-base=tests --aux-dir=build-aux --with-tests --avoid=lock-tests --avoid=tls-tests --no-libtool --macro-prefix=M4 announce-gen assert autobuild avltree-oset binary-io c-stack clean-temp cloexec close-stream closein config-h dirname error execute fdl-1.3 fflush filenamecat fopen fopen-safer fseeko gendocs getopt-gnu git-version-gen gnumakefile gnupload gpl-3.0 intprops memchr2 mkstemp obstack pipe progname regex sigaction stdbool stdint stdlib-safer strsignal strstr strtod strtol unlocked-io verror version-etc version-etc-fsf wait-process xalloc xprintf xvasprintf-posix

# Specification in the form of a few gnulib-tool.m4 macro invocations:
gl_LOCAL_DIR([local])
gl_MODULES([
  announce-gen
  assert
  autobuild
  avltree-oset
  binary-io
  c-stack
  clean-temp
  cloexec
  close-stream
  closein
  config-h
  dirname
  error
  execute
  fdl-1.3
  fflush
  filenamecat
  fopen
  fopen-safer
  fseeko
  gendocs
  getopt-gnu
  git-version-gen
  gnumakefile
  gnupload
  gpl-3.0
  intprops
  memchr2
  mkstemp
  obstack
  pipe
  progname
  regex
  sigaction
  stdbool
  stdint
  stdlib-safer
  strsignal
  strstr
  strtod
  strtol
  unlocked-io
  verror
  version-etc
  version-etc-fsf
  wait-process
  xalloc
  xprintf
  xvasprintf-posix
])
gl_AVOID([lock-tests tls-tests])
gl_SOURCE_BASE([lib])
gl_M4_BASE([m4])
gl_PO_BASE([])
gl_DOC_BASE([doc])
gl_TESTS_BASE([tests])
gl_WITH_TESTS
gl_LIB([libm4])
gl_MAKEFILE_NAME([])
gl_MACRO_PREFIX([M4])
gl_PO_DOMAIN([])
