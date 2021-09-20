defmodule Run do
  def main(_args \\ []) do
    world = GetInputs.create_world(IO.read(:stdio, :line))
    robots = GetInputs.build_robot(IO.read(:stdio, :line), [])

    MarsRover.run(robots, world)
  end
end