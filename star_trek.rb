def prompt
	print "> "
end

def bridge
bridge_commands = <<COMMANDS
What is your command?
  a) Hail the enemy
  b) Shields up
  c) Fire torpedos
  d) Set a course and go to warp
COMMANDS

	enemies = ['Romulan Warbird has decloaked', 'Ferengi ship has appeared', 'Cardassian military vessel has appeared']
	shields = "Shields are up!"
	torpedos = "You fired #{rand(2..6).to_s} torpedos on the enemy."
	warp = "You went to warp and successfully escaped the enemy threat."

	puts "You are on the bridge and sit down in the Captain's chair.\nA %s near your ship." % enemies[rand(enemies.length())]
	puts ''
	puts bridge_commands
	prompt(); first_command = gets.chomp.downcase

	if first_command == "a" || first_command == "hail the enemy"
		puts "The enemy is not responding"
		puts ''
		puts bridge_commands
		second_command = gets.chomp; second_command.downcase!

		if second_command == "a" || second_command == "hail the enemy"
			puts "The enemy comes on the view screen."
			puts "They say, 'We apologize for any misunderstanding. We were having problems with our ship.'"
			puts "They fix their problem and go on there way. Congratulations, you solved the crisis without violence."
			puts "You win!"
			Process.exit(0)
		
		elsif second_command == "b" || second_command == "shields up"
			puts shields
			puts ''
			puts "The enemy recloaks and presumably leaves."
			puts "Congratulations! By putting the shields up before any other action you prevented an attack by the enemy."
			puts "You WIN!"
			Process.exit(0)

		elsif second_command == "c" || second_command == "fire torpedos"
			puts torpedos
			puts "The enemy ship takes damage but not enough to disable them."
			puts ''
			dead("The enemy ship fires back and without shields up, you are toast.")
		
		elsif second_command == "d" || second_command == "set a course and go to warp"
			puts warp
			ready_room()
		
		else
			bad_command()
			dead("While you hesitated the enemy made their move.")
		end

	elsif first_command == "b" || first_command == "shields up"
		puts shields
		puts ''
		puts bridge_commands
		prompt(); second_command = gets.chomp.downcase

		if second_command == "a" || second_command == "hail the enemy"
			puts "The enemy doesn't respond to your hails."
			puts "The enemy recloaks and presumably leaves."
			puts "Congratulations! By putting the shields up before any other action you prevented an attack by the enemy."
			puts "You WIN!"
			Process.exit(0)
		
		elsif second_command == "c" || second_command == "fire torpedos"
			puts torpedos
			puts "Your preemptive strike has damaged their ship."
			puts "The enemy recloaks and presumably leaves."
			puts "Congratulations! You chased the enemy away. That'll teach them to mess with the Enterprise."
			puts "You WIN!"
			Process.exit(0)
		
		else
			bad_command()
			puts "Your hesitation served you well. The enemy felt threatened enough by your shields to leave."
			Process.exit(0)
		end				
	
	elsif first_command == "c" || first_command == "fire torpedos"
		puts torpedos
		puts ''
		dead("However, they fire back and without shields up, you are toast.")
	
	elsif first_command == "d" || first_command == "set a course and go to warp"
		puts warp
		ready_room()
	
	else
		bad_command()
		bridge()
	end

end

def ready_room()
ready_room_commands = <<COMMANDS
What would you like to do?
  a) Tea, Earl Gray, Hot
  b) Stare out the window into the abyss of stars
  c) Sit at the desk and thumb through Shakespeare
COMMANDS

	tea = "Tea, Earl Gray, Hot"
	stars = "You walk to the window and stare out into the abyss of stars."

	puts "You are in the Captain's Ready Room."
	puts ''
	puts ready_room_commands
	prompt(); first_command = gets.chomp.downcase

	if first_command == "a"
		puts "You walk over to the replicator and say '#{tea}.'"
		puts ''
		puts ready_room_commands
		prompt(); second_command = gets.chomp.downcase

		if second_command == "b"
			puts "You walk over to the window with your tea and get lost staring at the stars."
			puts ''
			ready_room()

		elsif second_command == "c"
			puts "You sit down at the desk with your tea and thumb through the Shakespeare book."
			puts ''
			puts "Right as you finish your tea you are called to the Bridge."
			bridge()
		
		else
			bad_command()
			ready_room()
		end
	
	elsif first_command == "b"
		puts stars
		puts ''
		puts ready_room_commands
		prompt(); second_command = gets.chomp.downcase

		if second_command == "a"
			puts "You are hypnotized staring into the abyss of stars. You are unable to move to get #{tea}"
			puts ''
			puts "Time passes..."
			puts ''
			puts ready_room()

		elsif second_command == "c"
			puts "You sit down at the desk and open the book, but are immediately called to the Bridge."
			bridge()
		else
			puts "The glass unexpectedly shatters and sucks you out to space."
			puts "GAME OVER"
			Process.exit(0)
		end

	elsif first_command == "c"
		puts "You sit at the desk and delve into some Shakespeare tragedies."
		puts ''
		puts ready_room_commands
		prompt(); second_command = gets.chomp.downcase

		if second_command == "a"
			puts "You set down the Shakespeare book, walk over to the replicator and say #{tea}."
			puts ''
			puts "After drinking your tea, you decided to see how things are going on the Bridge."
			bridge()
		
		elsif second_command == "b"
			puts stars
			puts ''
			puts "You find yourself broken out of your reverie when you are called to the Bridge."
			bridge()
		
		else
			bad_command()
			ready_room()
		end
	
	else
		bad_command()
		ready_room()
	end
				
end

def start
intro = <<INTRO
You are on the Starship Enterprise-D. You get into the lift...where are you heading?
  a) The bridge
  b) Captain's Ready Room
INTRO
	
	puts intro
	puts ''
	prompt(); go = gets.chomp.downcase

	if go == "a"
		bridge()
	elsif go == "b"
		ready_room
	else
		bad_command()
		start()
	end
end

def dead(reason)
	puts "#{reason} Congratulations! You let the Enterprise-D get blown up!"
	puts "GAME OVER"
	Process.exit(0)
end

def bad_command
	puts "I'm sorry, I didn't understand your command."
end

start()