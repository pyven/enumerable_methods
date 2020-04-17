module Enumerable
    def my_each
        return self.to_enum unless block_given?

        i = 0
        loop do
            yield(self[i])
            i += 1
            break if i == self.length
        end
    end

    def my_each_with_index
        return self.to_enum unless block_given?

        i = 0
        loop do 
            yield(self[i], i)
            i += 1
            break if i == self.length
        end
    end

    def my_select
        return self.to_enum unless block_given?

        accepted = []
        self.my_each do |i|
            accepted.push(i) if yield(i)
        end
        accepted
    end

    def my_all?
        validator = true
        self.my_each { |i| validator = false if !yield(i) }
        validator
    end

    def my_any?
        validator = false
        self.my_each { |i| validator = true if yield(i) }
        validator
    end

    def my_none?
        validator = true
        self.my_each { |i| validator = false if yield(i) }
    end

    def my_count(arg = nil)
        return self.length unless block_given? && arg.nil?

        count = 0
        if block_given?
            self.my_each { |i| counter += 1 if yield[i] }
        elsif !arg.nill
            self.my_each { |i| counter += 1 if yield[i] == i}
        end
        count
    end

    def my_map
        return self.to_enum unless block_given?

        result =[]
        self.my_each { |i| result.push(yield) }
        result
    end
    
    def my_inject(result = self[0])
        self.my_each do |i|
            result = yield(result, i)
        end
        result
    end

    def multiply_els(ar)
        self.my_inject {|result,i| result * i}
    end
end


