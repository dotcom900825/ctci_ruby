
require 'pry'
require 'pry-debugger'
require 'pry-stack_explorer'
require 'treenode'

module Ch4

  # Given a sorted (increasingorder) array with unique integer elements,
  # write an algorithm to createa binary search tree with minimal height.
  def self.create_min_bst(arr, low = 0, high = arr.size - 1)
    raise ArgumentError unless arr
    return nil if low > high
    mid = (low + high) / 2
    node = TreeNode.new(arr[mid])
    node.left = create_min_bst(arr, low, mid - 1)
    node.right = create_min_bst(arr, mid + 1, high)
    node
  end

  # Given a binary tree, design an algorithm which creates a
  # linked list of all the nodes at each depth
  # (e.g., if you have a tree with depth D,you'll have D linked lists).
  def self.create_level_lists(root, ary = [], level = 0)
    return unless root
    # Levels are always traversed in order.
    if ary.size == level
      list = LinkedList.new
      ary << list
    else
      list = ary[level]
    end

    list << root
    create_level_lists(root.left, ary, level + 1)
    create_level_lists(root.right, ary, level + 1)
    ary
  end

  class BinaryTree

    attr_accessor :root

    def initialize
      @root = nil
    end

    def empty?
      size == 0
    end

    def size
      size_of_node(@root)
    end

    def size_of_node(node)
      node.nil? ? 0 : node.num_subtree
    end

    def include?(key)
      get(key) != nil
    end

    def get(key, node = @root)
      return nil if node.nil?
      if key < node.key
        get(key, node.left)
      elsif key > node.key
        get(key, node.right)
      else
        node.value
      end
    end

    def put(key, value)
      @root = put_to_node(@root, key, value)
      self
    end

    def put_to_node(node, key, value)
      return TreeNode.new(key, value, 1) if node.nil?
      if key < node.key
        node.left = put_to_node(node.left, key, value)
      elsif key > node.key
        node.right = put_to_node(node.right, key, value)
      else
        node.value = value
      end
      node.num_subtree = size_of_node(node.left) + size_of_node(node.right) + 1
      node
    end

    def pre_order(node = @root)
      result = []
      return result unless node
      result << node.value
      result << pre_order(node.left)
      result << pre_order(node.right)
      result.flatten!
    end

    def in_order(node = @root)
      result = []
      return result unless node
      result << in_order(node.left)
      result << node.value
      result << in_order(node.right)
      result.flatten!
    end

    def post_order(node = @root)
      result = []
      return result if node.nil?
      result << post_order(node.left)
      result << post_order(node.right)
      result << node.value
      result.flatten!
    end

    def balanced?(node = @root)
      return true if node.nil?
      return false if node.left.nil? && !node.right.nil?
      return false if node.right.nil? && !node.left.nil?
      (node.left.num_subtree - node.right.num_subtree).abs <= 1
    end

    # You have two very large binary trees: T1, with millions of nodes,
    # and T2, with hundreds of nodes. Create a algorithm to decide if T2 is a subtree of T1
    def include_tree?(node2)
      return true if node2.nil?
      sub_tree?(@root, node2)
    end

    private

    def sub_tree?(node1, node2)
      return false if node1.nil?
      if node1.key == node2.key
        return true if match_tree?(node1, node2)
      end
      sub_tree?(node1.left, node2) || sub_tree?(node1.right, node2)
    end

    def match_tree?(node1, node2)
      return true if node1.nil? and node2.nil?
      return false if node1.nil? or node2.nil?
      return false if node1.key != node2.key
      match_tree?(node1.left, node2.left) && match_tree?(node1.right, node2.right)
    end
  end

end
