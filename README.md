# MarsRover

## Original Brief 

Write a program that takes in commands and moves one or more robots around Mars.

* The world should be modelled as a grid with size m x n
* Your program should read the input, update the robots, and print out the final states of the robots
* Each robot has a position (x, y), and an orientation (N, E, S, W)
* Each robot can move forward one space (F), rotate left by 90 degrees (L), or rotate right by 90 degrees (R)
* If a robot moves off the grid, it is marked as ‘lost’ and its last valid grid position and orientation is recorded
* Going from x -> x + 1 is in the easterly direction, and y -> y + 1 is in the northerly direction. i.e. (0, 0) represents the south-west corner of the grid

* The input takes the form:

4 8
(2, 3, E) LFRFF
(0, 2, N) FFLFRFF

The first line of the input ‘4 8’ specifies the size of the grid. The subsequent lines each
represent the initial state and commands for a single robot. (0, 2, N) specifies the initial state
of the form (x, y, orientation). FFLFRFF represents the sequence of movement commands
for the robot.

The output should take the form:

(4, 4, E)
(0, 4, W) LOST

Each line represents the final position and orientation of the robots of the form (x, y,
orientation) and optionally whether the robot was lost.Another example for the input:

4 8
(2, 3, N) FLLFR
(1, 0, S) FFRLF

The output would be:

(2, 3, W)
(1, 0, S) LOST

## Analysis 

### How to parse the data:

Robot's orientation needs to be stored 

Option 1: 
Store character for cardinal direction and use a state machine to determine the next direction when turning left or right

Option 2:
Store the degrees for the cardinal direction and use simple arithmetic to determine next state resetting when hitting
the boundaries of a circle ie < 0 or > 360.

time complexity: O(1) Constant

### How to store the grid data:

Option 1: 
Just store m and n so can check if out of bounds
time complexity: O(1) Constant
space complexity: O(1) Constant

Option 2:
Create matrix of m and n with 1 for current robot position, move using matrix addition with move matrix
time complexity: At least O(n * m) 
space complexity: O(n * m)

### Plan

I will be implementing the Mars Rover challenge using Elixir and Mix. The main risks to this are I have never written a CLI 
application in Elixir and have not worked with the language professionally so may not write idiomatic Elixir.

I plan on storing the degrees for orientation and store the bounds of the grid only. As this results in the most efficiency 
time and space wise and I believe will also be understandable. Structs will be used to store the robot and grid state.

The moves will be stored in a list which will be actioned upon as a FIFO queue.

The software will be verified using unit tests and a test harness script to run the program and check output.

I will be using Elixir version 1.11.2 to execute. Dialyxir, ExUnit, Doctests, typespecs will be used to improve code quality etc. 

## What I'd do if I had more time

* Implement a IO wrapper using Protocols to allow for further unit testing
* Use DI for functions with side effects
* Add more error handling and test cases for bad input data 
* Improve module cohesion 
* Implement logging when errors are encountered

## Outcome

The project has two entrypoints run.ex which can be used to pipe input files into and cli.ex which can be used to run with a command prompt. These can be run as escript, as part of mix run or through release

## Installation

Run the following commands

```
mix do deps.get, deps.compile
```

## Run 

Run via shell script which uses file based inputs and checks outputs
```
./run.sh
```

Run manually via file or cli with prompts
```
mix run -e "Run.main" < cases/inputs/simple.txt
mix run -e "Cli.main" 
```

Run via escript with cli prompts
```
mix escript.build
./mars_rover
```

Run from release from file inputs or cli prompts
```
mix release
_build/dev/rel/mars_rover/bin/mars_rover eval "Run.main" < cases/simple.txt
_build/dev/rel/mars_rover/bin/mars_rover eval "Cli.main" 
```
