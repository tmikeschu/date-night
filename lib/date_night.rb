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


    def move_left?(movie, score)
        movie.score > score && movie.left != nil
    end

    def move_right?(movie, score)
        movie.score < score && movie.right != nil
    end
 
    def include?(movie = @root, score)
        if movie.score == score
            true
        elsif move_left?(movie, score)
            include?(movie.left, score)
        elsif move_right?(movie, score)
            include?(movie.right, score)
        else
            false            
        end
    end

    def find_movie_at_score(movie = @root, score)
        if movie.score == score
            movie
        elsif move_left?(movie, score)
            find_movie_at_score(movie.left, score)
        elsif move_right?(movie, score)
            find_movie_at_score(movie.right, score)
        else
            "#{score} does not exist in tree"
        end
    end

    def depth_of(movie = @root, score)
        found_movie = find_movie_at_score(movie, score)
        
        if found_movie.is_a? String
            found_movie 
        else 
            found_movie.depth
        end
    end


    def max(movie = @root)
        return movie.title_and_score if movie.right.nil?
        max(movie.right)
    end

    def min(movie = @root)
       return movie.title_and_score if movie.left.nil?
        min(movie.left)
    end 

    def sort(movie = @root)
        sorted_movies = []
        sorted_movies << movie.title_and_score if movie.left.nil?

        sorted_movies << sort(movie.left) if movie.left != nil 
        sorted_movies << movie.title_and_score unless sorted_movies.include?(movie.title_and_score)
        sorted_movies << sort(movie.right) if movie.right != nil
        sorted_movies.flatten
    end
    
    def load(file)
        movies_file = File.open("./lib/#{file}", "r")
        movies      = movies_file.read
        movies_file.close
        format(movies)
    end

    def format(movies)
        movies = movies.split("\n")
        movies = movies.map do |movie| 
            movie.strip!
            movie.split(", ")
        end
        movies.each { |movie| movie[0] = movie[0].to_i }
        shuffle_movie_list_until_healthy(movies)
        movies.each do |movie|
            insert(movie.first, movie.last)
        end
        movies.length
    end

    def shuffle_movie_list_until_healthy(movies)
        five_less_than_median = (movies.length/2) - 5
        five_more_than_median = (movies.length/2) + 5
        until movies.first[0] > movies.sort[five_less_than_median].first && movies.first[0] < movies.sort[five_more_than_median].first
            movies.shuffle!
        end
    end
    
    def movies_at_depth(movie = @root, depth)
        movies = []
        movies << movie.title_and_score if movie.depth == depth
        movies << movies_at_depth(movie.left, depth) if movie.left != nil
        movies << movies_at_depth(movie.right, depth) if movie.right != nil
        movies.flatten
    end
    
    def movie_scores(movie = @root, depth)
        movie_scores = movies_at_depth(movie, depth)
        movie_scores = movie_scores.map {|movie| movie.values.first}
    end
    
    def parent_movie(movie = @root, score)
        movie = find_movie_at_score(movie, score)
        children(movie)
    end

    def children(movie = @root)
        child_count  = 0
        child_count += 1
        child_count += children(movie.left) if movie.left != nil
        child_count += children(movie.right) if movie.right != nil
        child_count
    end

    def child_count_array(movie = @root, depth)
        children_counts = movie_scores(movie, depth).map {|score| parent_movie(score)}
    end

    def node_proportions(movie = @root, depth)
        child_count_array(movie, depth).map {|count| ((count.to_f / total_movies.to_f)*100).floor}
    end

    def total_movies
        parent_movie(root.score)
    end
    
    def health(movie = @root, depth)
        health_array = []
        movies        = movie_scores(movie, depth)
        children     = child_count_array(movie, depth)        
        proportions  = node_proportions(movie, depth)
        health_array = movies.zip(children, proportions) 
    end

    def leaves(movie = @root)
        leaf_count  = 0
        leaf_count += 1 if movie.left.nil? && movie.right.nil?
        leaf_count += leaves(movie.left) if movie.left != nil
        leaf_count += leaves(movie.right) if movie.right != nil
        leaf_count
    end

    def height(movie = @root)
        return 0 if movie.nil?
        max_height = 0
        left  = movie.left
        right = movie.right
        return max_height = movie.depth + 1 if left.nil? && right.nil?
        
        height_left  = height(left)
        height_right = height(right)
        max_height   = compare(height_left, height_right)
    end

    def compare(left, right)
        case left <=> right
            when 1, 0 then left
            when -1 then right
        end
    end

    def prepare_parent_for_death(movie = @root, score)
        movie = find_movie_at_score(movie, score)
        save_the_children(movie)
    end

    def save_the_children(movie = @root)
        left  = movie.left
        right = movie.right

        child_array  = []

        if left != nil
            child_array << [left.score, left.title]
            child_array << save_the_children(movie.left) 
        
        elsif movie.right != nil
            child_array << [right.score, right.title]
            child_array << save_the_children(movie.right)
        end 
        child_array.reject! {|child| child.empty?}
        child_array
    end

    def find_parent_at_score(movie = @root, score)
        if movie.left.score == score || movie.right.score == score
            movie
        elsif move_left?(movie, score)
            find_parent_at_score(movie.left, score)
        elsif move_right?(movie, score)
            find_parent_at_score(movie.right, score)
        else
            "#{score} does not exist in tree"
        end
    end

    

end