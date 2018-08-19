#!/usr/bin/env perl -w
use warnings;
use strict;
use IO::Socket;

if ($#ARGV + 1 < 2 || $#ARGV + 1 > 3) {
    print "usage: $0 [-l port | ip port file]\n";
    exit;
}

if ($ARGV[0] eq "-l") { # listen mode
    my $listenport = $ARGV[1];

    my $sock = new IO::Socket::INET (
        LocalPort => $ARGV[1],
        Proto => 'tcp',
        Listen => 1,
        Reuse => 1
    );

    die "Could not create socket: $!\n" unless $sock;
    # print "listening on port $ARGV[1]\n";

    my $new_sock = $sock->accept();
    while(<$new_sock>) { print $_; }
    close($sock);
}
else { # connect mode
    my $sock = new IO::Socket::INET (
        PeerAddr => $ARGV[0],
        PeerPort => $ARGV[1],
        Proto => 'tcp'
    );

    die "could not create socket: $!\n" unless $sock;
    # print "connected to $ARGV[0]:$ARGV[1]\n";

    open(FILE, $ARGV[2]) || die "could not open file $ARGV[2]\n";

    while (<FILE>) {
        print $sock $_;
    }
    close(FILE);
}