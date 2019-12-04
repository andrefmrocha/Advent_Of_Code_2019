defmodule Day4 do

  def valid([h1, h2, h3 | t]) do
    cond do
      h1 == h2 && h1 != h3 && h1 -> valid([h1, h2, h3 | t], :found)
      true -> valid([h1, h2, h3 | t], :not_found)
    end
  end

  def valid([h1, h2, h3], was_found) do
    cond do
      h2 == h3 && h2 != h1 && h2 <= h3 && h1 <= h2 -> true
      h2 <= h3 && was_found == :found && h1 <= h2 -> true
      true -> false
    end
  end

  def valid([h1, h2, h3, h4 | t], was_found) do
    cond do
      h2 == h3 && h1 != h2 && h2 != h4 && h2 <= h3 && h1 < h2 -> valid([h2, h3, h4 | t], :found)
      h2 <= h3 && h1 <= h2 -> valid([h2, h3, h4 | t], was_found)
      true -> false
    end
  end

  defp range(min, max) do
    Enum.reduce(min..max, 0, fn x, acc ->
    if valid(Integer.to_charlist(x)) do
      acc + 1
    else
      acc
    end
  end)
  end

  def main() do
    range(178416, 676461)
    |> IO.inspect
  end
end


Day4.main()
