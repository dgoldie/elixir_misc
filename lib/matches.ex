defmodule Matches do
   def process_matchups(matchups) do
    IO.puts "processing matchups...."
    list_of_matchups = get_in(matchups, [:matchups])
    IO.puts "list of matches = #{inspect list_of_matchups}"
    all = fn :get, data, next -> Enum.map(data, next) end

    {_, result} = list_of_matchups
      |> Enum.map(&process_matchup/1)
      |> List.flatten
      |> Enum.map_reduce( %{}, fn(x, acc) -> {:ok, Dict.merge(x, acc)} end)
      # |> merge_match_scores

    IO.puts "process matchups reslut = #{inspect result}"
    result
  end


   def process_matchup(matchup) do
    all = fn :get, data, next -> Enum.map(data, next) end

    case matchup do
      %{is_tied: '0'} ->
        scores = %{}
        winner = matchup[:winner_team_key]
        
        team_keys = matchup
          |> get_in([:teams])
          |> get_in([all, :team])
          |> Enum.map(&to_string/1)
          |> Enum.map( fn(x) ->
               value =
                 case x == to_string(matchup[:winner_team_key]) do
                   true -> :won
                   false -> :lost
                 end
               IO.puts "value - #{inspect value}"
               score = put_in(scores, [x], value)
               IO.puts "score in loop - #{inspect score}"
               score
          end)

        IO.puts "keys = #{inspect team_keys}"
        IO.puts "scores = #{inspect scores}"
        IO.puts "winner = #{inspect winner}"
        team_keys

      _ -> 
        # scores = %{}
        # team_keys = matchup
        #   |> get_in([:teams])
        #   |> get_in([all, :team])
        #   scores = put_in(scores, [x], :tied)

    end
  end
end
