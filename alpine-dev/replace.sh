#!/bin/sh

while read f
do

	if ! echo $f | chpasswd -e; then
		MYUSER=`echo $f | cut -f1 -d':'`
		adduser -HDs /bin/bash ${MYUSER} || exit 1
		echo $f | chpasswd || exit 2
	fi
done < myshadow

while read f
do
	addgroup $f wheel
done < admins

echo "%wheel ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers


