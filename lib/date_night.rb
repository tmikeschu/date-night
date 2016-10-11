require './lib/node'
require 'pry'
class BinarySearchTree
    
    attr_accessor :root
    
    def initialize
        @root  = nil
    end

    def insert(score, title)
        if @root.nil?
            @root = Node.new(score, title)
            @root.depth
        else 
            @root.insert(score, title)
        end
    end

    def include?(score)
        if @root.movie.values.first == score
            true
        else
            @root.include?(score)
        end
    end

    def depth_of(score)
        @root.depth_of(score)
    end
    
    def max
        @root.max
    end

    def min
        @root.min
    end
end


