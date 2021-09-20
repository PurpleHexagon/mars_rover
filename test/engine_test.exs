alias Rover.Robot, as: Robot
alias Rover.Engine, as: Engine

defmodule EngineTest do
  use ExUnit.Case
  doctest Engine

  test "updates orientation to 270 when turning left from 0" do
    robot = %Robot{moves: ["L", "F", "R", "F", "F"], orientation: 0, valid: true, x: 2, y: 3}
    expected_robot = %Robot{moves: ["L", "F", "R", "F", "F"], orientation: 270, valid: true, x: 2, y: 3}
    actual_robot = Engine.update_orientation(:l, robot)

    assert actual_robot == expected_robot
  end

  test "updates orientation to 90 when turning left from 180" do
    robot = %Robot{moves: ["L", "F", "R", "F", "F"], orientation: 180, valid: true, x: 2, y: 3}
    expected_robot = %Robot{moves: ["L", "F", "R", "F", "F"], orientation: 90, valid: true, x: 2, y: 3}
    actual_robot = Engine.update_orientation(:l, robot)

    assert actual_robot == expected_robot
  end

  test "updates orientation to 90 when turning right from 0" do
    robot = %Robot{moves: ["L", "F", "R", "F", "F"], orientation: 0, valid: true, x: 2, y: 3}
    expected_robot = %Robot{moves: ["L", "F", "R", "F", "F"], orientation: 90, valid: true, x: 2, y: 3}
    actual_robot = Engine.update_orientation(:r, robot)

    assert actual_robot == expected_robot
  end

  test "updates orientation to 0 when turning right from 270" do
    robot = %Robot{moves: ["L", "F", "R", "F", "F"], orientation: 270, valid: true, x: 2, y: 3}
    expected_robot = %Robot{moves: ["L", "F", "R", "F", "F"], orientation: 0, valid: true, x: 2, y: 3}
    actual_robot = Engine.update_orientation(:r, robot)

    assert actual_robot == expected_robot
  end

  test "move_forward updates y by 1 when facing north" do
    robot = %Robot{moves: ["L", "F", "R", "F", "F"], orientation: 0, valid: true, x: 2, y: 3}
    expected_robot = %Robot{moves: ["L", "F", "R", "F", "F"], orientation: 0, valid: true, x: 2, y: 4}
    actual_robot = Engine.move_forward(robot)

    assert actual_robot == expected_robot
  end

  test "move_forward updates y by -1 when facing south" do
    robot = %Robot{moves: ["L", "F", "R", "F", "F"], orientation: 180, valid: true, x: 2, y: 3}
    expected_robot = %Robot{moves: ["L", "F", "R", "F", "F"], orientation: 180, valid: true, x: 2, y: 2}
    actual_robot = Engine.move_forward(robot)

    assert actual_robot == expected_robot
  end

  test "move_forward updates x by 1 when facing east" do
    robot = %Robot{moves: ["L", "F", "R", "F", "F"], orientation: 90, valid: true, x: 2, y: 3}
    expected_robot = %Robot{moves: ["L", "F", "R", "F", "F"], orientation: 90, valid: true, x: 3, y: 3}
    actual_robot = Engine.move_forward(robot)

    assert actual_robot == expected_robot
  end

  test "move_forward updates x by -1 when facing west" do
    robot = %Robot{moves: ["L", "F", "R", "F", "F"], orientation: 270, valid: true, x: 2, y: 3}
    expected_robot = %Robot{moves: ["L", "F", "R", "F", "F"], orientation: 270, valid: true, x: 1, y: 3}
    actual_robot = Engine.move_forward(robot)

    assert actual_robot == expected_robot
  end
end
