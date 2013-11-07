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
my $ret = $obj->alternate;
is($ret, 0, "RC isn't alternate number.");

# Test.
$obj = Person::ID::CZ::RC->new(
	'rc' => '8425011331',
);
$ret = $obj->alternate;
is($ret, 1, "RS is alternate number.");

# Test.
$obj = Person::ID::CZ::RC->new(
	'rc' => '840229|1330',
);
$ret = $obj->alternate;
is($ret, '-', 'Cannot parse number.');
