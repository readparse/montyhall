package Monty::Game;
use Monty::Door;
use Data::Dumper;
use Moose;

has door_count => ( is => 'rw', isa => 'Num', default => sub { 3 } );
has doors => ( 
	is => 'rw', traits => ['Array'], 
	isa => 'ArrayRef[Monty::Door]', 
	handles => { add_door => 'push'}, default => sub { [] } 
);
has chosen_door => ( is => 'rw', isa => 'Monty::Door');

sub BUILD {
	my $this = shift;	
	$this->create_doors;
	$this->choose_winner;
}

sub create_doors {
	my $this = shift;
	for my $i (1..$this->door_count) {
		$this->add_door( Monty::Door->new( number => $i));
	}
}

sub choose_winner {
	my $this = shift;
	my @doors = @{$this->doors};
	my $winner = $doors[rand @doors];
	$winner->winner(1);
}

sub get_door_by_number {
	my $this = shift;
	if (my $number = shift) {
		for my $door (@{$this->doors}) {
			if ($door->number == $number) {
				return $door;
			}
		}
	}
	return;
}

sub choose {
	my $this = shift;
	if (my $previous = $this->chosen_door) {
		$previous->chosen(0);
	}
	if (my $door = $this->get_door_by_number(@_)) { 
		$door->chosen(1);
		$this->chosen_door($door);
	}
}

sub remaining_door {
	my $this = shift;
	for my $door (@{$this->doors}) {
		if ($door->winner) {
			return $door;
		} elsif ($this->chosen_door->winner) {
			return $door;
		}
	}
}

sub remaining_doors {
	my $this = shift;
	my @out;
	for my $door (@{$this->doors}) {
		push(@out, $door) unless $door->chosen;
	}
	return @out;
}

sub switch_choice {
	my $this = shift;
	my $remaining = $this->remaining_door;
	$this->choose($remaining->number);
}

sub winning_door {
	my $this = shift;
	for my $door (@{$this->doors}) {
		return $door if $door->winner;
	}
}

sub choose_random { 
	shift->choose( int(rand(3)) + 1 ) 
}

sub random_switch_decision {
	return int(rand(2));
}

1;
