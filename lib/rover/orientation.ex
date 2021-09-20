alias Rover.Robot, as: Robot
alias Mars.World, as: World

defmodule Rover.Orientation do
  @moduledoc """
  Provides information about the Rover.Orientation of a robot
  """

  @cardinal_direction_to_degree_atoms_map %{:n => 0, :e => 90, :s => 180, :w => 270}
  @degrees_to_cardinal_direction_map %{0 => "N", 90 => "E", 180 => "S", 270 => "W"}
  @cardinal_direction_atom_list [:n, :s, :e, :w]
  @left_right_atom_list [:l, :r]

  @doc """
  Converts N,S,E,W to degrees

  ## Examples
      iex> Rover.Orientation.cardinal_direction_to_degrees("N")
      0
  """
  @spec cardinal_direction_to_degrees(String.t()) :: integer()
  def cardinal_direction_to_degrees(cardinal_direction) when is_bitstring(cardinal_direction) do
    cardinal_direction
    |> String.downcase()
    |> String.to_atom()
    |> (&Map.get(@cardinal_direction_to_degree_atoms_map, &1)).()
  end

  @doc """
  Converts degrees to N,S,E,W

  ## Examples
      iex> Rover.Orientation.degrees_to_cardinal_direction(0)
      "N"
  """
  @spec degrees_to_cardinal_direction(integer()) :: String.t()
  def degrees_to_cardinal_direction(degrees) when is_integer(degrees) do
    Map.get(@degrees_to_cardinal_direction_map, degrees)
  end

  @doc """
  Checks if the string represents forward

  ## Examples
      iex> Rover.Orientation.is_forward("F")
      true
  """
  @spec is_forward(String.t()) :: boolean()
  def is_forward(maybe_forward) when is_bitstring(maybe_forward) do
    maybe_forward
    |> String.downcase()
    |> String.to_atom()
    |> case do
      :f -> true
      _ -> false
    end
  end

  @doc """
  Checks if the string represents cardinal direction, N S E W

  ## Examples
      iex> Rover.Orientation.is_cardinal_direction("N")
      true
  """
  @spec is_cardinal_direction(String.t()) :: boolean()
  def is_cardinal_direction(maybe_cardinal_direction) when is_bitstring(maybe_cardinal_direction) do
    maybe_cardinal_direction
    |> String.downcase()
    |> String.to_atom()
    |> (&Enum.member?(@cardinal_direction_atom_list, &1)).()
  end

  @doc """
  Checks if the string represents l or r

  ## Examples
      iex> Rover.Orientation.is_left_or_right("r")
      true
  """
  @spec is_left_or_right(String.t()) :: boolean()
  def is_left_or_right(maybe_left_or_right) when is_bitstring(maybe_left_or_right) do
    maybe_left_or_right
    |> String.downcase()
    |> String.to_atom()
    |> (&Enum.member?(@left_right_atom_list, &1)).()
  end

  @doc """
  Checks if the robot is off the grid of the world and returns true if off grid

  ## Examples
      iex> robot = %Robot{moves: ["L", "F", "R", "F", "F"], orientation: 0, valid: true, x: 2, y: 20}
      iex> world = %World{columns: 8, rows: 4, size: 32}
      iex> Rover.Orientation.is_lost(robot, world)
      true
  """
  @spec is_lost(%Robot{}, %World{}) :: boolean()
  def is_lost(robot, world) do
    cond do
      robot.x < 0 -> true
      robot.x > world.columns -> true
      robot.y < 0 -> true
      robot.y > world.rows -> true
      true -> false
    end
  end
end
