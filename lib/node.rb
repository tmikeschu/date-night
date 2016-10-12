require 'pry'

class Node
    attr_reader   :movie
    attr_accessor :left,
                  :right,
                  :depth

    def initialize(score, title)
        @movie = {title => score}
        @left  = nil
        @right = nil
        @depth = 0
    end

    def insert(score, title)
        if movie.values.first > score
            insert_left(score, title)
        elsif movie.values.first < score
            insert_right(score, title)
        else
            "That score is already used. Please try again."
        end
    end

    def insert_left(score, title)
        if left.nil?
            @left = Node.new(score, title)
            @left.depth = depth + 1
        else 
            left.insert(score, title)
        end
    end  

    def insert_right(score, title)
        if right.nil?
            @right = Node.new(score, title)
            @right.depth = depth + 1
        else 
            right.insert(score, title)
        end
    end
             
end

