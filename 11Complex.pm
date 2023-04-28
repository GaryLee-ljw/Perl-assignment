package Complex_18300750075;
use strict;
use overload
		'+' => \&add,
		'-' => \&subb,
		'neg' => \&negg,#防止一元负号报错
		'*' => \&mul,
		'/' => \&div,
		'""' => \&string,
		'abs' => \&mag,
		'=' => \&copy,
		'==' => \&equal;

sub new{
	my $proto = shift;
	my $type = ref($proto) || $proto;
	my ($x, $y) = @_;
	$x = 0 if not $x;
	$y = 0 if not $y;
	my $this = {x => $x, y => $y};
	bless $this, $type;
}

sub x{
	my $this = shift;
	$this->{x} = shift if (@_);
	$this->{x};
}

sub y{
	my $this = shift;
	$this->{y} = shift if (@_);
	$this->{y};
}

sub conjugate{
	my $obj = shift;
	my $result = Complex_18300750075->new();
	$result->{x} = $obj->{x};
	$result->{y} = -$obj->{y};
	$result;
}

sub add{
	my $obj1 = shift;
	my $obj2 = shift;
	my $result = Complex_18300750075->new();
	$result->{x} = $obj1->{x} + $obj2->{x};
	$result->{y} = $obj1->{y} + $obj2->{y};
	$result;
}

sub subb{
	my $obj1 = shift;
	my $obj2 = shift;
	my $result = Complex_18300750075->new();
	$result->{x} = $obj1->{x} - $obj2->{x};
	$result->{y} = $obj1->{y} - $obj2->{y};
	$result;
}

sub negg{
	my $obj = shift;
	my $result = Complex_18300750075->new();
	$result->{x} = -$obj->{x};
	$result->{y} = -$obj->{y};
	$result;
}

sub mul{
	my $obj1 = shift;
	my $obj2 = shift;
	my $result = Complex_18300750075->new();
	$result->{x} = $obj1->{x} * $obj2->{x} - $obj1->{y} * $obj2->{y};
	$result->{y} = $obj1->{x} * $obj2->{y} + $obj1->{y} * $obj2->{x};
	$result;
}

sub div{
	my $obj1 = shift;
	my $obj2 = shift;
	my $result = Complex_18300750075->new();
	$result->{x} = ($obj1->{x} * $obj2->{x} + $obj1->{y} * $obj2->{y}) / ($obj2->{x}**2 + $obj2->{y}**2);
	$result->{y} = ($obj1->{y} * $obj2->{x} - $obj1->{x} * $obj2->{y}) / ($obj2->{x}**2 + $obj2->{y}**2);
	$result;
}

sub string{
	my $this = shift;
	if ($this->y < 0){
		return "$this->{x}$this->{y}j";
	}
	else{
		return "$this->{x}+$this->{y}j";
	}
}

sub mag{
	my $this = shift;
	sqrt($this->{x}**2 + $this->{y}**2);
}

sub copy{
	my $result = shift;
	my $obj = shift;
	$result->{x} = $obj->{x};
	$result->{y} = $obj->{y};
	bless $result, "Complex_18300750075";
	$result;
}

sub equal{
	my $obj1 = shift;
	my $obj2 = shift;
	$obj1->{x} == $obj2->{x} and $obj1->{y} == $obj2->{y};
}

1;