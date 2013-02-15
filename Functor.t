#!/usr/bin/env perl

use strict;
use warnings;

use Data::Functor::All;

use Test::More;
use Test::NoWarnings;
use base 'Test::Class';
sub fail_if_returned_early { 1 }

sub test_maybe: Test(3) {
    my $a = sub { A->new({ n => shift }) };
    is(maybe($a->(6))->step1->step2->value, 1,     "value returned in the end.");
    is(maybe($a->(4))->step1->step2->value, undef, "undef from the second step.");
    is(maybe($a->(3))->step1->step2->value, undef, "undef from the first step.");
}

__PACKAGE__->runtests(+1);

package ObjBase;

sub new {
    my $class = shift;
    bless shift, $class;
}

package A;
use base 'ObjBase';

sub step1 {
    my $n = shift->{n};
    if ($n % 2 == 0) {
        return C->new({ n => $n / 2 });
    } else {
        return;
    }
}

package C;
use base 'ObjBase';

sub step2 {
    my $n = shift->{n};
    if ($n % 3 == 0) {
        return $n / 3;
    } else {
        return;
    }
}
