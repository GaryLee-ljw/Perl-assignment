#!/usr/bin/perl -w
use strict;
use Tk;

my $var = "0";
my $last_var = "0";
my $last_op = "";#为空表示还未按任何操作符
my $input_flag = 1;#为1表示等待输入第一个字符，为0表示在输入过程中

my $main = new MainWindow;
my $font = $main->fontCreate(-size => 9);
$main->title('Calc');
$main->Label(-height => 3, -width => 53, -relief => 'sunken', -background => 'white', -textvariable => \$var, -font => $font)->pack();
$main->Label(-height => 22, -width => 53)->pack();#实际测试时发现用place的话刚打开窗口会显示不全（需要自己拉大窗口），故加上空白Label让其自动拉大
$main->Button(-height => 4, -width => 10, -text => '<-', -font => $font, -command => \&back)->place(-x => 20,-y => 46);
$main->Button(-height => 4, -width => 22, -text => 'C', -font => $font, -command => \&clear)->place(-x => 89,-y => 46);
$main->Button(-height => 4, -width => 10, -text => '=', -font => $font, -command => \&equal)->place(-x => 230,-y => 46);
$main->Button(-height => 4, -width => 10, -text => '7', -font => $font, -command => \&seven)->place(-x => 20,-y => 103);
$main->Button(-height => 4, -width => 10, -text => '8', -font => $font, -command => \&eight)->place(-x => 90,-y => 103);
$main->Button(-height => 4, -width => 10, -text => '9', -font => $font, -command => \&nine)->place(-x => 160,-y => 103);
$main->Button(-height => 4, -width => 10, -text => '/', -font => $font, -command => \&div)->place(-x => 230,-y => 103);
$main->Button(-height => 4, -width => 10, -text => '4', -font => $font, -command => \&four)->place(-x => 20,-y => 160);
$main->Button(-height => 4, -width => 10, -text => '5', -font => $font, -command => \&five)->place(-x => 90,-y => 160);
$main->Button(-height => 4, -width => 10, -text => '6', -font => $font, -command => \&six)->place(-x => 160,-y => 160);
$main->Button(-height => 4, -width => 10, -text => '*', -font => $font, -command => \&mul)->place(-x => 230,-y => 160);
$main->Button(-height => 4, -width => 10, -text => '1', -font => $font, -command => \&one)->place(-x => 20,-y => 217);
$main->Button(-height => 4, -width => 10, -text => '2', -font => $font, -command => \&two)->place(-x => 90,-y => 217);
$main->Button(-height => 4, -width => 10, -text => '3', -font => $font, -command => \&three)->place(-x => 160,-y => 217);
$main->Button(-height => 4, -width => 10, -text => '-', -font => $font, -command => \&subtract)->place(-x => 230,-y => 217);
$main->Button(-height => 4, -width => 10, -text => '0', -font => $font, -command => \&zero)->place(-x => 20,-y => 274);
$main->Button(-height => 4, -width => 10, -text => '+/-', -font => $font, -command => \&cpl)->place(-x => 90,-y => 274);
$main->Button(-height => 4, -width => 10, -text => '.', -font => $font, -command => \&point)->place(-x => 160,-y => 274);
$main->Button(-height => 4, -width => 10, -text => '+', -font => $font, -command => \&add)->place(-x => 230,-y => 274);
$main->MainLoop;

sub one{
	input("1");
}

sub two{	
	input("2");
}

sub three{
	input("3");
}

sub four{
	input("4");
}

sub five{
	input("5");
}

sub six{
	input("6");
}

sub seven{
	input("7");
}

sub eight{
	input("8");
}

sub nine{
	input("9");
}

sub zero{
	input("0");
}

sub point{
	if ($input_flag == 1){
		$var = "0.";
		$input_flag = 0;
	}
	else {
		$var = $var.".";
	}
}

sub clear{
	$var = "0";
	$last_var = "0";
	$last_op = "+";
	$input_flag = 1;
}

sub cpl{
	if ($var > 0){
		$var = "-".$var;
	}
	elsif ($var < 0){
		$var = substr($var,1);
	}
}

sub back{
	if (length($var) == 1 or $var eq "Error: Divided by zero!"){
		$var = "0";
	}
	elsif (length($var) == 2 and $var < 0){
		$var = "0";
	}
	else {
		chop $var;
	}
}

sub add{
	if ($input_flag == 1){
		$var = $var;#防止用户连按多次操作符
	}
    else{
    	myeval();
    }
    $last_op = "+";
    $last_var = $var;
    $input_flag = 1;
}

sub subtract{
	if ($input_flag == 1){
		$var = $var;#防止用户连按多次操作符
	}
    else{
    	myeval();
    }
    $last_op = "-";
    $last_var = $var;
    $input_flag = 1;
}

sub mul{
	if ($input_flag == 1){
		$var = $var;#防止用户连按多次操作符
	}
    else{
    	myeval();
    }
    $last_op = "*";
    $last_var = $var;
    $input_flag = 1;
}

sub div{
	if ($input_flag == 1){
		$var = $var;#防止用户连按多次操作符
	}
    else{
    	myeval();
    }
    $last_op = "/";
    $last_var = $var;
    $input_flag = 1;
}

sub equal{
	if ($input_flag == 1){
		$var = $var;#防止用户按了操作符后就按下等号
	}
    else{
    	myeval();
    }
    $last_op = "";
    $last_var = $var;
    $input_flag = 1;
}

sub input{
	my $operand = shift;
	if ($input_flag == 1){
		$var = $operand;
		$input_flag = 0;
	}
	elsif ($var eq "0"){
		$var = $operand;
	}
	else {
		$var = $var.$operand;
	}
}

sub myeval{
	if ($last_op eq "+"){
    	$var = $var + $last_var;
    }
	elsif ($last_op eq "-"){
    	$var = $last_var - $var;
    }
	elsif ($last_op eq "*"){
    	$var = $var * $last_var;
    }
	elsif ($last_op eq "/"){
		if ($var eq "0"){#提示出现除以0的错误
			$var = "Error: Divided by zero!";
		}
		else{
    		$var = $last_var / $var;
		}
    }
    elsif ($last_op eq ""){
    	$var = $var;
    }
}

1;