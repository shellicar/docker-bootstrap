#!/bin/sh

while read f
do

	if ! echo $f | chpasswd -e; then
		MYUSER=`echo $f | cut -f1 -d':'`
		useradd -Ms /bin/bash ${MYUSER} || exit 1
		echo $f | chpasswd -e || exit 2
	fi
done < myshadow

groupadd -r admin
while read f
do
	addgroup -q $f admin
    addgroup -q $f docker
done < admins

echo "%admin ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers


