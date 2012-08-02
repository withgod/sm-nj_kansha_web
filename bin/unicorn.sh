#rvm wrapper 1.9.3@rails32 start unicorn
#ll ~/.rvm/bin/start_unicorn

SELF=`readlink -f $0`
APP_BASE=`dirname $SELF`/..

cd $APP_BASE
$HOME/.rvm/bin/start_unicorn -D -E production -c $APP_BASE/config/unicorn.rb

