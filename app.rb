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

number_of_longest_routes = all_possible_routes.count { |route| route.count == all_possible_routes.last.length }

longest_routes = all_possible_routes.last(number_of_longest_routes) 

longest_routes.each do |route|
	run = []
	route.each do |coordinate|
		run << map[coordinate.first][coordinate.last]
	end
	all_runs << run
end

drop = []
all_runs.each do |run|
	drop << run.first - run.last
end

all_possible_routes.each do |r|
	p r 
end

p best_run = all_runs[drop.index(drop.max)]








