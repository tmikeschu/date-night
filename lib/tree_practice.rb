require 'pry'

class BinarySearchTree
    include Enumerable
    attr_reader :array,
                :node                

    def initialize(array)
        @node  = Node.new(array.first)
        @array2 = array.drop(1)

        @array2.each {|n| @node.insert(n)}
    end

    def include?(n)
        @node.include?(n)
    end
    
    def count?(number)
        @node.count?(number)
    end

    class Node
        attr_reader   :parent
        
        attr_accessor :left,
                      :right,
                      :count,
                      :included

        def initialize(parent)
            @parent    = parent
            @left      = nil
            @right     = nil
            @count     = 1
            @steps     = 0
            @included  = false
            
        end

        def insert(number)
            case @parent <=> number
            when 1
                if @left.nil?
                    @left = Node.new(number)
                else
                    @left.insert(number)
                end
            when 0
                @count += 1 
            when -1
                if @right.nil?
                    @right = Node.new(number)
                else
                    @right.insert(number)
                end
            else
                "error"
            end
        end

        def include?(number)
            #binding.pry

            case @parent <=> number
            when 1
                if @left.nil?
                    false
                elsif @left.parent == number
                    true
                else @left.parent
                    @left.include?(number)
                end
            when 0
                @included = true
            when -1
                if @right.nil?
                    false
                elsif @right.parent == number
                    true
                else @right.parent
                    @right.include?(number)
                end
            else
                "error"
            end
        end

        def steps?(number)
            include?(number)
            @steps
        end

        def reset_steps
            @steps = 0
        end

        def count?(number)
            case @parent <=> number
            when 1
                if @left.nil?
                    0
                elsif @left.parent == number
                    @left.count?(number)
                else @left.parent
                    @left.count
                end
            when 0
                @count
            when -1
                if @right.nil?
                    0
                elsif @right.parent == number
                    @right.count?(number)
                else @right.parent
                    @right.count
                end
            else
                "error"
            end
        end


    end

end

array = [9, 18, 4, 1, 6, 5, 14, 3, 16, 11, 13, 2, 15, 7, 17, 10, 12, 8, 19, 20]
array2 = array.drop(1)

tree = BinaryTree::Node.new(array.first)
array2.each {|n| tree.insert(n)}

puts tree.include?(40000)
puts tree.include?(13)

(1..21).to_a.each {|n| puts tree.include?(n)}

