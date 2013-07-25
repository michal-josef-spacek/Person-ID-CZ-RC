package Person::ID::CZ::RC;

# Pragmas.
use strict;
use warnings;

# Modules.
use Class::Utils qw(set_params);
use Error::Pure qw(err);

# Version.
our $VERSION = 0.01;

# Constructor.
sub new {
	my ($class, @params) = @_;

	# Create object.
	my $self = bless {}, $class;

	# RC number.
	$self->{'rc'} = undef;

	# Process parameters.
	set_params($self, @params);

	# Check RC.
	if (! defined $self->{'rc'}) {
		err "Parameter 'rc' is required.";
	}

	# Parse.
	$self->_parse;

	# Object.
	return $self;
}

# Get alternate flag.
sub alternate {
	my $self = shift;
	return $self->{'alternate'};
}

# Get checksum.
sub checksum {
	my $self = shift;
	return $self->{'checksum'};
}

# Get day.
sub day {
	my $self = shift;
	return $self->{'day'};
}

# Check validity.
sub is_valid {
	my $self = shift;
	return $self->{'validity'};
}

# Get month.
sub month {
	my $self = shift;
	return $self->{'month'};
}

# Get rc.
sub rc {
	my $self = shift;
	return $self->{'rc'};
}

# Get serial.
sub serial {
	my $self = shift;
	return $self->{'serial'};
}

# Get sex.
sub sex {
	my $self = shift;
	return $self->{'sex'};
}

# Get year.
sub year {
	my $self = shift;
	return $self->{'year'};
}

# Check validity.
sub _check_validity {
	my $self = shift;
	my $checksum = $self->{'serial'} % 11;
	if ($checksum == 10) {
		$checksum = 0;
	}
	if ($self->{'checksum'} == $checksum) {
		$self->{'validity'} = 1;
	} else {
		$self->{'validity'} = 0;
	}
	return;
}

# Parse.
sub _parse {
	my $self = shift;
	if ($self->{'rc'} =~ m/^(\d\d)(\d\d)(\d\d)\/(\d\d\d)(\d)$/ms) {
		$self->{'year'} = 1900 + $1;
		if ($2 > 70) {
			$self->{'alternate'} = 1;
			$self->{'month'} = $2 - 70;
			$self->{'sex'} = 'female';
		} elsif ($2 > 50) {
			$self->{'month'} = $2 - 50;
			$self->{'sex'} = 'female';
			$self->{'alternate'} = 0;
		} elsif ($2 > 20) {
			$self->{'month'} = $2 - 20;
			$self->{'alternate'} = 1;
			$self->{'sex'} = 'male';
		} else {
			$self->{'alternate'} = 0;
			$self->{'month'} = $2;
			$self->{'sex'} = 'male';
		}
		$self->{'day'} = $3;
		$self->{'serial'} = $4;
		$self->{'checksum'} = $5;

		# Check validity.
		$self->_check_validity;

	# To 31. 12.1953.
	} elsif ($self->{'rc'} =~ m/^(\d\d)(\d\d)(\d\d)\/(\d\d\d)$/ms) {
		$self->{'year'} = 1900 + $1;
		if ($2 > 50) {
			$self->{'month'} = $2 - 50;
			$self->{'sex'} = 'female';
		} else {
			$self->{'month'} = $2;
			$self->{'sex'} = 'male';
		}
		$self->{'day'} = $3;
		$self->{'serial'} = $4;	
		$self->{'checksum'} = undef;
		if ($self->{'year'} <= 1953) {
			$self->{'validity'} = 1;
		} else {
			$self->{'validity'} = 0;
		}

	# Not valid.
	} else {
		$self->{'validity'} = 0;
	}
	return;
}

1;

__END__
