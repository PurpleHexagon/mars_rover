require Logger
alias Rover.Robot, as: Robot
alias Mars.World, as: World
alias Rover.Orientation, as: Orientation
alias Rover.Engine, as: Engine

# TODO: Cohesion of this module is poor and needs to be split out into separate logical/functional cohesive modules
defmodule MarsRover do
  @moduledoc """
  Documentation for `MarsRover`.
  """

  @doc """
  Run the mars rover program

  ## Examples
      iex> MarsRover.run()
      "(0, 4, W) LOST"
  """
  @spec run(list(), %World{}) :: any()
  def run(robots, world) do
    try do
      step_through_robots(robots, world)
    rescue
      e -> Logger.error(e)
           IO.puts("Sorry something went wrong")
    end
  end

  @doc """
  Recursive function to step through the robots one by one
  """
  @spec step_through_robots(list(), %World{}) :: any()
  def step_through_robots([], _world) do end

  def step_through_robots([robot | robots_tail], world) do
    outputter(next_move(robot.moves, robot, world))
    step_through_robots(robots_tail, world)
  end

  @doc """
  Recursive function to step through moves queue and handles movement and validation of robot
  """
  @spec next_move(list(), %Robot{}, %World{}) :: %Robot{}
  def next_move([], robot, _world), do: robot

  def next_move([next_in_queue | moves_tail], robot, world) do
    new_robot = cond do
      Orientation.is_left_or_right(next_in_queue) -> Engine.update_orientation(next_in_queue |> normalize, robot)
      Orientation.is_forward(next_in_queue) -> Engine.move_forward(robot)
      true -> raise("Invalid move encountered")
    end

    cond do
      Orientation.is_lost(new_robot, world) == false
        -> next_move(moves_tail, Map.put(new_robot, :moves, moves_tail) |> Map.put(:moves, moves_tail), world)
      Orientation.is_lost(new_robot, world) == true
        -> Map.put(robot, :moves, moves_tail) |> Map.put(:valid, false)
    end
  end

  # Outputs the final result to stdout
  # TODO: Move to a dedicated module
  @spec outputter(%Robot{}):: any()
  defp outputter(robot) do
    is_lost = case Map.get(robot, :valid) do
      false -> "LOST"
      _ -> ""
    end

    IO.puts("(#{robot.x}, #{robot.y}, #{Orientation.degrees_to_cardinal_direction(robot.orientation)}) #{is_lost}")
  end

  # Normalize value to the standardly used downcased atom
  # TODO: Move to a dedicated module
  @spec normalize(String.t()) :: atom()
  defp normalize(value) do
    value
    |> String.downcase()
    |> String.to_atom()
  end
end
