module Enumerable
    def my_each
        return self.to_enum unless block_given?

        convert = self.is_a?(Range) ? to_a : self

        i = 0
        loop do
            yield(convert[i])
            i += 1
            break if i == convert.length
        end
        convert
    end

    def my_each_with_index
        return self.to_enum unless block_given?

        convert = self.is_a?(Range) ? to_a : self

        i = 0
        loop do 
            yield(convert[i], i)
            i += 1
            break if i == convert.length
        end
        convert
    end

    def my_select
        return self.to_enum unless block_given?

        accepted = []
        self.my_each do |i|
            accepted.push(i) if yield(i)
        end
        accepted
    end

    def my_all?(arg = nil)
        validator = true
        if arg.nil? && !block_given?
            self.my_each { |i| validator = false if i.nil? || !i }
        elsif block_given?
            self.my_each { |i| validator = false if !yield(i) }
        else
            self.my_each { |i| validator = false unless arg === i }
        end
        validator
    end

    def my_any?(arg = nil)
        validator = false
        if arg.nil? && !block_given?
            self.my_each { |i| validator = true if !i.nil? || i}
        elsif block_given?
            self.my_each { |i| validator = true if yield(i) }
        else
            self.my_each { |i| validator = true if arg === i }
        end
        validator
    end

    def my_none?(arg = nil)
        validator = true
        if arg.nil? && !block_given?
            self.my_each { |i| validator = false if i }
        elsif block_given?
            self.my_each { |i| validator = false if yield(i) }
        else
            self.my_each { |i| validator = false if arg === i }
        end
        validator
    end

    def my_count(arg = nil)
        count = 0
        if arg.nil? && !block_given?
            count = size.length
        elsif block_given?
            self.my_each { |i| count += 1 if yield(i) }
        else
            self.my_each { |i| count += 1 if arg == i }
        end
        count
    end

    def my_map(proc = nil)
        return self.to_enum unless block_given?

        result =[]
        self.my_each do |i|
            proc.nil? ? result.push(proc.call(i)) : result.push(yield(i))
        result
        end
    end
    
    def my_inject(arg = self[0])
        initial = arg.is_a?(Symbol) ? self[0] : arg

        convert = self.is_a?(Range) ? to_a : self

        if block_given?
            convert.my_each { |i| initial = yield(initial, i) }
        elsif arg.to_s == "+"
            initial = 0
            convert.my_each { |i| initial = initial + i }
        elsif arg.to_s == "-"
            convert.my_each { |i| initial = initial == i ? i : initial - i }
        elsif arg.to_s == "*"
            initial = 1
            convert.my_each { |i| initial = initial * i }
        elsif arg.to_s == "/"
            convert.my_each { |i| initial = initial == i ? i : initial / i }
        end
        initial
    end
end

def multiply_els(ar)
    ar.my_inject {|result,i| result * i}
end

