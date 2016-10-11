require './lib/node'
require 'pry'
class BinarySearchTree 
    attr_accessor :root,
                  :sorted_movies,
                  :left,
                  :right
    
    def initialize
        @root  = nil
        @left = left
        @right = right
        @sorted_movies = []
    end

    def insert(score, title)
        if root.nil?
            @root = Node.new(score, title)
            root.depth
        else 
            root.insert(score, title)
        end
    end

    def include?(score)
        if root.movie.values.first == score
            true
        else
            root.include?(score)
        end
    end

    def depth_of(score)
        root.depth_of(score)
    end
    
    def max
        root.max
    end

    def min
        root.min
    end

    def sort
        if root.left.nil?
            sorted_movies << root.movie
        else    
            root.sort 
        end
    end
    
    def load(file)
        movies_file = File.open("./lib/#{file}", "r")
        movies = movies_file.read
        movies_file.close
        format(movies)
    end

    def format(movies)
        movies = movies.split("\n")
        movies.each { |movie| movie.strip!}
        movies = movies.map {|movie| movie.split(", ")}
        movies.each { |movie| movie[0] = movie[0].to_i }
        movies.shuffle!
        movies.each do |movie|
            insert(movie.first, movie.last)
        end
        movies.length
    end
    
    def health(depth)
        
    end

end