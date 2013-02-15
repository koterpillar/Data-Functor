package Data::Functor::Maybe;

use strict;
use warnings;

use base qw(Data::Functor);

our @EXPORT = qw(maybe);

sub maybe {
    return shift;
}

1;
