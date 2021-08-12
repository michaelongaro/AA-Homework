  class Stack
    def initialize
        @stack = []
    end

    def push(el)
        @stack << el
    end

    def pop
        @stack.pop
    end

    def peek
        @stack[-1]
    end
end

class Queue
    def initialize
        @queue = []
    end

    def enqueue(el)
        @queue << el
    end

    def dequeue
        @queue.shift
    end

    def peek
        @queue[0]
    end
end

class Map
    def initialize
        @map = []
    end

    def set(key, value)
        @map.each_with_index do |subarr, i|
            if subarr[0] == key
                @map[ = [key, value] 
                return
            end
        end
        @map << [key, value]
    end

    def get(key)
        @map.each do |subarr|
            return subarr[1] if subarr[0] == key
        end
        puts "Key doesn't exist."
    end

    def delete(key)
        elem_to_delete = nil
        @map.each do |subarr|
            elem_to_delete = subarr if subarr[0] == key
        end

        elem_to_delete == nil ? (puts "Key doesn't exist.") : (@map.delete(elem_to_delete))
    end

    def show
        pp @map
    end
end