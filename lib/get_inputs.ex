alias Mars.World, as: World
alias Rover.Orientation, as: Orientation

defmodule GetInputs do
  @moduledoc """
  A module providing functions to fetch data from stdin and then parse to usable format
  """

  @doc ~S"""
  Recursively parses then return the list of robots when end of file is reached

  ## Examples

      iex> build_robot(IO.gets(""), [])
      [
        %Rover.Robot{moves: [F,F,L,F,R,F,F], orientation: 0, valid: true, x: 0, y: 2},
        %Rover.Robot{moves: [L,F,R,F,F], orientation: 90, valid: true, x: 2, y: 3}
      ]
  """
  @spec build_robot(:eof, list()) :: list()
  def build_robot(:eof, robot_list), do: Enum.reverse(robot_list) # Handle if run from file
  def build_robot("\n", robot_list), do: Enum.reverse(robot_list) # Handle if run from user input

  @spec build_robot(String.t(), list()) :: list()
  def build_robot(robot_data, robot_list) do
    try do
      [x, y, orientation, moves] = robot_data
                                   |> String.trim()
                                   |> String.replace(["(", ")", ","], "")
                                   |> String.split()

      robot = %Rover.Robot{
        :x => String.to_integer(x),
        :y => String.to_integer(y),
        :orientation => Orientation.cardinal_direction_to_degrees(orientation),
        :valid => true,
        :moves => moves |> String.graphemes()
      }

      # Prepend to list and reverse later for performance
      build_robot(IO.read(:stdio, :line), [robot | robot_list])
    rescue
      _ -> IO.puts("Something went wrong, did you enter an invalid robot state?")
           System.halt(0)
    end
  end

  @doc ~S"""
  Gets starting position from stdin and transform to list

  ## Examples

      iex> create_world("4 8")
      %World{columns: 8, rows: 4, size: 32}
  """
  @spec create_world(String.t()) :: map()
  def create_world(position_string) do
    try do
      [m, n] = position_string
               |> String.trim()
               |> String.split()
               |> Enum.map(fn element -> String.trim(element) |> String.to_integer() end)

      %World{:rows => m, :columns => n, :size => (m * n)}
    rescue
      _ -> IO.puts("Something went wrong, did you enter an invalid grid size?")
           System.halt(0)
    end
  end
end
