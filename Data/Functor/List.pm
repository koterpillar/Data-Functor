package Data::Functor::List;

use strict;
use warnings;

use base qw(Data::Functor);

our @EXPORT = qw(listf);

sub listf {
    return bless \@_, __PACKAGE__;
}

sub fmap {
    my ($this, $method, @arguments) = @_;
    return listf(
        map { $_->$method(@arguments) }
        $this->value
    );
}

sub value {
    my ($this) = @_;
    return @$this;
}

1;
