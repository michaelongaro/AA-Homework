class PolyTreeNode

    attr_reader :value, :parent, :children

    attr_writer :children

    def initialize(value)
        @value = value
        @parent = nil
        @children = []


    end

    def parent=(val)
        if @parent != val
            if @parent == nil
                @parent = val
                val.children << self if val != nil
            else
                @parent.children.pop
                @parent = val
                val.children << self if val != nil
            end
        end

    end


    def add_child(child_node)
        child_node.parent=(self) 
    end

    def remove_child(child_node)
        raise "Node is not a child." if child_node.parent == nil
        child_node.parent=(nil) 
    end

    def dfs(target_value)
        return self if self.value == target_value

        @children.each do |child|
            search_result = child.dfs(target_value)
            return search_result if search_result != nil
        end
        nil
    end

    def bfs(target_value)
        queue = [self]

        while !queue.empty?
            parent_node = queue.shift
            return parent_node if parent_node.value == target_value
            parent_node.children.each do |child|
                queue << child
            end


        end

    end

end

