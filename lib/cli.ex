defmodule Cli do
  def main(_args \\ []) do
    world = GetInputs.create_world(IO.gets("Enter the grid size: "))
    robots = GetInputs.build_robot(IO.gets("Enter robot state data: "), [])

    MarsRover.run(robots, world)
  end
end