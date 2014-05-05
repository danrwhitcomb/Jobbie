#! /bin/bash



`dropdb  --if-exists $1`
if [ $? -ne 0 ]; then
	echo "The database does not exist or is being used"
	echo "Please stop any programs that are connected to the databse"
	exit
fi 

`createdb $1`
`source 
`python manage.py syncdb`
exit