#!/usr/bin/perl -w
use strict;

my @file_name = grep {-f $_} <*>;
my %f;
my $i;
foreach $i (@file_name){
	$f{$i} = (stat($i))[7];
}
my @k = sort {$f{$a} <=> $f{$b}} keys %f;
foreach $i (@k){
	print "$f{$i}\t$i\n";
}

1;