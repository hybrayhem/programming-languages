target: run

run: part1 part2

part1:
	swipl -s expert_system.pl -g main -t halt

part2:
	swipl -s flights.pl -g main -t halt