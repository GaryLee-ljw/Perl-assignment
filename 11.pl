#!/usr/bin/perl -w
use strict;
use lib '.';
use Complex_18300750075;

my $a = Complex_18300750075->new(1, 2);
my $b = Complex_18300750075->new(3, 4);
my $c = Complex_18300750075->new(1, 2);
my $test_add = $a + $b;
my $test_subb = $a - $b;
my $test_negg = -$a;
my $test_mul = $a * $b;
my $test_div = $a / $b;
my $test_abs = abs($b);
my $test_copy = $a;
my $test_conj = $a->conjugate();
#重载""的测试已经在其他测试中体现了，故没有单独测试
print "test'+': ($a) + ($b) = $test_add\n";
print "test'-': ($a) - ($b) = $test_subb\n";
print "test'neg': -($a) = $test_negg\n";
print "test'*': ($a) * ($b) = $test_mul\n";
print "test'/': ($a) / ($b) = $test_div\n";
print "test'abs': abs($b) = $test_abs\n";
print "test'=': ($a) = $test_copy\n";
if ($a == $b){
	print "test'==': ($a) == ($b) is true\n";
}
else{
	print "test'==': ($a) == ($b) is false\n";
}
if ($a == $c){
	print "test'==': ($a) == ($c) is true\n";
}
else{
	print "test'==': ($a) == ($c) is false\n";
}
print "test'conjugate': ($a)->conjugate() = $test_conj\n";



1;