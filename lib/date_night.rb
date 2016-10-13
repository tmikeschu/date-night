require './lib/binary_search_tree'

tree = BinarySearchTree.new
tree.load('movies.txt')

puts "\nWelcome to the Movie Tree!"
puts "\nEnter 'm' for method list. "
puts "Enter 'exit' when finished."
puts ""

user_response = nil
until user_response == 'exit'
    user_response = gets.chomp
    case user_response
        when 'm' then puts "[depth_of, health, height, include?, insert, leaves, load, max, min, root, sort]"
        when 'depth_of'
            print "Enter movie score > "
            score = gets.chomp.to_i
            puts "The depth at #{score} is #{tree.depth_of(score)}"
        when 'health'
            print  "Enter the depth of the tree > "
            depth = gets.chomp.to_i
            puts "Diagnostics at depth #{depth}: #{tree.health(depth)}"
        when 'height'
            puts "The tree is #{tree.height} levels high."
        when 'include?'
            print "Enter movie score > "
            score = gets.chomp.to_i
            puts tree.include?(score)
        when 'insert'
            puts "Enter a movie, then its score."
            title = gets.chomp
            score = gets.chomp.to_i
            puts "#{title} was inserted at level #{tree.insert(score, title)}."
        when 'leaves'
            puts "This tree has #{tree.leaves} leaves."
        when 'load'
            puts "Enter the file name (with extension) > "
            file = gets.chomp
            puts "Inserted #{tree.load(file)} new movies."
        when 'max'
            movie = tree.max
            puts "The highest rated movie is #{movie.keys[0]}, with a score of #{movie.values[0]}."
        when 'min'
            movie = tree.min
            puts "The lowest rated movie is #{movie.keys[0]}, with a score of #{movie.values[0]}."
        when 'root'
            movie = tree.root.title_and_score
            puts "The parent node of this tree is #{movie.keys[0]}, with a score of #{movie.values[0]}."
        when 'sort'
            puts "Here are all the movies in order by score:"
            puts tree.sort
        else
            puts "Unrecognized method. Try again!" unless user_response == 'exit'
    end
end

puts "\nThanks for checking out the Movie Tree!"
puts ""



