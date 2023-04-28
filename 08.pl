#!/usr/bin/perl -w
use strict;
use Time::HiRes qw(time sleep);
use Tk;
use Tk::LineGraphDataset;
use Tk::PlotDataset;

my @backend = qw(Calc GMP LTM Pari);
my ($dataset,@x,@y,@dss);
foreach my $backend (@backend) {
	@x = @y = ();
	foreach my $x (10..25) {
		my $time_0 = time;
		system("perl 18300750075-08sqrt2.pl $x $backend");
		my $time_1 = time;
		my $time = $time_1 - $time_0;
		last if ($time > 4);#大于4秒则跳过
		push @x,$x;
		push @y,$time;
		last if ($backend eq "Pari" and $x == 22);#实际测试时Pari后端迭代到第23次的时候会堆栈溢出
	}
	next unless @x;
	$dataset = LineGraphDataset->new(-name => $backend, 
									 -xData => [@x], 
									 -yData => [@y], );
	push @dss,$dataset;
}

my $m = MainWindow->new;
my $graph = $m->PlotDataset(-width => 800,-height => 500,)->pack;
$graph->addDatasets(@dss);
$graph->plot;
MainLoop;

1;