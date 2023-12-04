defmodule Day01 do
    @moduledoc """
    --- Day 1: Trebuchet?! ---

    Something is wrong with global snow production, and you've been selected to take a look. The Elves have even given you a map; on it, they've used stars to mark the top fifty locations that are likely to be having problems.

    You've been doing this long enough to know that to restore snow operations, you need to check all fifty stars by December 25th.

    Collect stars by solving puzzles. Two puzzles will be made available on each day in the Advent calendar; the second puzzle is unlocked when you complete the first. Each puzzle grants one star. Good luck!

    You try to ask why they can't just use a weather machine ("not powerful enough") and where they're even sending you ("the sky") and why your map looks mostly blank ("you sure ask a lot of questions") and hang on did you just say the sky ("of course, where do you think snow comes from") when you realize that the Elves are already loading you into a trebuchet ("please hold still, we need to strap you in").

    As they're making the final adjustments, they discover that their calibration document (your puzzle input) has been amended by a very young Elf who was apparently just excited to show off her art skills. Consequently, the Elves are having trouble reading the values on the document.

    The newly-improved calibration document consists of lines of text; each line originally contained a specific calibration value that the Elves now need to recover. On each line, the calibration value can be found by combining the first digit and the last digit (in that order) to form a single two-digit number.

    For example:

    1abc2
    pqr3stu8vwx
    a1b2c3d4e5f
    treb7uchet

    In this example, the calibration values of these four lines are 12, 38, 15, and 77. Adding these together produces 142.

    Consider your entire calibration document. What is the sum of all of the calibration values?

    """
    
    @doc """
    Sum values
    
    ## Examples
    
        iex> Day01.sum_calibrations(string)
        integer
    
    """
    def sum_calibrations(string) do
        string
        |> String.split("\n", trim: true)
        |> Enum.map(&split_line/1)
        |> Enum.sum
    end
    
    def split_line(line) do
        list = 
            line
            |> String.downcase
            |> String.split("", trim: true) 
            |> convert_values
            |> String.split("", trim: true)
        first = List.first(list)
        last = List.last(list)
        {value, _} = first <> last |> Integer.parse 
        value
    end

    defp convert_values([]), do: ""
    defp convert_values(["z","e","r","o" | t]), do: "0" <> convert_values(["o" | t])
    defp convert_values(["o","n","e" | t]), do: "1" <> convert_values(["e" | t])
    defp convert_values(["t","w","o" | t]), do: "2" <> convert_values(["o" | t])
    defp convert_values(["t","h","r","e","e" | t]), do: "3" <> convert_values(["e" | t ])
    defp convert_values(["f","o","u","r" | t]), do: "4" <> convert_values(t)
    defp convert_values(["f","i","v","e" | t]), do: "5" <> convert_values(["e" | t])
    defp convert_values(["s","i","x" | t]), do: "6" <> convert_values(t)
    defp convert_values(["s","e","v","e","n" | t]), do: "7" <> convert_values(["n" | t])
    defp convert_values(["e","i","g","h","t" | t]), do: "8" <> convert_values(["t" | t])
    defp convert_values(["n","i","n","e" | t]), do: "9" <> convert_values(["e" | t])
    
    defp convert_values(["0" | t]), do: "0" <> convert_values(t)
    defp convert_values(["1" | t]), do: "1" <> convert_values(t)
    defp convert_values(["2" | t]), do: "2" <> convert_values(t)
    defp convert_values(["3" | t]), do: "3" <> convert_values(t)
    defp convert_values(["4" | t]), do: "4" <> convert_values(t)
    defp convert_values(["5" | t]), do: "5" <> convert_values(t)
    defp convert_values(["6" | t]), do: "6" <> convert_values(t)
    defp convert_values(["7" | t]), do: "7" <> convert_values(t)
    defp convert_values(["8" | t]), do: "8" <> convert_values(t)
    defp convert_values(["9" | t]), do: "9" <> convert_values(t)
    defp convert_values([_ | t]), do: convert_values(t)
    # defp convert_values([_h]), do: ""

end


