defmodule Day_03 do
    def coordinate_solver(input) do
      coordinates = 
        input
        |> String.split("\n", trim: true)
        |> get_coordinates
      
      relevant_numbers =
        Enum.filter(coordinates, fn {line, {col_start, col_end}} ->
          line
          |> adjacent_positions(col_start, col_end)
          |> Enum.any?(&is_symbol?(input, &1))
        end)
  
      Enum.reduce(relevant_numbers, 0, fn coordinates, acc ->
        acc + extract_number(input, coordinates)
      end)
    end

    defp get_coordinates(input) do
      for {line_content, line_num} <- Enum.with_index(input),             # line and index
          matches <- Regex.scan(~r/\d+/, line_content, return: :index),   # matches that have digits (thx regex)
          {col, length} <- matches do                                     # col and length of the match
        {line_num, {col, col + length - 1}}
      end
    end
  
    defp adjacent_positions(line, col_start, col_end) do
      Enum.flat_map((line - 1)..(line + 1), fn y ->
        Enum.flat_map((col_start - 1)..(col_end + 1), fn x ->
          [{x, y}]
        end)
      end)
    end
      
    defp is_symbol?(input, {x, y}) do
      if line = Enum.at(input, y) do
        if string = String.at(line, x), do: String.match?(string, ~r/[^.\d]/)
      end
    end
  
    def coordinate_solver_part_2(input) do
      coordinates = 
        input
        |> String.split("\n", trim: true)
        |> get_coordinates
  
      possible_gears =
        for {line_content, line} <- Enum.with_index(input),
            matches <- Regex.scan(~r/\*/, line_content, return: :index),
            {col, 1} <- matches do
          {line, col}
        end
  
      Enum.reduce(possible_gears, 0, fn {line, col}, acc ->
        adjacents = adjacent_positions(line, col, col)
  
        adjacent_numbers = flatten(adjacents, coordinates)
  
        if Enum.count(adjacent_numbers) == 2 do
          power =
            adjacent_numbers
            |> Enum.map(&extract_number(input, &1))
            |> Enum.reduce(1, &Kernel.*/2)
  
          acc + power
        else
          acc
        end
      end)
    end

    defp flatten(adjacents, coordinates) do
      Enum.flat_map(adjacents, fn {x, y} ->
        Enum.filter(coordinates, fn {line, {from, to}} ->
          line == y && from <= x && to >= x
        end)
      end)
      |> Enum.uniq()
    end
  
    defp extract_number(input, {line, {from, to}}) do
      input
      |> Enum.at(line)
      |> String.slice(from, to - from + 1)
      |> String.to_integer()
    end
  end

