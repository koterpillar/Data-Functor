package Data::Functor::Maybe;

use strict;
use warnings;

use base qw(Data::Functor);

our @EXPORT = qw(maybe);

sub maybe {
    return __PACKAGE__->lift(shift);
}

our $undef = maybe(undef);

sub fmap {
    my ($this, $method, @arguments) = @_;
    my $object = $this->value;
    if (!defined ($object)) {
        return $undef;
    } else {
        my $result = $object->$method(@arguments);
        return maybe($result);
    }
}

1;
