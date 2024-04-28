# autoconf setting 

AC_PREREQ([2.69])
AC_INIT([timeDF], 0.9.1, toshi@niceume.com)
AC_CONFIG_SRCDIR([src/Makevars.in])

# compile Attributes for rcpp
sh ./exec/compileAttr.sh

# create and report output
AC_CONFIG_FILES([src/Makevars])
AC_OUTPUT

echo "Makevars is generated"
