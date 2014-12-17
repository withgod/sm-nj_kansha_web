#!/usr/bin/perl
#
#   database: sourcemod
#   username: sourcemod
#   password: sourcemodpassword

use strict;
use warnings;
use Data::Dumper;

my $mycmd = '/usr/bin/mysql -usourcemod -psourcemodpassword sourcemod';

my @tables = ['nj_steamids', 'nj_steam_nicknames', 'nj_kansha_results'];

for my $r (`$mycmd -N -e 'select steamcomid, count(id) as cnt from nj_steamids group by steamcomid having cnt > 1 order by cnt desc'`) {
    my ($steamcomid, $cnt) = split /\s+/, $r;
    my ($id2, $id3, $others, $skip) = (undef, undef, [], 0);
    for my $rr (`$mycmd -N -e 'select * from nj_steamids where steamcomid = "$steamcomid"'`) {
        my @items = split /\s+/, $rr;
        if ($items[1] =~ /^(STEAM_[\d:]+)$/) {
            $id2 = \@items;
        } elsif ($items[1] =~ /^(\[U[:\d]+\])$/) {
            $id3 = \@items;
        } else {
            push @{$others}, \@items;
        }
    }
    #print Dumper [$steamcomid, $id2, $id3, $skip, $others];
    if ($id3) {
        print "$steamcomid found id3 data\n";
        print Dumper [$id2, $id3];
        my @update_ids = ($id2->[0]);
        for my $o (@{$others}) {
            push @update_ids, $o->[0];
        }
        my $update1 = sprintf ('update nj_kansha_results set nj_steamid_id = %d where nj_steamid_id in (%s);', $id3->[0], join ',', @update_ids);
        #my $update2 = sprintf ('update nj_steam_nicknames set nj_steamid_id = %d where nj_steamid_id in (%s);', $id3->[0], join ',', @update_ids);
        print Dumper $update1;
        my $r1 = `$mycmd -e "$update1"`;
        #my $r2 = `$mycmd -e $update2`;
        print Dumper $r1;
    } else {
        print "$steamcomid can't found id3 data. skip.\n";
    }
}
