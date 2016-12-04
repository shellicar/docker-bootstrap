#!/bin/sh

while read f
do

	if ! echo $f | chpasswd -e; then
		MYUSER=`echo $f | cut -f1 -d':'`
		useradd -Ms /bin/bash ${MYUSER} || exit 1
		echo $f | chpasswd || exit 2
	fi
done < myshadow

groupadd -r admin
while read f
do
	addgroup -q $f admin
done < admins

echo "Adding admin SUDO"
echo "%admin ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers


