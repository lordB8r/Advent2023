defmodule Day02 do
    @red_cubes 12
    @green_cubes 13
    @blue_cubes 14

    def game_check(games, powers \\ false) do
        game_build = 
            games
            |> String.split("\n", trim: true)
            |> Enum.map(&(breakup_game(&1, powers)))
        
        case powers do
            false -> 
                game_build 
                |> Enum.sum
            true -> 
                game_build 
                |> Enum.map(&(evaluate_cubed_powers(&1)))
                |> Enum.sum
        end
    end

    def evaluate_cubed_powers(game) do
        game
        |> List.flatten
        |> Enum.group_by(&(&1[:key])) 
        |> Enum.reduce(
            [], fn {_key, list}, acc -> 
                [Enum.max_by(list, & &1)[:value] | acc]
            end)
        |> multiply()

    end

    defp multiply([nil | _]), do: 0
    defp multiply([]), do: 1
    defp multiply([head | tail]) do
        head * multiply(tail)
    end

    defp breakup_game(game, powers) do
        # "Game 1: 3 blue, 2 green, 1 red; 2 blue, 1 green, 1 red; 1 blue, 1 green, 1 red"
        [game_id, rounds | _] = game |> String.split(":", trim: true)
        [value |_] = game_id |> String.split("Game ", trim: true)
        

        # "3 blue, 2 green, 1 red; 2 blue, 1 green, 1 red; 1 blue, 1 green, 1 red"
        scored = 
            rounds
            |> String.split(";", trim: true)
            |> Enum.map(&(check_round(&1, powers)))

        case powers do
            false -> possible(scored, value)
            true -> scored
        end
        

    end

    defp possible(scored, value) do
        case Enum.member?(scored, :impossible) do
            true -> 0
            false -> value |> String.to_integer()    
        end
    end

    defp check_round(round, powers) do
        round 
        |> String.split(",", trim: true)
        |> score_round(powers)
    end

    defp score_round([], false), do: :possible
    defp score_round([], true), do: []
    defp score_round([pull | round], powers) do
        # 3 blue, 2 green, 1 red
        case breakdown_pull(pull, powers) do
            :impossible -> :impossible
            :possible -> score_round(round, powers)
            value -> [value | score_round(round, powers) ]
        end
    end    

    defp breakdown_pull(pull, powers) do
        # "3 blue"
        [choice, value | _ ] = 
            pull
            |> String.trim
            |> String.reverse
            |> String.split(" ", trim: true)
        
        pull_value = value |> String.reverse |> String.to_integer
        
        answer = 
            case choice do
                "eulb" -> possible_combos({:blue, pull_value})
                "neerg" -> possible_combos({:green, pull_value})
                "der" -> possible_combos({:red, pull_value})
            end
        case powers do
            false -> answer
            true  -> %{key: String.to_atom(String.reverse(choice)), value: pull_value}
        end
    end    

    defp possible_combos({:red, red}) when red > @red_cubes, do: :impossible
    defp possible_combos({:green, green}) when green > @green_cubes, do: :impossible
    defp possible_combos({:blue, blue}) when blue > @blue_cubes, do: :impossible
    defp possible_combos(_), do: :possible
end