package Data::Functor::Identity;

use strict;
use warnings;

use base qw(Data::Functor);

our @EXPORT = qw(identity);

sub lift {
    my ($class, $value) = @_;
    return bless \$value, $class;
}

sub value {
    my ($this) = @_;
    return $$this;
}

sub identity {
    return __PACKAGE__->lift(shift);
}

sub fmap {
    my ($this, $method, @arguments) = @_;

    return identity($this->value->$method(@arguments));
}

1;
