package Data::Functor;

use strict;
use warnings;

use Carp;

use base 'Exporter';

sub value {
    my ($this) = @_;
    croak("Must override 'value' in " . ref($this));
}

sub fmap {
    my ($this, $method, @arguments) = @_;
    croak("Must override 'fmap' in " . ref($this));
}

sub AUTOLOAD {
    our $AUTOLOAD;

    (my $method = $AUTOLOAD) =~ s/.*:://s;

    my ($this, @arguments) = @_;
    return $this->fmap($method, @arguments);
}

sub DESTROY {}

1;
