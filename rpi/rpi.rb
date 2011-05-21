#  RPI = 0.25 * WP + 0.50 * OWP + 0.25 * OOWP
# wp is the fraction of games a team has one
# opponents winning percentage is average WP of all opponents (minus games played against you)
# oowp is average owp of all a teams opponents
#
#
class Array; def sum; inject( nil ) { |sum,x| sum ? sum+x : x }; end; end
class Array; def mean; sum / size; end; end

TEAMS_GAMES = []
def get_teams_games(team_num)
  TEAMS_GAMES[team_num]
end

TEAMS_OPPONENTS = []
def get_opponents(team_num, played_games)
  if TEAMS_OPPONENTS.include?(team_num)
    TEAMS_OPPONENTS[team_num]
  else
    opponents = []
    played_games.each do |key, value|
      opponents << key.sub("#{team_num}-","").to_i
    end
    TEAMS_OPPONENTS[team_num] = opponents
  end
end

def get_wp_minus_team(team_num, minus_team_num)
  team_games = get_teams_games(team_num)
  game_key = "#{team_num}-#{minus_team_num}"
  result = team_games[game_key]
  if result
    wp = (GAMES_WON[team_num] - result.to_i) / (team_games.size - 1).to_f
  else
    wp = GAMES_WON[team_num].to_f / team_games.size.to_f
  end
  wp
end

TEAM_WP = []
TEAM_OWP = []
GAMES_WON = []

ARGF.readline
count = 0
ARGF.each do |input|
  count += 1
  TEAMS_GAMES.clear
  GAMES_WON.clear
  TEAMS_OPPONENTS.clear
  TEAM_WP.clear
  TEAM_OWP.clear

  puts "Case ##{count}:"

  team_count = input.to_i
  # Build out the results table
  team_count.times do |team_num|
    GAMES_WON[team_num] = 0
    teams_games = {}
    teams_opponents = []
    results = ARGF.readline.strip.split(//)
    results.each_with_index do |result, other_team|
      if result == "1"
          GAMES_WON[team_num] += 1
      end
      next if result == "."
      teams_games["#{team_num}-#{other_team}"] = result.to_i
      teams_opponents << other_team
    end
    TEAMS_GAMES[team_num] = teams_games
    TEAMS_OPPONENTS[team_num] = teams_opponents
  end

  team_count.times do |team_num|
    # Calculate the wp
    team_games = get_teams_games(team_num)
    #puts "Games for #{team_num}: #{team_games.inspect}"
    TEAM_WP[team_num] = GAMES_WON[team_num].to_f / team_games.size.to_f
    #puts "#{team_num} WP = #{TEAM_WP[team_num]}"

    # Calculate opponents WP, minus the games you played against them
    other_wps_list = []
    opponents = get_opponents(team_num, team_games)
    #puts "opponenets #{opponents.inspect}"
    opponents.each do |other_team|
      other_wps_list << get_wp_minus_team(other_team, team_num)
    end
    TEAM_OWP[team_num] = other_wps_list.mean
    #puts "#{team_num} OWP = #{TEAM_OWP[team_num]}"
  end

  team_count.times do |team_num|
    team_games = get_teams_games(team_num)
    opponents = get_opponents(team_num, team_games)
    oowp_list = []
    oowp = opponents.each do |other_team|
      oowp_list << TEAM_OWP[other_team]
    end
    oowp = oowp_list.mean
    #puts "#{team_num} OOWP #{oowp}"
    rpi = 0.25 * TEAM_WP[team_num] + 0.5 * TEAM_OWP[team_num] + 0.25 * oowp
    puts rpi.round(12)
  end

end
