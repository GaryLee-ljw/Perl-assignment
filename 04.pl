#!/usr/bin/perl -w
use strict;
use Chart::Lines

my $a;
my @x = ();
my @y = ();
my @coe;
my $flag = 0;	#标志位，若为1则开始读入数据
while (defined($a = <>)) {
	chomp $a;
	if ($flag == 1) {
		$a =~ s/^(\d+)\s+(.*)/$2/;	#将每行数据最开始的序号和空格删除
		@coe = split /\s+/,$a;		#按空格将两个数据分割开来
		push @y, @coe;				#将分割得到的数据压入y数组中作为绘图的因变量
	}
	if ($a =~ m/===/) {
		$flag = 1;
	} 
}
my $num = scalar @y;
@x = map $_, 0..($num - 1);			#根据y数组的大小确定自变量数组x的值

my $chart = Chart::Lines->new(800, 600);
$chart->add_dataset(@x);
$chart->add_dataset(@y);
$chart->set('skip_x_ticks' => $num/10);
$chart->png('18300750075-04.png');

1;