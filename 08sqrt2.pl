#!/usr/bin/perl -w
use strict;
use Math::BigInt lib => $ARGV[1];

my $p = new Math::BigInt '1';
my $q = new Math::BigInt '1';
foreach (0..$ARGV[0]-1){
	($p, $q) = (2 * $p * $q, $q * $q + 2 * $p * $p);
}

1;