package Monty::Door;
use Moose;

has number => ( is => 'rw', isa => 'Num');
has winner => ( is => 'rw', isa => 'Bool');
has chosen => ( is => 'rw', isa => 'Bool');

sub name { 'Door number ' . shift->number }


1;
