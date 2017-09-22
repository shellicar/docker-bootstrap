#!/bin/sh

dockerid=$(cat ./mygroup)

if [ "$dockerid" = "" ]; then
    exit 1
fi

groupmod -g "$dockerid" docker || \
groupadd -g "$dockerid" docker || \
exit 2

