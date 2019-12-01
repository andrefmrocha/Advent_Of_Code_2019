defmodule Day2 do
  defp read_input() do
    File.read!('input.txt')
    |> String.split(",", trim: true)
    |> Enum.map(&String.trim/1)
    |> Enum.map(&String.to_integer/1)
  end

  defp addition(values, second, third) do
    firstValue = Enum.at(values, second)
    secondValue = Enum.at(values, third)
    firstValue + secondValue
  end

  defp multiply(values, second, third) do
    firstValue = Enum.at(values, second)
    secondValue = Enum.at(values, third)
    firstValue * secondValue
  end

  defp  update_value(value, fourth, values) do
    List.update_at(values, fourth, fn _ -> value end)
  end

  defp process_data(values, index) do
    first = Enum.at(values, index)
    second = Enum.at(values, index + 1)
    third = Enum.at(values, index + 2)
    fourth = Enum.at(values, index + 3)
    cond do
      first == 1 ->
        addition(values, second, third)
        |> update_value(fourth, values)
        |> process_data(index + 4)
    first == 2 ->
        multiply(values, second, third)
        |> update_value(fourth, values)
        |> process_data(index + 4)
    true ->
      Enum.at(values, 0)
    end
  end

  def main() do
    read_input()
    |> process_data(0)
    |> IO.puts
  end
end


Day2.main()
