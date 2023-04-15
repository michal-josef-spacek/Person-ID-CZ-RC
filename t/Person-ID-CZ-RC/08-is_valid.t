use strict;
use warnings;

use Person::ID::CZ::RC;
use Test::More 'tests' => 4;
use Test::NoWarnings;

# Test.
my $obj = Person::ID::CZ::RC->new(
	'rc' => '840501/1330',
);
my $ret = $obj->is_valid;
is($ret, 1, 'Valid normal number.');

# Test.
$obj = Person::ID::CZ::RC->new(
	'rc' => '8425011331',
);
$ret = $obj->is_valid;
is($ret, 1, 'Valid alternate number.');

# Test.
$obj = Person::ID::CZ::RC->new(
	'rc' => '840229|1330',
);
$ret = $obj->is_valid;
is($ret, 0, 'Cannot parse number.');
