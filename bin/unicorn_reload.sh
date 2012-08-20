#!/bin/sh

SELF=`readlink -f $0`
APP_BASE=`dirname $SELF`/..

cd $APP_BASE
kill -USR2 `cat ./tmp/pids/unicorn.pid`


