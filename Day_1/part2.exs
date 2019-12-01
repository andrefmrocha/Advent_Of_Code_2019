defmodule Day1 do
  defp get_input() do
    File.read!("input1.txt")
    |> String.split("\n", trim: true)
  end

  def get_fuel(mass) do
    floor(mass / 3) - 2
  end

  def calculate_fuel(value) do
    if get_fuel(value) < 0 do
      0
    else
      fuel = get_fuel(value)
      fuel + calculate_fuel(fuel)
    end
  end

  def get_value(values) do
    Enum.map(values, fn value ->
      num = String.to_integer(value)
      calculate_fuel(num)
    end)
    |> Enum.sum

  end

  def main do
    get_input()
    |> get_value
    |> IO.puts
  end
end

Day1.main()

