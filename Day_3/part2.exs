defmodule Day3 do
  defp get_input() do
    File.read!("input1.txt")
    |> String.split("\n", trim: true)
    |> Enum.map(fn value -> String.split(value, ",")  end )
  end

  defp fill_right_board(board, num, x, y, num_steps) do
    if num == 0 do
      {board, x, y, num_steps}
    else
      Map.put(board, {x, y}, num_steps)
      |> fill_right_board(num - 1, x + 1, y, num_steps + 1)
    end
  end

  defp fill_left_board(board, num, x, y, num_steps) do
    if num == 0 do
      {board, x, y, num_steps}
    else
      Map.put(board, {x, y}, num_steps)
      |> fill_left_board(num - 1, x - 1, y, num_steps + 1)
    end
  end

  defp fill_up_board(board, num, x, y, num_steps) do
    if num == 0 do
      {board, x, y, num_steps}
    else
      Map.put(board, {x, y}, num_steps)
      |> fill_up_board(num - 1, x, y - 1, num_steps + 1)
    end
  end

  defp fill_down_board(board, num, x, y, num_steps) do
    if num == 0 do
      {board, x, y, num_steps}
    else
      Map.put(board, {x, y}, num_steps)
      |> fill_down_board(num - 1, x, y + 1, num_steps + 1)
    end
  end

  defp fill_board(board, [], _, _, _) do
    board
  end

  defp fill_board(board, [line | lines], x, y, num_steps) do
    num = String.to_integer(String.slice(line, 1..-1))
    type = String.at(line, 0)
    cond do
      type == "R" ->
        {new_board, new_x, new_y, new_steps} = fill_right_board(board, num, x, y, num_steps)
        fill_board(new_board, lines, new_x, new_y, new_steps)
      type == "L" ->
        {new_board, new_x, new_y, new_steps} = fill_left_board(board, num, x, y, num_steps)
        fill_board(new_board, lines, new_x, new_y, new_steps)
      type == "U" ->
        {new_board, new_x, new_y, new_steps} = fill_up_board(board, num, x, y, num_steps)
        fill_board(new_board, lines, new_x, new_y, new_steps)
      type == "D" ->
        {new_board, new_x, new_y, new_steps} = fill_down_board(board, num, x, y, num_steps)
        fill_board(new_board, lines, new_x, new_y, new_steps)
      true ->
        board
    end
  end

  defp parse_board(lines) do
    %{}
    |> fill_board(lines, 0, 0, 0)
  end


  def main() do
    [line1, line2] = get_input()
    circuit1 = parse_board(line1)
    circuit2 = parse_board(line2)
    Map.keys(circuit1)
    |> Enum.into(MapSet.new)
    |> MapSet.intersection(Enum.into(Map.keys(circuit2), MapSet.new))
    |> MapSet.delete({0, 0})
    |> Enum.map(fn key -> Map.get(circuit1, key,  :fail) + Map.get(circuit2, key,:fail) end)
    |> Enum.min(fn -> raise(Enum.EmptyError) end)
    |> IO.inspect
  end
end

Day3.main();
