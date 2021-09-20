alias Rover.Robot, as: Robot
alias Mars.World, as: World
alias Rover.Orientation, as: Orientation

defmodule OrientationTest do
  use ExUnit.Case
  doctest Orientation

  test "cardinal_direction_to_degrees when North returns 0 degrees" do
    assert Orientation.cardinal_direction_to_degrees("N") == 0
  end

  test "cardinal_direction_to_degrees when East returns 90 degrees" do
    assert Orientation.cardinal_direction_to_degrees("E") == 90
  end

  test "cardinal_direction_to_degrees when South returns 180 degrees" do
    assert Orientation.cardinal_direction_to_degrees("S") == 180
  end

  test "cardinal_direction_to_degrees when West returns 270 degrees" do
    assert Orientation.cardinal_direction_to_degrees("W") == 270
  end

  test "degrees_to_cardinal_direction when North returns 0 degrees" do
    assert Orientation.degrees_to_cardinal_direction(0) == "N"
  end

  test "degrees_to_cardinal_direction when East returns 90 degrees" do
    assert Orientation.degrees_to_cardinal_direction(90) == "E"
  end

  test "degrees_to_cardinal_direction when South returns 180 degrees" do
    assert Orientation.degrees_to_cardinal_direction(180) == "S"
  end

  test "degrees_to_cardinal_direction when West returns 270 degrees" do
    assert Orientation.degrees_to_cardinal_direction(270) == "W"
  end

  test "is_forward returns false when not f" do
    assert Orientation.is_forward("S") == false
  end

  test "is_forward returns true when F" do
    assert Orientation.is_forward("F") == true
  end

  test "is_forward returns true when f" do
    assert Orientation.is_forward("f") == true
  end

  test "is_cardinal_direction returns false when not n,s,e,w" do
    assert Orientation.is_cardinal_direction("G") == false
  end

  test "is_cardinal_direction returns true when in n,s,e,w" do
    assert Orientation.is_cardinal_direction("N") == true
    assert Orientation.is_cardinal_direction("S") == true
    assert Orientation.is_cardinal_direction("E") == true
    assert Orientation.is_cardinal_direction("W") == true
    assert Orientation.is_cardinal_direction("n") == true
    assert Orientation.is_cardinal_direction("s") == true
    assert Orientation.is_cardinal_direction("e") == true
    assert Orientation.is_cardinal_direction("w") == true
  end

  test "is_left_or_right returns true for right" do
    assert Orientation.is_left_or_right("R") == true
    assert Orientation.is_left_or_right("r") == true
  end

  test "is_left_or_right returns true for left" do
    assert Orientation.is_left_or_right("L") == true
    assert Orientation.is_left_or_right("l") == true
  end

  test "is_left_or_right returns false when not left or right" do
    assert Orientation.is_left_or_right("a") == false
    assert Orientation.is_left_or_right("e") == false
  end

  test "is_left_or_right raises FunctionClauseError when not string" do
    assert_raise(FunctionClauseError, fn -> Orientation.is_left_or_right(1) end)
  end

  test "is_lost returns false when robot is not off grid" do
    world = %World{columns: 8, rows: 4, size: 32}
    robot = %Robot{moves: ["F","F","L","F","R","F","F"], orientation: 0, valid: true, x: 0, y: 2}

    assert Orientation.is_lost(robot, world) == false
  end

  test "is_lost returns true when robot is off grid" do
    world = %World{columns: 8, rows: 4, size: 32}
    robot = %Robot{moves: ["L", "F", "R", "F", "F"], orientation: 0, valid: true, x: 2, y: 9}

    assert Orientation.is_lost(robot, world) == true
  end
end

