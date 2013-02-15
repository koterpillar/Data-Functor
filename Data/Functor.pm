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
    my ($class, $value) = @_;
    return bless \$value, $class;
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
