defmodule ProcessMatchesTest do
  use ExUnit.Case


  test "always pass" do
    assert true
  end

  test "process matchup builds correct map" do
    match = %{is_tied: '0', teams: [%{team: '273.l.999999.t.1'}, %{team: '273.l.999999.t.2'}], week: '16', winner_team_key: '273.l.999999.t.1'}
    scores = Matches.process_matchup match
    IO.puts "scores..."
    IO.puts "#{inspect scores}"
    assert scores == [ %{ "273.l.999999.t.1" => :won},
                       %{ "273.l.999999.t.2" => :lost}
                     ]
  end


  test "process matchup builds correct map" do
    match = [%{is_tied: '0', teams: [%{team: '273.l.999999.t.1'}, %{team: '273.l.999999.t.2'}], week: '16', winner_team_key: '273.l.999999.t.1'}, %{is_tied: '0', teams: [%{team: '273.l.999999.t.4'}, %{team: '273.l.999999.t.6'}], week: '16', winner_team_key: '273.l.999999.t.4'}, %{is_tied: '0', teams: [%{team: '273.l.999999.t.5'}, %{team: '273.l.999999.t.9'}], week: '16', winner_team_key: '273.l.999999.t.9'}, %{is_tied: '0', teams: [%{team: '273.l.999999.t.8'}, %{team: '273.l.999999.t.10'}], week: '16', winner_team_key: '273.l.999999.t.10'}] 
    scores = Matches.process_matchups match
    IO.puts "scores..."
    IO.puts "#{inspect scores}"
    assert scores = %{ "273.l.999999.t.1" => :won, 
                       "273.l.999999.t.10" => :won, 
                       "273.l.999999.t.2" => :lost, 
                       "273.l.999999.t.4" => :won, 
                       "273.l.999999.t.5" => :lost, 
                       "273.l.999999.t.6" => :lost, 
                       "273.l.999999.t.8" => :lost, 
                       "273.l.999999.t.9" => :won}

  end




end
