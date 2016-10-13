require './lib/binary_search_tree'

tree = BinarySearchTree.new
tree.load('movies.txt')

puts "Welcome to the Movie Tree!"
puts "Enter 'm' for method list. "
puts "Enter 'exit' when finished."

user_response = nil
until user_response == 'exit'
    user_response = gets.chomp
    case user_response
        when 'm' then puts "[depth_of, health, height, insert, leaves, load, max, min, root, sort]"
        when 'depth_of'
            puts "Enter movie score"
            score = gets.chomp
            puts tree.depth_of(score)
    end
end




