class QuasiEnumerable
  module Ebuberable

    def quasi_map(&block)
      result_array = []
      each do |el|
        result_array << block.call(el)
      end
      result_array
    end

    def quasi_select(&block)
      result_array = []
      each do |el|
        result_array << el if block.call(el)
      end
      result_array
    end

    def quasi_reject(&block)
      result_array = []
      each do |el|
        result_array << el if !block.call(el)
      end
      result_array
    end

    def quasi_grep
      # enum.grep(pattern)                   => array
      # enum.grep(pattern) {| obj | block }  => array
      # Returns an array of every element in enum for which Pattern === element.
      # If the optional block is supplied, each matching element is passed to it,
      # and the block's result is stored in the output array.
    end

    def quasi_all?(&block)
      each do |el|
        return false if !block.call(el)
      end
      true
    end

=begin
 reduce(initial, sym) → obj
 reduce(sym) → obj
 reduce(initial) { |memo, obj| block } → obj
 reduce { |memo, obj| block } → obj
 Combines all elements of enum by applying a binary operation, specified by
 a block or a symbol that names a method or operator.
 If you specify a block, then for each element in enum the block is passed
 an accumulator value (memo) and the element. If you specify a symbol instead,
 then each element in the collection will be passed to the named method of memo.
 In either case, the result becomes the new value for memo. At the end of the
 iteration, the final value of memo is the return value for the method.
 If you do not explicitly specify an initial value for memo, then the first
 element of collection is used as the initial value of memo.
=end

    def quasi_reduce(accumulator = nil, operation = nil, &block)
      if accumulator.nil? && operation.nil? && block.nil?
        raise ArgumentError, "you must provide an operation or a block"
      end

=begin
      if operation && block
        raise ArgumentError, "you must provide either an operation symbol or a block, not both"
      end

      if operation.nil? && block.nil?
        operation = accumulator
        accumulator = nil
      end

      block = case operation
        when Symbol
          lambda { |acc, value| acc.send(operation, value) }
        when nil
          block
        else
        raise ArgumentError, "the operation provided must be a symbol"
      end

      if accumulator.nil?
        ignore_first = true
        accumulator = first
      end

      index = 0

      each do |el|
        unless ignore_first && index == 0

          accumulator = block.call(accumulator, el)
        end
        index += 1
      end
      accumulator
    end
=end
  end
end
