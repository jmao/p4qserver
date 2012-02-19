#!/bin/bash

TRUNKREMOTE=//depot/perforce/groups/stoptrunk
RELEASEREMOTE=//depot/perforce/groups/stoprelease
TRUNKLOCAL=/home/jmao/p4qdepot/depot/perforce/groups/stoptrunk
RELEASELOCAL=/home/jmao/p4qdepot/depot/perforce/groups/stoprelease

if [ $# -ne 1 ]
then
    echo "usage: $0 [trunk|release]"
    exit 2
fi

if [ "$1" == "trunk" ] 
then
    p4 sync -f $TRUNKREMOTE
    p4userscount=`grep -c 'p4users' $TRUNKLOCAL`

    if [ $p4userscount -eq 0 ]
    then
        echo 'trunk locked'
        exit 1
    fi
elif [ "$1" == "release" ]
then
    p4 sync -f $RELEASEREMOTE
    p4userscount=`grep -c 'p4users' $RELEASELOCAL`
    
    if [ $p4userscount -eq 0 ]
    then
        echo 'release locked'
        exit 1
    fi
else
    echo "usage: $0 [trunk|release]"
    exit 2
fi
