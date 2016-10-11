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

    def include?(score)
        if movie.values.first == score
            true
        elsif left?(score)
            left.include?(score)
        elsif right?(score)
            right.include?(score)
        else
            false            
        end
    end

    def depth_of(score)
        if movie.values.first == score
            depth
        elsif left?(score)
            left.depth_of(score)
        elsif right?(score)
            right.depth_of(score)
        else
            "#{score} does not exist in tree"
        end
    end

    def left?(score, title = nil)
        movie.values.first > score && left != nil
    end

    def right?(score, title = nil)
        movie.values.first < score && right != nil
    end

    def max
        return movie if right.nil?
        right.max
    end

    def min
       return movie if left.nil?
        left.min
    end 

    def sort
        return movie if @left = nil
        
        #node
        #node.right
    end

end

