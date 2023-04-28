#!/usr/bin/perl -w
use strict;
use PDF::Create;
 
my $pdf  = PDF::Create->new('filename'=>"18300750075.pdf");
my $root = $pdf->new_page('MediaBox' => $pdf->get_page_size('A4'));
my $page = $root->new_page;
my $font = $pdf->font('BaseFont' => 'Helvetica');
$page->setrgbcolor(0,0,0);
my $y = 800;
my $x = 30;
my $count = 4;
my @expr = ();
while (scalar @expr < 40){
	my $x1 = int(rand(99)) + 1;#产生[1,99]的随机正整数
	my $x2 = int(rand(99)) + 1;
	my $op = int(rand(2))?"+":"-";#随机产生"+"或"-"号
	my $expr = "$x1 ".$op." $x2 ";
	if (eval $expr > 0 and eval $expr < 100){#判断结果是否在100以内
		push @expr,$expr."=";
	}
}

foreach (@expr){
	if ($count == 4){#每四个题换一行
		$count = 1;
		$y -= 40;
		$x = 30;
	}
	else {
		$count += 1;
		$x += 135;
	}
    $page->block_text({
        page       => $page,
        font       => $font,
        text       => $_,
        font_size  => 22,
        line_width => 535,
        'x'        => $x,
        'y'        => $y,
    });
}

$pdf->close;

1;