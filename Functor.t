#!/usr/bin/env perl

use strict;
use warnings;

use Data::Functor::All;

use Test::More;
use Test::NoWarnings;
use base 'Test::Class';
sub fail_if_returned_early { 1 }

sub test_identity: Test {
    is(identity(Obj->new(10))->add(2)->n->value, 12, "identity works.");
}

sub test_lazy: Test {
    my $obj = Obj->new(0);
    my $n = lazy($obj)->add(2)->add(2)->n;
    $obj->{n} = 10;
    is($n->value, 14, "computations delayed.");
}

sub test_list: Test(2) {
    is_deeply(
        [listf(Obj->new(10))->fork->n->value], [11, 9],
        "list mapped over."
    );
    is_deeply(
        [listf(Obj->new(10))->fork->fork->n->value], [12, 10, 10, 8],
        "list reduced."
    );
}

sub test_maybe: Test(3) {
    is(
        maybe(Obj->new(6))->div(2)->div(3)->n->value, 1,
        "value returned in the end."
    );
    is(
        maybe(Obj->new(4))->div(2)->div(3)->n->value, undef,
        "undef from the second step."
    );
    is(
        maybe(Obj->new(3))->div(2)->div(3)->n->value, undef,
        "undef from the first step."
    );
}

__PACKAGE__->runtests(+1);

package Obj;

sub new {
    my $class = shift;
    bless { n => shift }, $class;
}

sub n { shift->{n} }

sub div {
    my $n = shift->n;
    my $divisor = shift;
    if ($n % $divisor == 0) {
        return Obj->new($n / $divisor);
    } else {
        return;
    }
}

sub fork {
    my $n = shift->n;
    return (
        Obj->new($n + 1),
        Obj->new($n - 1),
    );
}

sub add {
    my $n = shift->n;
    my $add = shift;

    return Obj->new($n + $add);
}
