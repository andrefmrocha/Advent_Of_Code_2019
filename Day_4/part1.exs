defmodule Day4 do

  defp valid([_], was_found) do
    if(was_found == :found)do
      true
    else
      false
    end
  end
  defp valid([h1, h2 | t], was_found) do
    if(h1 == h2) do
      if(h1 <= h2)do
        valid([h2 | t], :found)
      end
    else if(h1 <= h2)do
      valid([h2 | t], was_found)
    else
      false
    end
  end
  end

  defp range(min, max) do
    Enum.reduce(min..max, 0, fn x, acc ->
    if valid(Integer.to_charlist(x), :not_found) do
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
