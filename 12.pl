#!/usr/bin/perl -w
use strict;
use CGI qw/:standard/;

my @words = qw(春 夏 秋 冬 东 南 西 北 酸 甜 苦 辣 琴 棋 书 画);
my ($state, $bincode);
my @keys = param();

print @keys ? check() : newgame();

sub newgame{
	$state = 0;
	$bincode = "0b";
	header(-charset => "utf-8").
	start_html(
		-title => '猜字游戏',
		-encoding => "utf-8",
		-text => 'darkgreen',
		-bgcolor => 'lightgreen',
		-align => 'center'
		).
	h1('在下面句子中选择一个字（例如“琴”）,记住该字后点击“开始游戏”').
	br().
	br().
	p(big(big(big('春夏秋冬东南西北酸甜苦辣琴棋书画')))).
	br().
	br().
	form_begin().
	end_html;
}

sub check{
	$state = param('state');
	my $yes = param('Yes');
	my $no = param('No');
	$bincode = param('bincode');
	Delete_all();
	$state = $state + 1;
	if ($yes) {
		$bincode = $bincode."1";
	}
	elsif ($no) {
		$bincode = $bincode."0";
	}
	if ($state == 1){
		state1();
	}
	elsif ($state == 2){
		state2();
	}
	elsif ($state == 3){
		state3();
	}
	elsif ($state == 4){
		state4();
	}
	elsif ($state == 5){
		result();
	}
}

sub state1{
	header(-charset => "utf-8") .
	start_html(
		-title => '猜字游戏',
		-encoding => "utf-8",
		-text => 'darkgreen',
		-bgcolor => 'lightgreen',
		-align => 'center'
		).
	h1('你选择的字是否在这里面？').
	br().
	br().
	p(big(big(big('酸甜苦辣琴棋书画')))).
	br().
	br().
	form().
	end_html;
}

sub state2{
	header(-charset => "utf-8") .
	start_html(
		-title => '猜字游戏',
		-encoding => "utf-8",
		-text => 'darkgreen',
		-bgcolor => 'lightgreen',
		-align => 'center'
		).
	h1('你选择的字是否在这里面？').
	br().
	br().
	p(big(big(big('东南西北琴棋书画')))).
	br().
	br().
	form().
	end_html;
}

sub state3{
	header(-charset => "utf-8") .
	start_html(
		-title => '猜字游戏',
		-encoding => "utf-8",
		-text => 'darkgreen',
		-bgcolor => 'lightgreen',
		-align => 'center'
		).
	h1('你选择的字是否在这里面？').
	br().
	br().
	p(big(big(big('秋冬西北苦辣书画')))).
	br().
	br().
	form().
	end_html;
}

sub state4 {
	header(-charset => "utf-8") .
	start_html(
		-title => '猜字游戏',
		-encoding => "utf-8",
		-text => 'darkgreen',
		-bgcolor => 'lightgreen',
		-align => 'center'
		).
	h1('你选择的字是否在这里面？').
	br().
	br().
	p(big(big(big('夏冬南北甜辣棋画')))).
	br().
	br().
	form().
	end_html;
}

sub result{
	header(-charset => "utf-8") .
	start_html(
		-title => '猜字游戏',
		-encoding => "utf-8",
		-text => 'darkgreen',
		-bgcolor => 'lightgreen',
		-align => 'center'
		).
	h1('我已经知道你选的字了，它就是').
	br().
	br().
	p(big(big(big(big(big(big($words[oct("$bincode")]."!"))))))).
	br().
	br().
	p(a({-href => '/cgi-bin/18300750075-12.pl'}, 'New game')).
	end_html;
}

sub form_begin{
	start_form('POST', '/cgi-bin/18300750075-12.pl').
	hidden(
		-name => 'state',
		-default => [$state]
		).
	hidden(
		-name => 'bincode',
		-default => [$bincode]
		).
	submit(
		-name => 'submit',
		-value => '开始游戏',
		).
	end_form();
}

sub form{
	start_form('POST', '/cgi-bin/18300750075-12.pl').
	hidden(
		-name => 'state',
		-default => [$state]
		).
	hidden(
		-name => 'bincode',
		-default => [$bincode]
		).
	submit(
		-name => 'Yes',
		-value => 'Yes',
		).
	"\t".
	submit(
		-name => 'No',
		-value => 'No',
		).
	end_form();
}

1;