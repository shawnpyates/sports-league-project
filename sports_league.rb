puts "\n\tWelcome! In this program you will build a sports league by adding and modifying teams."
puts "\tSince you have just begun, your league currently has no teams in it."
puts "\tLet's begin!"

# start with empty league
$league = [];

$line_break = "*" * 50

$prompt = "> "

# add players to put into team rosters
def add_player
  print "\tWhat is the player's name? "
  player_name = $stdin.gets.chomp
  print "\tWhat's the player's jersey number? "
  player_number = $stdin.gets.chomp.to_i
  print "\tWhat's the player's position? "
  player_position = $stdin.gets.chomp
  hash = { "name" => player_name, "number" => player_number, "position" => player_position }
  return hash
end

# create new teams to put into league
def add_team
  print "\tWhere is the team located? "
  team_location = $stdin.gets.chomp
  print "\tWhat is the team's nickname? "
  team_name = $stdin.gets.chomp
  hash = { "location" => team_location, "name" => team_name, "roster" => [] }
  team_hash = hash
  loop do
    print "\tWould you like to add a new player to the roster? (y/n) "
    answer = $stdin.gets.chomp
    if answer.downcase === "y"
      team_hash["roster"].push(add_player())
      puts "\n\tThank you. Player added to roster.\n\n"
    end
    break if answer.downcase === "n"
  end
  $league.push(team_hash)
  puts "\n\tThank you. Now redirecting to main menu."
end


# print out team info
def print_team(team)
  puts "#{team["location"]} #{team["name"]}"
  puts $line_break
  puts "\tROSTER"
  puts "\n"
  if team["roster"].empty?
    puts "\t(This team's roster is empty.)"
  else
    # print out each player on the team
    team["roster"].each do |player|
      if player != team["roster"][0]
        puts "\t#{"-" * 10}"
      end
      puts "\tPlayer: #{player["name"]}"
      puts "\tNumber: #{player["number"]}"
      puts "\tPosition: #{player["position"]}"
    end
  end
  puts "\n#{$line_break}\n\n"
end

# print out league info
def print_league(league)
  print "\n"
  if league.empty?
    puts "\t(The league is currently empty.)"
    puts "\n"
  else
    # print out each team in the league
    i = 1
    league.each do |team|
      print "\t#{i}. "
      print_team(team)
      i += 1
    end
  end
end

# edit team's location
def edit_location(team)
  team_location = team["location"]
  team_name = team["name"]
  puts "\n\tThe team is currently located in #{team_location}. Where would you like to move the team?"
  print $prompt
  team_move = $stdin.gets.chomp
  puts "\n\tOkay. The team will hereby be known as the #{team_move} #{team_name}."
  return team_move
end

# edit team's name
def edit_name(team)
  team_location = team["location"]
  team_name = team["name"]
  puts "\n\tThe team is currently called the #{team_name}. What would you like the new name to be?"
  print $prompt
  team_name_change = $stdin.gets.chomp
  puts "\n\tOkay. The team will hereby be known as the #{team_location} #{team_name_change}."
  return team_name_change
end

# edit team's roster
def edit_roster(team)
  puts "
      What kind of edit would you like to make to the roster?
      (a) Add a new player.
      (r) Remove an existing player.
      (e) Edit an existing player.
  "
  print $prompt
  answer = $stdin.gets.chomp
  if answer === "a"
    loop do
      team["roster"].push(add_player())
      print_team(team)
      puts "\tWould you like to add another player to the roster? (y/n) "
      print $prompt
      y_or_n = $stdin.gets.chomp
      break if y_or_n.downcase === "n"
     end
  elsif answer === "r"
    if team["roster"].empty?
      puts "\tThis team's roster is current empty."
    else
      loop do
        puts "\tPlease select the player to remove by typing in the jersey number."
        print $prompt
        input_jersey = $stdin.gets.chomp.to_i
        team["roster"].each do |player|
          if input_jersey === player["number"]
            team["roster"].delete(player)
          end
        end
        print_team(team)
        puts "\tWould you like to remove another player from the roster? (y/n) "
        print $prompt
        y_or_n = $stdin.gets.chomp
        break if y_or_n.downcase === "n"
      end
    end
  elsif answer === "e"
    if team["roster"].empty?
      puts "\tThis team's roster is current empty."
    else
      puts "\n\tPlease select a player to edit by typing in the jersey number."
      print $prompt
      $input_jersey = $stdin.gets.chomp.to_i
      team["roster"].each do |player|
        if $input_jersey === player["number"]
          puts "\n\tYou have selected #{player["name"]}."
          puts "
            What would you like to edit?
            (n) Player's Name
            (j) Player's Jersey Number
            (p) Player's Position
          "
          print $prompt
          player_key = $stdin.gets.chomp
          if player_key === "n"
            puts "\n\tRight now, the player's name is #{player["name"]}. What would you like to change it to?"
            print $prompt
            change_name = $stdin.gets.chomp
            player["name"] = change_name
            puts "\n\tOkay, the player's name is now #{player["name"]}."
          elsif player_key === "j"
            puts "\n\tRight now, the player's jersey number is #{player["number"]}. What would you like to change it to?"
            print $prompt
            change_number = $stdin.gets.chomp.to_i
            player["number"] = change_number
            puts "\n\tOkay, the player's jersey number is now #{player["number"]}."
          elsif player_key === "p"
            puts "\n\tRight now, the player's position is #{player["position"]}. What would you like to change it to?"
            print $prompt
            change_position = $stdin.gets.chomp
            player["position"] = change_position
            puts "\n\tOkay, the player's position is now #{player["position"]}."
          end
        end
      end
    end
  end
  return team["roster"]
end


# main menu
def ask_user
  puts "
      Please choose from the following options:
      (a) Add team to league.
      (e) Edit team currently on list.
      (r) Remove team currently on list.
      (s) See league.
      (q) Quit.
  "
  print $prompt
  answer = $stdin.gets.chomp
  if answer.downcase === "q"
    puts "\n\tHere is the league you created:"
    puts "\n"
    print_league($league)
    exit(0)
  elsif answer.downcase === "a"
    add_team()
    ask_user()
  elsif answer.downcase === "s"
    print_league($league)
    ask_user()
  elsif answer.downcase === "r"
    if $league.empty?
      puts "\n\t(The league is currently empty.)"
      puts "\n"
      ask_user()
    else
      print_league($league)
      puts "\n\tPlease select a team to remove by entering the team's list number."
      print $prompt
      team_select = $stdin.gets.chomp.to_i - 1
      team_name = $league[team_select]["name"]
      $league.delete_at(team_select)
      puts "\n\t#{team_name} now removed."
      ask_user()
    end
  elsif answer.downcase === "e"
    if $league.empty?
      puts "\n\t(The league is currently empty.)"
      puts "\n"
      ask_user()
    else
      print_league($league)
      puts "\n\tPlease select a team to edit by entering the team's list number."
      print $prompt
      team_select = $stdin.gets.chomp.to_i - 1
      team_location = $league[team_select]["location"]
      team_name = $league[team_select]["name"]
      puts "\n\tYou have chosen to edit the #{team_location} #{team_name}. \n"
      print_team($league[team_select])
      puts "
      What would you like to edit?
      (l) Team Location
      (n) Team Name
      (r) Team Roster
        "
      print $prompt
      team_key = $stdin.gets.chomp
      if team_key.downcase === "l"
        $league[team_select]["location"] = edit_location($league[team_select])
      elsif team_key.downcase === "n"
        $league[team_select]["name"] = edit_name($league[team_select])
      elsif team_key.downcase === "r"
        $league[team_select]["roster"] = edit_roster($league[team_select])
      end
      ask_user()
    end
  end
end

ask_user()
