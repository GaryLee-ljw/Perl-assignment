#!/usr/bin/perl -w
use strict;

my $n;
foreach $n (1..10) {
	print $n,"\t",mysin(1,$n),"\n";
}

#递归展开sinx的子函数
sub mysin {
	my $m_x = shift;
	my $m_n = shift;
	if ($m_n == 1) {
		return $m_x - $m_x**3 / 6;
	}
	else {
		#根据sinx泰勒展开通项公式计算第n+1项展开式并返回与前n项的和
		return (-1)**($m_n) * ($m_x**(2*$m_n + 1)) / fac(2*$m_n + 1) + mysin($m_x, $m_n -1);
	}
}

#递归计算阶乘的子函数
sub fac { 
	my $n = shift;
	if ($n == 1){
		return $n;
	}
	else {
		return $n*fac($n-1);
	}
}

1;