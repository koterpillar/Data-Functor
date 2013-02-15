#!/usr/bin/env perl

use strict;
use warnings;

use Data::Functor::All;

use Test::More;
use Test::NoWarnings;
use base 'Test::Class';
sub fail_if_returned_early { 1 }

sub test_lazy: Test {
    my $e = E->new(0);
    my $n = lazy($e)->add(2)->add(2)->n;
    $e->{n} = 10;
    is($n->value, 14, "computations delayed.");
}

sub test_list: Test(2) {
    my $d = sub { D->new(shift) };
    is_deeply(
        [listf($d->(10))->step1->step2->value], [22, 18],
        "list operations."
    );
    is_deeply(
        [listf($d->(10))->step1->step1->step2->value], [24, 20, 20, 16],
        "list returned twice."
    );
}

sub test_maybe: Test(3) {
    my $a = sub { A->new(shift) };
    is(maybe($a->(6))->step1->step2->value, 1,     "value returned in the end.");
    is(maybe($a->(4))->step1->step2->value, undef, "undef from the second step.");
    is(maybe($a->(3))->step1->step2->value, undef, "undef from the first step.");
}

__PACKAGE__->runtests(+1);

package ObjBase;

sub new {
    my $class = shift;
    bless { n => shift }, $class;
}

sub n { shift->{n} }

package A;
use base 'ObjBase';

sub step1 {
    my $n = shift->n;
    if ($n % 2 == 0) {
        return C->new($n / 2);
    } else {
        return;
    }
}

package C;
use base 'ObjBase';

sub step2 {
    my $n = shift->n;
    if ($n % 3 == 0) {
        return $n / 3;
    } else {
        return;
    }
}

package D;
use base 'ObjBase';

sub step1 {
    my $n = shift->n;
    return (
        D->new($n + 1),
        D->new($n - 1),
    );
}

sub step2 {
    shift->n * 2;
}

package E;
use base 'ObjBase';

sub add {
    my $n = shift->n;
    my $add = shift;

    return E->new($n + $add);
}
