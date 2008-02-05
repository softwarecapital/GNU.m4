dnl Use `m4 -DNUL to print a NUL byte surrounded in [], then exit
ifdef(`NUL', `[ ]m4exit`'')dnl
# This file tests m4 behavior on NUL bytes.
dnl Use `m4 -Dm4exit' to test rest of file.
m4exit(`2 2')dnl
dnl Raw pass-through:
raw: - -
dnl Embedded in quotes:
quoted: `- -'
dnl Embedded in comments:
commented: #- -
dnl Passed through $1, $*, $@:
define(`echo', `.$1.$*.$@.')define(`', `empty')dnl
define(`-', `dash')define(`--', `dashes')dnl
user: echo(- -,`1 1')
dnl Macro name of define:
define(`- -', ``$0': $1')dnl
dnl All macros matching __*__ take no arguments, and never produce NUL.
dnl First argument of builtin:
errprint(`builtin:
')builtin(`- -')dnl
dnl Remaining arguments of builtin:
`builtin:' builtin(`len', - -)
dnl Single-byte delimiter in changecom:
`changecom:' changecom( ,/) echo/changecom(`/',` ')/echo dnl
dnl Multi-byte delimiter in changecom:
 changecom(`- -', ` - ')- -echo  - changecom(`#')
dnl Single-byte delimiter in changequote:
`changequote:' changequote( ,/) echo/changequote`'dnl
changequote(`/',` ')/echo changequote`'dnl
dnl Multi-byte delimiter in changequote:
 changequote(`- -', ` - ')- -echo  - changequote`'
dnl Quotes in trace and dump output:
errprint(`changequote:
')traceon(`dumpdef')dumpdef(`echo'changequote( ,/))changequote`'dnl
traceoff(`dumpdef')dnl
dnl Used in changeword (if changeword available):
`changeword:' ifdef(`changeword', `', `define(`changeword')define(`c')')dnl
changeword(`[-_a-zA-Z0-9 ]+')-  - dnl
ifdef(`c', `- -: dash', `- -(-)')`'changeword()dnl
dnl Bad regex in changeword:
errprint(`changeword:
')changeword(`\ \')
ifdef(`c', `errprint(__program__:__file__:decr(__line__): Warning: dnl
`changeword: bad regular expression `\\\0\\': Trailing backslash
')')dnl
dnl Warning from debugfile:
errprint(`debugfile:
')debugfile(`/no/such /file')dnl
dnl Warning from debugmode:
errprint(`debugmode:
')debugmode(`- -')dnl
dnl Warning from decr:
errprint(`decr:
')decr(`1 1')dnl
dnl Definition of define:
`define:' define(`body', `- -')body
dnl Undefined argument of defn:
errprint(`defn:
')defn(` - ')dnl
dnl Defined macro name in defn:
`defn:' defn(`- -')dnl
dnl Macro contents in defn:
 defn(`body')
dnl Argument to divert:
errprint(`divert:
')divert(`1 1')dnl
dnl Passed through diversion by divert:
divert(`1')`divert:' - -
divert`'undivert(`1')dnl
dnl Divnum takes no arguments, and never produces NUL.
dnl Discarded by dnl: - -
dnl Undefined argument of dumpdef:
errprint(`dumpdef:
')dumpdef(` - ')dnl
dnl Defined macro names in dumpdef:
dumpdef(`- -', `-', `', `- -', `--')dnl
dnl Macro contents in dumpdef:
dumpdef(`body')dnl
dnl Passed through errprint:
errprint(`errprint:' - -, `- -
')dnl
dnl Passed to esyscmd:
`esyscmd:'errprint(`esyscmd:
') esyscmd(`echo + +')sysval dnl
dnl Generated from esyscmd:
esyscmd(__program__` -DNUL '__file__) sysval
dnl First argument of eval:
errprint(`eval:
')eval(`1 +1')dnl
dnl Second argument of eval:
eval(`1', `2 2')dnl
dnl Third argument of eval:
eval(`1', `10', `1 1')dnl
dnl First argument to format:
`format:' format(`%s %s', `-', `-')dnl
dnl Invalid specifier in format:
errprint(`format:
') format(`% %')dnl
dnl Numeric and string arguments to format:
 format(`%d%s', `1 1', `- -')
dnl Character argument to format: not tested yet, %c semantics needed
dnl Macro name in ifdef, passed through ifdef:
`ifdef:' ifdef(`- -', `yes: - -', `oops: - -')dnl
 ifdef( , `oops: - -', `no: - -')
dnl Compared in ifelse, passed through ifelse:
`ifelse:' ifelse(`-', `- -', `oops', `- -', - -, `yes: - -')
dnl Warning from include:
errprint(`include:
')include(`/no/such /file')dnl
dnl Warning from incr:
errprint(`incr:
')incr(`1 1')dnl
dnl Passed through index:
`index:' index(`a b', `b') index(`-', ` ') index(` ', `-')dnl
 index(`                -', `        -')
dnl Defined first argument of indir:
`indir:' indir(`- -', 1 1)dnl
dnl Undefined first argument of indir:
errprint(`indir:
')indir(` - ')dnl
dnl Warning issued via indir:
 define(`  %%', defn(`divnum'))indir(`  %%', `extra')dnl
dnl Other arguments of indir:
 indir(`len', `- -')
dnl Passed through len:
`len:' len( ) len(- -)
dnl Test m4exit separately from m4wrap; see above.
dnl Passed through m4wrap:
m4wrap(``m4wrap:' - -
')dnl
dnl Warning from maketemp:
errprint(`maketemp:
')maketemp(`/no/such /file')dnl
dnl Warning from mkstemp:
errprint(`mkstemp:
')mkstemp(`/no/such /file')dnl
dnl Bad regex in patsubst:
errprint(`patsubst:
')patsubst(`a', `\ \')dnl
dnl First argument of patsubst:
`patsubst:' patsubst(`- -', `-', `.')dnl
dnl Matching via meta-character in patsubst:
 patsubst(`- -', `[^-]')dnl
dnl Second argument of patsubst:
 patsubst(`abc', ` b', `-') patsubst(`- -', ` ', `!')dnl
dnl Third argument of patsubst:
 patsubst(`-!-', `!', ` ')dnl
dnl Replacement via reference in patsubst:
 patsubst(`-- --', `-\(.\)-', `\1-\1')
dnl Defined argument of popdef:
`popdef:' popdef(`- -')ifdef(`- -', `oops', `ok')
dnl Undefined argument of popdef: not tested yet. Should it warn?
dnl Macro name of pushdef:
`pushdef:' pushdef(`- -', `strange: $1')ifdef(`- -', `ok', `oops')`'dnl
dnl Definition of pushdef:
 pushdef(`body', ` - ')body
dnl Bad regex in regexp:
errprint(`regexp:
')regexp(`a', `\ \')dnl
dnl First argument of regexp:
`regexp:' regexp(`a b', `b')dnl
dnl Matching via meta-character in regexp:
 regexp(`- -', `[^-]', `!')dnl
dnl Second argument of regexp:
 regexp(`- -', ` ')dnl
dnl Third argument of regexp:
 regexp(`!', `!', `- -')dnl
dnl Replacement via reference in regexp:
 regexp(`-- --', `-\(.\)-', `\1-\1')
dnl Passed through shift:
`shift:' shift(`hi', `- -', - -)
dnl Warning from sinclude:
errprint(`sinclude:
')sinclude(`/no/such /file')dnl
dnl First argument of substr:
`substr:' substr(`-- --', `1', `3')
dnl Second argument of substr:
errprint(`substr:
')substr(`abc', `1 1')dnl
dnl Third argument of substr:
substr(`abc', `1', `1 1')dnl
dnl Passed to syscmd:
`syscmd:'errprint(`syscmd:
') syscmd(`echo + +')sysval
dnl Sysval takes no arguments, and never produces NUL.
dnl Passed to traceoff:
traceoff(`- -', ` ')dnl
dnl Macro name and arguments of traceon:
`traceon:' errprint(`traceon:
')traceon(`- -')indir(`- -', `- -')dnl
dnl Defined text of traceon:
 traceon(`body')body
dnl First argument of translit:
`translit:' translit(`. .', `.', `-')dnl
dnl Single character in other arguments of translit:
 translit(` . ', `. ', ` .')dnl
dnl Character ranges of translit:
 translit(`abcd', ` -b')
dnl Defined argument of undefine:
`undefine:' undefine(`- -')ifdef(`- -', `oops', `ok')
dnl Undefined argument of undefine: not tested yet. Should it warn?
dnl Warning from undivert:
errprint(`undivert:
')undivert(`1 1')dnl
