#!/usr/bin/perl -w
use strict;
use Chart::Plot;

my $fig = Chart::Plot->new(1000,700);
print "Please enter your expression and type [Enter] : ";
my $expr = <STDIN>;
chomp $expr;
my $expr_test = $expr;
#下面将允许输入的字符和数字过滤之后若$expr_test还非空，说明有其他不允许的非法输入字符存在
#该方法也可以将输入`的情况检测出来，防止用户输入删除文件的危险命令等等
#该方法仅能检测是否有不允许的字符出现，并不能检测表达式是否有效
#检测表达式是否有效的方法是在后面$flag为0时，表示表达式在整个[-10,10]上无效
$expr_test =~ s/\+|-|\*|\/|\*\*|\(|\)|sin|cos|tan|log|exp|abs|sqrt|x|[0-9\.]| //g;#允许用户输入空格
if ($expr_test){				
	die "Invalid Input!";	
}
my $expr_processed = $expr;
$expr_processed =~ s/(?!e)x(?!p)/\$x/g;		#防止将exp中的x替换成$xs
my @x = map $_/100,-1000..1000;
my (@x_plot, @y_plot);
my ($x,$y);
my $flag = 0;
foreach $x (@x) {
	$y = eval "$expr_processed";
	if (not $@) {			#在定义域内有效则添加进数组@x_plot和@y_plot里,可保证无效区间内不做图
		push @x_plot, $x;
		push @y_plot, $y;
		$flag = 1;			#flag为1表示@x_plot和@y_plot里有数据
	}
	elsif ($flag == 1) {	#若在定义域内无效且@x_plot和@y_plot里有数据则将该段数据加入$fig中，并清空数组
		$fig->setData([@x_plot],[@y_plot],'Blue SolidLine NoPoints');
		undef @x_plot;
		undef @y_plot;
		$flag = 2;			#flag为2表示@x_plot和@y_plot里没有数据了
	}
}
if ($flag == 1){			#将最后一组连续有效的数据加入$fig中，防止数据遗漏
	$fig->setData([@x_plot],[@y_plot],'Blue SolidLine NoPoints');
}
#flag为0表示在整个[-10,10]上无效，
#包含1、定义域不在此区间 2、表达式本身是错误的（如x***2或sin((x)多一个括号等）这两种情况，此时报错
if ($flag == 0){			
	die "Invalid on the entire [-10,10] or the expression is wrong!";
}
$fig->setGraphOptions('title' => "$expr");
open F, '>18300750075-06.png' or die;
binmode F;
print F $fig->draw('png');
close F;

1;