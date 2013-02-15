package Data::Functor;

use strict;
use warnings;

use Carp;

use base 'Exporter';
our @EXPORT_OK = qw(lift);

sub value {
    my ($this) = @_;
    croak("Must override 'value' in " . ref($this));
}

sub lift {
}

1;
