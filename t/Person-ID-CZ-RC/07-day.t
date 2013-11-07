# Pragmas.
use strict;
use warnings;

# Modules.
use Person::ID::CZ::RC;
use Test::More 'tests' => 4;
use Test::NoWarnings;

# Test.
my $obj = Person::ID::CZ::RC->new(
	'rc' => '840501/1330',
);
my $ret = $obj->day;
is($ret, '01', "RC day in normal number.");

# Test.
$obj = Person::ID::CZ::RC->new(
	'rc' => '8425011331',
);
$ret = $obj->day;
is($ret, '01', "RC day in alternate number.");

# Test.
$obj = Person::ID::CZ::RC->new(
	'rc' => '840229|1330',
);
$ret = $obj->day;
is($ret, '-', 'Cannot parse number.');
