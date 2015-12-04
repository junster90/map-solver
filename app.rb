class Mountain

	attr_accessor :map, :grid

	def initialize(file)
		@map = File.readlines(file).map do |line|
  		line.split.map(&:to_i)
  	end
  	@grid = @map.shift
  end

end

niseko = Mountain.new('map.txt')
map = niseko.map

# defining grid limits
x_limit = niseko.grid.first - 1
y_limit = niseko.grid.last - 1

# defining variables needed
all_possible_routes = []
all_runs = []

# find all starting points
map.each_with_index do |row, y|
	row.each_with_index do |elevation, x|
		all_possible_routes << [[y,x]]
	end
end

# loops through the final coordinates of all existing routes to find new possibilities of moving and appends them to the list
all_possible_routes.each do |route|

		y = route.last[0]
		x = route.last[1]

		# checking north
		if y > 0 && map[y][x] > map[y-1][x] 
			new_route = route
			new_route += [[y-1, x]]
			all_possible_routes << new_route
		end

		# checking south
		if y < y_limit && map[y][x] > map[y+1][x] 
			new_route = route
			new_route += [[y+1, x]]
			all_possible_routes << new_route
		end	

		# checking east
		if x > 0 && map[y][x] > map[y][x-1] 
			new_route = route
			new_route += [[y, x-1]]
			all_possible_routes << new_route
		end	

		# checking west
		if x < x_limit && map[y][x] > map[y][x+1] 
			new_route = route
			new_route += [[y, x+1]]
			all_possible_routes << new_route
		end	
end

# count the number of longest routes
number_of_longest_routes = all_possible_routes.count { |route| route.count == all_possible_routes.last.length }

# finding the longest routes
longest_routes = all_possible_routes.last(number_of_longest_routes) 

# finding the coordinates of the longest runs
longest_routes.each do |route|
	run = []
	route.each do |coordinate|
		run << map[coordinate.first][coordinate.last]
	end
	all_runs << run
end

# finding the biggest drop
drop = []
all_runs.each do |run|
	drop << run.first - run.last
end

# printing the best run
p best_run = all_runs[drop.index(drop.max)]
puts "The best run is #{best_run.length} in length!"
puts "It has a drop of #{drop.max}!"








