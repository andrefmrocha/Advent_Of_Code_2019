defmodule Day1 do
  defp get_input() do
    File.read!("input1.txt")
    |> String.split("\n", trim: true)
  end

  def get_value(values) do
    Enum.map(values, fn value ->
      num = String.to_integer(value)
      floor(num / 3) - 2
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
