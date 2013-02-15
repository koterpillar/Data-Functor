package Data::Functor::Lazy;

use strict;
use warnings;

use base qw(Data::Functor);

our @EXPORT = qw(lazy);

sub value {
    my ($this) = @_;
    return $this->();
}

sub lazy {
    my ($value) = @_;
    my $sub = sub { $value };
    return bless $sub, __PACKAGE__;
}

sub fmap {
    my ($this, $method, @arguments) = @_;

    return bless sub {
        return $this->value->$method(@arguments);
    }, __PACKAGE__;
}

1;
