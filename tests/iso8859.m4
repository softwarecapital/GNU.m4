dnl Copyright (C) 2006-2007, 2010, 2013-2014, 2017 Free Software
dnl Foundation, Inc.
dnl This file is free software; the Free Software Foundation
dnl gives unlimited permission to copy and/or distribute it
dnl with or without modifications, as long as this notice is preserved.
# Testing quotes
DEFINE			define(`test', `TEST')# eol
CHANGEQUOTE(�,�)	changequote(�,�)# eol
0 test			# TEST
1 �test�			# test
2 ��test��		# �test�
3 ���test���		# ��test��
dnl
changequote()dnl
CHANGEQUOTE(���,���)	changequote(���,���)# eol
0 test			# TEST
1 �test�		# �TEST�
2 ��test��		# ��TEST��
3 ���test���			# test
changequote`'dnl
dnl
dnl
# Test use of all iso8859 characters except ^Z (win32 EOF) and NUL  ` '
define(`noquotes', `	\n
 !"#$%&()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_abcdefghijklmnopqrstuvwxyz{|}~��������������������������������������������������������������������������������������������������������������������������������')dnl
dnl
`Length of string is: 'len(defn(`noquotes'))
`Comparing strings: 'ifelse(defn(`noquotes'), `	\n
 !"#$%&()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_abcdefghijklmnopqrstuvwxyz{|}~��������������������������������������������������������������������������������������������������������������������������������', `MATCH', `NO MATCH')
dnl
dnl
# NUL passes through now!
define(`NUL_bug', `This will be seen. This will never be seen')dnl
len(NUL_bug)
