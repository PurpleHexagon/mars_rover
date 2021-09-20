alias Rover.Robot, as: Robot
alias Mars.World, as: World

defmodule MarsRoverTest do
  use ExUnit.Case

  test "next_move returns robot in correct state" do
    world = %World{columns: 8, rows: 4, size: 32}
    robot = %Robot{moves: ["L", "F", "R", "F", "F"], orientation: 90, valid: true, x: 2, y: 3}
    expected_robot = %Robot{moves: [], orientation: 90, valid: true, x: 4, y: 4}
    actual_robot = MarsRover.next_move(Map.get(robot, :moves), robot, world)

    assert actual_robot == expected_robot
  end

  test "next_move returns robot in correct state when off grid" do
    world = %World{columns: 8, rows: 4, size: 32}
    robot = %Robot{moves: ["F", "F", "L", "F", "R", "F", "F"], orientation: 0, valid: true, x: 0, y: 2}
    expected_robot = %Robot{moves: ["R", "F", "F"], orientation: 270, valid: false, x: 0, y: 4}
    actual_robot = MarsRover.next_move(Map.get(robot, :moves), robot, world)

    assert actual_robot == expected_robot
  end

  test "next_move returns valid robot at high move volume" do
    moves = [
      "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L",
      "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L",
      "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L",
      "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L",
      "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L",
      "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L",
      "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L",
      "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L",
      "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L",
      "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L",
      "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L",
      "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L",
      "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L",
      "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L",
      "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L",
      "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L",
      "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L",
      "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L",
      "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L",
      "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L",
      "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L",
      "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L",
      "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L",
      "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L",
      "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L",
      "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L",
      "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L",
      "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L",
      "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L",
      "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L",
      "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L",
      "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L",
      "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L",
      "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L",
      "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L",
      "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L",
      "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L",
      "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L",
      "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L",
      "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L",
      "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L",
      "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L",
      "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L",
      "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L",
      "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L",
      "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L",
      "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L",
      "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L",
      "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L",
      "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L",
      "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L",
      "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L",
      "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L",
      "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L",
      "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L",
      "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L",
      "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L",
      "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L",
      "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L",
      "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L",
      "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L",
      "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L",
      "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L",
      "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L",
      "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L",
      "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L",
      "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L",
      "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L",
      "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L",
      "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L",
      "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L",
      "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L",
      "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L",
      "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L",
      "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L",
      "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L",
      "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L",
      "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L",
      "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L",
      "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L",
      "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L",
      "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L",
      "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L",
      "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L",
      "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L",
      "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L",
      "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L",
      "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L",
      "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L",
      "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L",
      "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L",
      "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L",
      "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L",
      "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L",
      "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L",
      "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L",
      "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L",
      "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L",
      "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L",
      "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L",
      "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L",
      "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L",
      "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L",
      "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L", "F", "R", "R", "F", "L", "L",
    ]

    world = %World{columns: 8, rows: 4, size: 32}
    robot = %Robot{moves: moves, orientation: 0, valid: true, x: 2, y: 2}
    expected_robot = %Robot{moves: [], orientation: 0, valid: true, x: 2, y: 2}
    actual_robot = MarsRover.next_move(Map.get(robot, :moves), robot, world)

    assert actual_robot == expected_robot
  end
end
