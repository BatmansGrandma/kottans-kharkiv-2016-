class QuasiEnumerable

module Ebuberable

  def quasi_map(&block)
    result = []
    each do |el|
      result << block.call(el)
    end
    result
  end

  def quasi_select(&block)
    result_array = []
    for el in self
      result_array << block.call(el) == true
    end
    return result_array
  end

  def quasi_reject(&block)
    result_array = []
    for el in self
      result_array << block.call(el) == false
    end
    return result_array
  end

  def quasi_grep
    #enum.grep(pattern)                   => array
    #enum.grep(pattern) {| obj | block }  => array
    #Returns an array of every element in enum for which Pattern === element.
    #If the optional block is supplied, each matching element is passed to it,
    #and the block's result is stored in the output array.

  def quasi_all?(&block)
  each do |el|
    return false if el.nil? || block.call(el) == false
  end
  true
end

  #Reduce method was copypasted. Too complicated for me

  def quasi_reduce(accumulator = nil, operation = nil, &block)
  if accumulator.nil? && operation.nil? && block.nil?
    raise ArgumentError, "you must provide an operation or a block"
  end

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

  each do |element|
    unless ignore_first && index == 0
      accumulator = block.call(accumulator, element)
    end
    index += 1
  end
  accumulator
end
end
