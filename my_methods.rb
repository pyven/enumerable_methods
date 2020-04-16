module Enumerable
    def my_each
        i = 0
        loop do
            yield(self[i])
            i += 1
            break if i == self.length
        end
    end

    def my_each_with_index
        i = 0
        loop do 
            yield(self[i], i)
            i += 1
            break if i == self.length
        end
    end

    