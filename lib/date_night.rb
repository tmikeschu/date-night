require './lib/node'
require 'pry'

class BinarySearchTree 
    attr_accessor :root
    
    def initialize
        @root  = nil
    end

    def insert(score, title)
        if root.nil?
            @root = Node.new(score, title)
            root.depth
        else 
            root.insert(score, title)
        end
    end

    def include?(node = @root, score)
        if node.movie.values.first == score
            true
        elsif left?(node, score)
            include?(node.left, score)
        elsif right?(node, score)
            include?(node.right, score)
        else
            false            
        end
    end

    def depth_of(node = @root, score)
        if node.movie.values.first == score
            node.depth
        elsif left?(node, score)
            depth_of(node.left, score)
        elsif right?(node, score)
            depth_of(node.right, score)
        else
            "#{score} does not exist in tree"
        end
    end

    def left?(node, score)
        node.movie.values.first > score && node.left != nil
    end

    def right?(node, score)
        node.movie.values.first < score && node.right != nil
    end

    def max(node = @root)
        return node.movie if node.right.nil?
        max(node.right)
    end

    def min(node = @root)
       return node.movie if node.left.nil?
        min(node.left)
    end 

    def sort(node = @root)
        sorted_movies = []
        sorted_movies << node.movie if node.left.nil?

        sorted_movies << sort(node.left) if node.left != nil 

        sorted_movies << node.movie unless sorted_movies.include?(node.movie)

        sorted_movies << sort(node.right) if node.right != nil
        
        sorted_movies.flatten
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
    
    def movies_at_depth(node = @root, depth)
        movies = []

        movies << node.movie if node.depth == depth
        
        movies << movies_at_depth(node.left, depth) if node.left != nil
        movies << movies_at_depth(node.right, depth) if node.right != nil
        
        movies.flatten
    end

    def nodes_at_depth(node = @root, depth)
        nodes = []

        nodes << node if node.depth == depth
        
        nodes << nodes_at_depth(node.left, depth) if node.left != nil
        nodes << nodes_at_depth(node.right, depth) if node.right != nil
        
        nodes.flatten
    end
    
    def children(node = @root)
        child_count = 0
        child_count += 1

        child_count += children(node.left) if node.left != nil
        child_count += children(node.right) if node.right != nil

        child_count
    end

    def health(node = @root, depth)
        health_array = []

        node_scores = movies_at_depth(node, depth)
        node_scores = node_scores.map {|movie| movie.values.first}

        children_counts = nodes_at_depth(node, depth)
        
        
        # health_array will zip three arrays (node_scores, children_counts, %'s)
    end

end