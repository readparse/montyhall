#!/usr/bin/perl -w
use strict;
use Monty::Game;
use Data::Dumper;

my $totals = {};

$SIG{INT} = sub {
	print Dumper($totals);
	exit;
};

my $game_count = 0;

while(1) {
	print ++$game_count . "\n";
	my $game = Monty::Game->new();
	#print "game on: $game\n";
	
	$game->choose( int(rand(3)) + 1 );

	my $switch = int(rand(2));

	if ($switch) {
		$game->switch_choice;
		#print "Switched\n";
	} else {
		#print "Did not switch\n";
	}

	my $winner = $game->winning_door;

	if ($game->chosen_door->winner) {
		if ($switch) {
			$totals->{winner_with_switch}++;
		} else {
			$totals->{winner_no_switch}++;
		}
	} else {

		if ($switch) {
			$totals->{loser_with_switch}++;
		} else {
			$totals->{loser_no_switch}++;
		}
	}
	
}

