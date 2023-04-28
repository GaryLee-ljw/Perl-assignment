#!/usr/bin/perl -w
use strict;

my ($i, $j);
foreach  $i (1 .. 9) {
	if ($i > 1) {
		foreach (1 .. $i - 1) {
			print "\t";
		}
	}
	foreach $j ($i .. 9) {
		print $i * $j, "\t";
	}
	print "\n";
}

1;