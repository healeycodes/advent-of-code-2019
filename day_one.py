import sys

fn = sys.argv[1]
with open(fn) as file:
    answer = 0
    for line in file.read().splitlines():
        mass = int(line)
        
        # calculate fuel (part one)
        fuel = mass // 3 - 2
        answer += fuel

        # keep calculating fuel for the fuel until zero (part two)
        while fuel > 0:
            fuel = max([0, fuel // 3 - 2])
            answer += fuel

    print(answer)
