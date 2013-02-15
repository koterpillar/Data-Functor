package Data::Functor::All;

use strict;
use warnings;

use Data::Functor::Identity;
use Data::Functor::Lazy;
use Data::Functor::List;
use Data::Functor::Maybe;

use base 'Exporter';
our @EXPORT = qw(identity lazy listf maybe);

1;
