#!/usr/bin/perl -w
use strict;
use Data::Dumper;
use GraphViz;
use Tk;
use Tk::GraphViz;

my $expr;
my @parenthesis = ();#用于检测括号是否匹配
my $symbol;
print "Enter an empty line to quit.\n";
while(1){
	print "Enter your expression and type [Enter] : ";
	$expr = <STDIN>;
	chomp $expr;
	$expr =~ s/ //g;#去空格
	last if not $expr;
	my $expr_test = $expr;
	#检测是否有除了整数、括号、加号和乘号以外的无效字符
	#若有则抛出"Contains invalid characters!"的信息
	$expr_test =~ s/[0-9]|\*|\+|\(|\)//g;
	die("Contains invalid characters!") if $expr_test;
	#检测是否出现1.运算符连写	2.左右括号连写	3.左括号后有运算符	4.左括号前有操作数
	#5.右括号前有运算符	6.右括号后有操作数	7.开头有运算符或右括号	8.结尾有运算符或左括号的语法错误
	#若有则抛出"Syntax error!"的信息
	die("Syntax error!") if ($expr =~ m/[\*\+][\*\+]|\(\)|\)\(|\([\*\+]|[0-9]\(|[\*\+]\)|\)[0-9]|^[\*\+\)]|[\*\+\(]$/);
	#注:上述语法错误检测无法检测是否有括号不匹配的语法错误
	#接下来检测是否有括号不匹配，若有抛出"Parenthesis not match!"的信息
	my @expr = split '',$expr;
	foreach (@expr){
		push @parenthesis,$_ if ($_ eq '(');
		if ($_ eq ')'){
			die("Parenthesis not match!") if not @parenthesis;#右括号多了
			pop @parenthesis;
		}
	}
	die("Parenthesis not match!") if @parenthesis;#左括号多了
	my $operand = 'a';
	my %hash = ();
	while ($expr =~ s/\b[0-9]+\b/$operand/e) {
		$hash{$operand++} = $&;
	}
	@expr = split '',$expr;
	my @rpn = exprtorpn([@expr], {%hash});
	my $tree = rpntotree([@rpn]);
	$symbol = 'A';	# give each node a unique name
	print Dumper $tree;
	print "evaluate result:",evaluate([@rpn]),"\n";
	showTk(graph($tree));
}

sub exprtorpn {
	my $exprref = shift;
	my $hashref = shift;
	my (@s1, @s2);
	push @s1,'#';
	foreach (@$exprref){
		push @s2,$$hashref{$_} if (($_ le 'z') and ($_ ge 'a'));
		push @s1,$_ if ($_ eq '(');
		if ($_ eq '+') {
			if ($s1[$#s1] eq '(' or $s1[$#s1] eq '#') {
				push @s1,$_;
			}
			else {
				push @s2,(pop @s1) until ($s1[$#s1] eq '(' or $s1[$#s1] eq '#');
				push @s1,$_;
			}
		}
		if ($_ eq '*') {
			if ($s1[$#s1] ne '*') {
				push @s1,$_;
			}
			else {
				push @s2,(pop @s1) until ($s1[$#s1] ne '*');
				push @s1,$_;
			}
		}
		if ($_ eq ')') {
			push @s2,(pop @s1) until ($s1[$#s1] eq '(');
			pop @s1;
		}
	}
	push @s2,(pop @s1) until ($s1[$#s1] eq '#');
	return @s2;
}

sub combine1;
sub combine2;
sub rpntotree {
	my $rpnref = shift;
	my @stack;
	foreach (@$rpnref) {
		if ($_ ne '*' and $_ ne '+') {
			push @stack,$_;
		}
		elsif ($_ eq '+') {
			if (ref $stack[$#stack] eq 'ARRAY' and $stack[$#stack]->[0] eq '+') {
				if (ref $stack[$#stack-1] eq 'ARRAY' and $stack[$#stack-1]->[0] eq '+') {
					@stack = combine2([@stack]);
				}
				else {
					@stack = combine1([@stack]);
				}
			}
			elsif (ref $stack[$#stack] eq 'ARRAY' and $stack[$#stack]->[0] eq '*') {
				if (ref $stack[$#stack-1] eq 'ARRAY' and $stack[$#stack-1]->[0] eq '+') {
					@stack = combine2([@stack]);
				}
				else {
					push @stack,['+',pop @stack, pop @stack];
				}
			}
			elsif (ref $stack[$#stack-1] eq 'ARRAY' and $stack[$#stack-1]->[0] eq '+') {
				@stack = combine2([@stack]);
			}
			else {
				push @stack,['+',pop @stack, pop @stack];
			}
		}
		elsif ($_ eq '*') {
			if (ref $stack[$#stack] eq 'ARRAY' and $stack[$#stack]->[0] eq '*') {
				if (ref $stack[$#stack-1] eq 'ARRAY' and $stack[$#stack-1]->[0] eq '*') {
					@stack = combine2([@stack]);
				}
				else {
					@stack = combine1([@stack]);
				}
			}
			elsif (ref $stack[$#stack] eq 'ARRAY' and $stack[$#stack]->[0] eq '+') {
				if (ref $stack[$#stack-1] eq 'ARRAY' and $stack[$#stack-1]->[0] eq '*') {
					@stack = combine2([@stack]);
				}
				else {
					push @stack,['*',pop @stack, pop @stack];
				}
			}
			elsif (ref $stack[$#stack-1] eq 'ARRAY' and $stack[$#stack-1]->[0] eq '*') {
				@stack = combine2([@stack]);
			}
			else {
				push @stack,['*',pop @stack, pop @stack];
			}
		}
	}
	return $stack[0];
}

sub combine1 {
	my $stackref = shift;
	my $temp1 = pop @$stackref;
	push @$temp1,pop @$stackref;
	push @$stackref,$temp1;
	return @$stackref;
}

sub combine2 {
	my $stackref = shift;
	my $temp1 = pop @$stackref;
	my $temp2 = pop @$stackref;
	push @$temp2,$temp1;
	push @$stackref,$temp2;
	return @$stackref;
}

sub evaluate {
	my $rpnref = shift;
	my @stack;
	foreach (@$rpnref) {
		if ($_ eq '+') {
			push @stack, (pop @stack) + (pop @stack);
		}
		elsif ($_ eq '*') {
			push @stack, (pop @stack) * (pop @stack);
		}
		else {
			push @stack, $_;
		}
	}
	return $stack[0];
}

sub showTk {
	my $g = shift;
	my $m = new MainWindow;
	my $gv = $m->GraphViz(-width => 600, -height => 600) -> pack;
	$gv->show($g, fit=>0);
	MainLoop();
}

sub walk;
sub graph {
	my $tree = shift;
	my $g = GraphViz->new(width=>8, height=>8);
	$symbol = 'A';
	walk($tree, $g);
	open F, ">18300750075-07.png";
	binmode F;
	print F $g->as_png;
	close F;
	print "See also '18300750075-07.png'.\n";
	return $g;
}

sub walk {
	my ($tree, $g) = @_;
	my $type = ref $tree eq 'ARRAY' ? $tree->[0] : 'I';
	my $res = $symbol;
	if ($type eq 'I') {
		$g->add_node($symbol++, label=>$tree);
		return $res;
	}

	my @list = @$tree;
	$g->add_node($symbol++, label => shift @list);
	$g->add_edge($res => walk($_, $g)) foreach @list;
	return $res;
}

1;