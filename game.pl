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
	
	$game->choose_random;

	my $switch = $game->random_switch_decision;

	if ($switch) {
		$game->switch_choice;
	}

	my $winner = $game->winning_door;

	if ($game->chosen_door->winner) {
	 	$totals->{winner}++;
		if ($switch) {
			$totals->{winner_with_switch}++;
		} else {
			$totals->{winner_no_switch}++;
		}
	} else {
	 	$totals->{loser}++;
		if ($switch) {
			$totals->{loser_with_switch}++;
		} else {
			$totals->{loser_no_switch}++;
		}
	}
	
}

