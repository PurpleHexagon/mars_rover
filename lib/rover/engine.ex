alias Rover.Robot, as: Robot

defmodule Rover.Engine do
  @moduledoc """
  Setof functions to move a robot forward and reorientate
  """

  @doc """
  Update the orientation of a robot, turning either left or right and returning the updated robot state

  ## Examples
      iex> robot = %Robot{moves: ["L", "F", "R", "F", "F"], orientation: 0, valid: true, x: 2, y: 3}
      iex> Rover.Engine.update_orientation(:l, robot)
      %Robot{moves: ["L", "F", "R", "F", "F"], orientation: 270, valid: true, x: 2, y: 3}
  """
  @spec update_orientation(atom(), %Robot{}) :: %Robot{}
  def update_orientation(left_or_right, robot) when left_or_right == :l do
    new_orientation = robot.orientation - 90
    Map.put(robot, :orientation, (if new_orientation < 0, do: 270, else: new_orientation))
  end

  def update_orientation(left_or_right, robot) when left_or_right == :r do
    new_orientation = robot.orientation + 90
    Map.put(robot, :orientation, (if new_orientation >= 360, do: 0, else: new_orientation))
  end

  @doc """
  Move the robot forward, depending on its current orientation this will either alter x or y state

  ## Examples
      iex> robot = %Robot{moves: ["L", "F", "R", "F", "F"], orientation: 0, valid: true, x: 2, y: 3}
      iex> Rover.Engine.move_forward(robot)
      %Robot{moves: ["L", "F", "R", "F", "F"], orientation: 0, valid: true, x: 2, y: 4}
  """
  @spec move_forward(%Robot{}) :: %Robot{}
  def move_forward(%Robot{orientation: 0} = robot) do
    Map.put(robot, :y, robot.y + 1)
  end

  def move_forward(%Robot{orientation: 90} = robot) do
    Map.put(robot, :x, robot.x + 1)
  end

  def move_forward(%Robot{orientation: 180} = robot) do
    Map.put(robot, :y, robot.y - 1)
  end

  def move_forward(%Robot{orientation: 270} = robot) do
    Map.put(robot, :x, robot.x - 1)
  end
end