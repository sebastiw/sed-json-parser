# sed -nr 's/.*"'"$key"'"\s*:\s*"//;tl;$q1;T;:l;s/".*//;p;tq;$q2;n;bl;:q;q'
:oneliner
N
$!b oneliner
s/\s//g

:newnewlines
s/,/,\n/g
s/\([][}{]\)/\1\n/g






# :object
# /^{}$/{b ok}
# s/^{//; s/}$//

# :members
# /^"":val$/
# /"":val,/{b members}

# :objectstart
# # /^{/!q1
# /^{}$/q0
# s/^{//; s/}$//
# :key
# s/"[^"]\+":/:/g
# # !{q 2}
# :value
# s/:"[^"]*",\?//g # is string
# s/:-\?[0-9.]\+,\?//g # is number/float
# s/:\(true\|false\|null\),\?//g # is bool
# # TODO: check the array properly:
# s/:\[[^]]*\],\?//g # is array
# s/:{/{/ # is object
# /{/{b objectstart} # if start of object, restart

# :ok
# Q0


# object
#     {}
#     { members } 
# members
#     pair
#     pair , members
# pair
#     string : value
# array
#     []
#     [ elements ]
# elements
#     value
#     value , elements
# value
#     string
#     number
#     object
#     array
#     true
#     false
#     null

# string
#     ""
#     " chars "
# chars
#     char
#     char chars
# char
#     any-Unicode-character-
#         except-"-or-\-or-
#         control-character
#     \"
#     \\
#     \/
#     \b
#     \f
#     \n
#     \r
#     \t
#     \u four-hex-digits 
# number
#     int
#     int frac
#     int exp
#     int frac exp 
# int
#     digit
#     digit1-9 digits
#     - digit
#     - digit1-9 digits 
# frac
#     . digits
# exp
#     e digits
# digits
#     digit
#     digit digits
# e
#     e
#     e+
#     e-
#     E
#     E+
#     E-

:array
/\[\(\)\]/

:boolornull
/\(true|false|null\)/Q1

:string
/\"\(\\["/\bfnrt]|\\u[0-9a-fA-F]\{4\}|[^"\]\)\?\"/Q2

:number
/-\?\(0|[1-9][0-9]*\)\([.][0-9]*\)?\([eE][+-]?[0-9]*\)\?/Q3
