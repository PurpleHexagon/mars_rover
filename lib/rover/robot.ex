defmodule Rover.Robot do
  @moduledoc """
  A struct representing a robot, having a set of coordinates, an orientation (EG: East), whether is valid (On Grid)
  and a queue of moves which can be run to move the robot through the world
  """

  defstruct [:x, :y, :orientation, :valid, :moves]
end