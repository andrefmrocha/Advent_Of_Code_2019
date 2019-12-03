defmodule Day3 do
  defp get_input() do
    File.read!("input1.txt")
    |> String.split("\n", trim: true)
    |> Enum.map(fn value -> String.split(value, ",")  end )
  end

  defp fill_right_board(board, num, x, y) do
    if num == 0 do
      {board, x, y}
    else
      MapSet.put(board, {x, y})
      |> fill_right_board(num - 1, x + 1, y)
    end
  end

  defp fill_left_board(board, num, x, y) do
    if num == 0 do
      {board, x, y}
    else
      MapSet.put(board, {x, y})
      |> fill_left_board(num - 1, x - 1, y)
    end
  end

  defp fill_up_board(board, num, x, y) do
    if num == 0 do
      {board, x, y}
    else
      MapSet.put(board, {x, y})
      |> fill_up_board(num - 1, x, y - 1)
    end
  end

  defp fill_down_board(board, num, x, y) do
    if num == 0 do
      {board, x, y}
    else
      MapSet.put(board, {x, y})
      |> fill_down_board(num - 1, x, y + 1)
    end
  end

  defp fill_board(board, [], _, _) do
    board
  end

  defp fill_board(board, [line | lines], x, y) do
    num = String.to_integer(String.slice(line, 1..-1))
    type = String.at(line, 0)
    cond do
      type == "R" ->
        {new_board, new_x, new_y} = fill_right_board(board, num, x, y)
        fill_board(new_board, lines, new_x, new_y)
      type == "L" ->
        {new_board, new_x, new_y} = fill_left_board(board, num, x, y)
        fill_board(new_board, lines, new_x, new_y)
      type == "U" ->
        {new_board, new_x, new_y} = fill_up_board(board, num, x, y)
        fill_board(new_board, lines, new_x, new_y)
      type == "D" ->
        {new_board, new_x, new_y} = fill_down_board(board, num, x, y)
        fill_board(new_board, lines, new_x, new_y)
      true ->
        board
    end
  end

  defp parse_board(lines) do
    MapSet.new()
    |> fill_board(lines, 0, 0)
  end


  def main() do
    [line1, line2] = get_input()
    circuit1 = parse_board(line1)
    circuit2 = parse_board(line2)
    MapSet.intersection(circuit1, circuit2)
    |> MapSet.delete({0, 0})
    |> MapSet.to_list
    |> Enum.map(fn {x, y} -> abs(x - 0) + abs(y - 0) end)
    |> Enum.min(fn -> raise(Enum.EmptyError) end)
    |> IO.inspect
  end
end

Day3.main();
