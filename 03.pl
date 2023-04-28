#!/usr/bin/perl -w
use strict;

my @lines = grep /TCP/, (split "\n", `netstat -n -a`);#筛选留下含TCP的行
s/(\s+\S+){3}\s+(\S+)/$2/ foreach @lines;#只保留最后的链接的状态
my (%states_count, $states, $count);
$states_count{$_}++ foreach @lines;#利用哈希表统计链接的状态的数量
while (($states, $count) = each %states_count) {
	print "$states\t$count\n";
}

1;