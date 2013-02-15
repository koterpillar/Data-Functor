package Data::Functor::All;

use strict;
use warnings;

use Data::Functor::Lazy;
use Data::Functor::List;
use Data::Functor::Maybe;

use base 'Exporter';
our @EXPORT = qw(lazy listf maybe);

1;
