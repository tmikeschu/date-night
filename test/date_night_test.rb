gem 'minitest', '~> 5.2'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/date_night'
require 'pry'

class BinarySearchTreeTest < Minitest::Test
    def test_tree_exists
        tree = BinarySearchTree.new
        assert tree
    end

    def test_node_exists
        node = Node.new(10, "movie")
        assert node
    end

    def test_node_has_score_and_title
        node = Node.new(100, "Boyhood")
        assert_equal 100, node.movie.values.first
        assert_equal "Boyhood", node.movie.keys.first
    end

    def test_node_starts_with_empty_branches
        node = Node.new(100, "Boyhood")
        refute node.left
        refute node.right
    end    

    def test_tree_root_starts_empty
        tree = BinarySearchTree.new
        refute tree.root
    end   

    def test_first_insert_sets_root
        tree = BinarySearchTree.new
        tree.insert(100, "Boyhood")
        assert_equal  ({"Boyhood"=>100}), tree.root.movie
    end

    def test_root_has_depth_zero
        tree = BinarySearchTree.new
        tree.insert(100, "Boyhood")
        
        assert_equal 0, tree.root.depth
    end

    def test_second_insert_has_depth_one
        tree = BinarySearchTree.new
        tree.insert(50, "Boyhood")
        tree.insert(40, "Captain Fantastic")
        
        assert_equal 1, tree.root.left.depth
    end

    def test_third_insert_has_depth_2
        tree = BinarySearchTree.new
        tree.insert(50, "Boyhood")
        tree.insert(40, "Captain Fantastic")
        tree.insert(30, "Goat")
        
        assert_equal 2, tree.root.left.left.depth
    end

    def test_third_insert_has_depth_3
        tree = BinarySearchTree.new
        tree.insert(50, "Boyhood")
        tree.insert(40, "Captain Fantastic")
        tree.insert(30, "Goat")
        tree.insert(20, "Waking Life")
        
        assert_equal 3, tree.root.left.left.left.depth
    end

    def test_second_insert_sets_a_branch
        tree = BinarySearchTree.new
        tree.insert(50, "Boyhood")
        tree.insert(40, "Captain Fantastic")
        
        assert_equal ({"Captain Fantastic" => 40}), tree.root.left.movie
    end

    def test_third_insert_sets_other_branch
        tree = BinarySearchTree.new
        tree.insert(50, "Boyhood")
        tree.insert(40, "Captain Fantastic")
        tree.insert(80, "Inception")
        
        assert_equal ({"Inception"=>80}), tree.root.right.movie
    end

    def test_insert_goes_to_level_2_when_branches_full
        tree = BinarySearchTree.new
        tree.insert(50, "Boyhood")
        tree.insert(40, "Captain Fantastic")
        tree.insert(80, "Inception")
        tree.insert(90, "Sicario")
        
        assert_equal  ({"Sicario" => 90}), tree.root.right.right.movie
    end

    def test_insert_existing_score_returns_error
        tree = BinarySearchTree.new
        tree.insert(50, "Boyhood")
        
        assert_equal "That score is already used. Please try again.", tree.insert(50, "Inception")
    end

    def test_insert_a_different_existing_score_returns_error
        tree = BinarySearchTree.new
        tree.insert(50, "Boyhood")
        tree.insert(100, "The Matrix")
        
        assert_equal "That score is already used. Please try again.", tree.insert(100, "Inception")
    end

    def test_insert_sample
        tree = BinarySearchTree.new
        
        assert_equal 0, tree.insert(61, "Bill & Ted's Excellent Adventure")
        assert_equal 1, tree.insert(16, "Johnny English")
        assert_equal 1, tree.insert(92, "Sharknado 3")
        assert_equal 2, tree.insert(50, "Hannibal Buress: Animal Furnace")
    end
    
    def test_include_method_finds_numbers_true_or_false
        tree = BinarySearchTree.new
        tree.insert(61, "Bill & Ted's Excellent Adventure")
        tree.insert(16, "Johnny English")
        tree.insert(92, "Sharknado 3")
        tree.insert(50, "Hannibal Buress: Animal Furnace")
        
        assert tree.include?(16)
        assert tree.include?(61)
        assert tree.include?(92)
        assert tree.include?(50)        
        refute tree.include?(72)
        refute tree.include?(44)
        
    end

    def test_finds_depth_of_number
        tree = BinarySearchTree.new
        tree.insert(61, "Bill & Ted's Excellent Adventure")
        tree.insert(16, "Johnny English")
        tree.insert(92, "Sharknado 3")
        tree.insert(50, "Hannibal Buress: Animal Furnace")

        assert_equal 0, tree.depth_of(61)
        assert_equal 1, tree.depth_of(92)
        assert_equal 2, tree.depth_of(50)
    end

    def test_can_find_max_score
        tree = BinarySearchTree.new
        tree.insert(61, "Bill & Ted's Excellent Adventure")
        tree.insert(16, "Johnny English")
        tree.insert(92, "Sharknado 3")
        tree.insert(50, "Hannibal Buress: Animal Furnace")

        assert_equal ({"Sharknado 3" => 92}), tree.max
    end

    def test_can_find_min_score
        tree = BinarySearchTree.new
        tree.insert(61, "Bill & Ted's Excellent Adventure")
        tree.insert(16, "Johnny English")
        tree.insert(92, "Sharknado 3")
        tree.insert(50, "Hannibal Buress: Animal Furnace")

        assert_equal ({"Johnny English" => 16}), tree.min 
    end

    def test_can_sort_nodes_by_score
        tree = BinarySearchTree.new
        tree.insert(61, "Bill & Ted's Excellent Adventure")
        tree.insert(16, "Johnny English")
        tree.insert(92, "Sharknado 3")
        tree.insert(50, "Hannibal Buress: Animal Furnace")
        
        assert_equal [{"Johnny English"=>16}, 
        {"Hannibal Buress: Animal Furnace"=>50}, 
        {"Bill & Ted's Excellent Adventure"=>61}, 
        {"Sharknado 3"=>92}], tree.sort
    end

    def test_can_load_file
        tree = BinarySearchTree.new
        
        assert_equal 99, tree.load('movies.txt')
    end

    def test_show_all_movies_at_given_depth
        tree = BinarySearchTree.new
        tree.insert(61, "Bill & Ted's Excellent Adventure")
        tree.insert(16, "Johnny English")
        tree.insert(92, "Sharknado 3")
        tree.insert(50, "Hannibal Buress: Animal Furnace")
    
        assert_equal [{"Johnny English"=>16}, {"Sharknado 3"=>92}], tree.movies_at_depth(1)
    end

    def test_count_number_of_child_nodes_including_current
        tree = BinarySearchTree.new
        tree.insert(61, "Bill & Ted's Excellent Adventure")
        tree.insert(16, "Johnny English")
        tree.insert(92, "Sharknado 3")
        tree.insert(50, "Hannibal Buress: Animal Furnace")
        
        assert_equal 2, tree.parent_node(16)
    end

    def test_health_diagnostics
        tree = BinarySearchTree.new
        tree.insert(98, "Animals United")
        tree.insert(58, "Armageddon")
        tree.insert(36, "Bill & Ted's Bogus Journey")
        tree.insert(93, "Bill & Ted's Excellent Adventure")
        tree.insert(86, "Charlie's Angels")
        tree.insert(38, "Charlie's Country")
        tree.insert(69, "Collateral Damage")
        assert_equal [[98, 7, 100]], tree.health(0)

        assert_equal [[58, 6, 85]], tree.health(1)
        assert_equal [[36, 2, 28], [93, 3, 42]], tree.health(2)
    end

    def test_total_nodes
        tree = BinarySearchTree.new
        tree.load('movies.txt')
        
        assert_equal 99, tree.total_nodes
    end

    def test_can_count_total_leaves
        tree = BinarySearchTree.new        
        tree.insert(98, "Animals United")
        tree.insert(58, "Armageddon")
        tree.insert(36, "Bill & Ted's Bogus Journey")
        tree.insert(93, "Bill & Ted's Excellent Adventure")
        tree.insert(86, "Charlie's Angels")
        tree.insert(38, "Charlie's Country")
        tree.insert(69, "Collateral Damage")
    
        assert_equal 2, tree.leaves
    end

    def test_can_calculate_height_of_tree
        tree = BinarySearchTree.new
        tree.insert(98, "Animals United")
        tree.insert(58, "Armageddon")
        tree.insert(36, "Bill & Ted's Bogus Journey")
        tree.insert(93, "Bill & Ted's Excellent Adventure")
        tree.insert(86, "Charlie's Angels")
        tree.insert(38, "Charlie's Country")
        tree.insert(69, "Collateral Damage")
        assert 5, tree.height
    end

    def test_methods_on_big_file
        tree = BinarySearchTree.new
        tree.load('movies.txt')
        assert tree.height
        assert tree.leaves
        assert tree.health(0)
    end

    def test_delete_parent
        tree = BinarySearchTree.new
        tree.insert(61, "Bill & Ted's Excellent Adventure")
        tree.insert(16, "Johnny English")
        tree.insert(92, "Sharknado 3")
        tree.insert(50, "Hannibal Buress: Animal Furnace")

        assert tree.delete(16)
    end


end