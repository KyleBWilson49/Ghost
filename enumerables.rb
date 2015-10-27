class Array
  def my_each(&blk)
    length = self.length

    0.upto(length - 1) do |n|
      blk.call(self[n])
    end
    self
  end

  def my_select(&blk)
    new_array = []

    self.my_each do |el|
      if blk.call(el)
        new_array << el
      end
    end
    new_array
  end

  def my_reject(&blk)
    new_array = []

    self.my_each { |el| new_array << el unless blk.call(el) }

    new_array
  end

  def my_any?(&blk)
    status = false

    self.my_each { |el| status = true if blk.call(el) }

    status
  end

  def my_all?(&blk)
    status = true

    self.my_each { |el| status = false unless blk.call(el) }

    status
  end

  def my_flatten
    flattened = self.join.split("")
    new_array = []
    flattened.my_each { |el| new_array << el.to_i }
    new_array
  end

  def my_flatten_rec
    new_array = []

    self.my_each do |el|
      unless el.is_a?(Array)
        new_array << el
      else
        new_array += el.my_flatten_rec
      end
    end
    new_array
  end


  def my_zip(*args)
    new_array = []
    idx = 0
    while idx < self.length
      temp_array = []
      temp_array << self[idx]
      args.my_each do |arg|
        temp_array << arg[idx]
      end
      new_array << temp_array
      idx += 1
    end
    new_array
  end

  def my_rotate(n = 1)
    if n > 0
      n.times do
        self << self.shift
      end
    elsif n < 0
      n *= (-1)
      n.times do
        self.unshift(self.pop)
      end
    end
    self
  end

  def my_join(separator = "")
    str = ""
    self.my_each do |char|
      str << char.to_s
      str << separator.to_s
    end
    str
  end

  def my_reverse
    reversed_array = []
    self.my_each {|el| reversed_array.unshift(el)}
    reversed_array
  end

end

# a = [1, 2, 3, 4]
# a.my_each { |num| puts num + 1 }

# p a.my_select { |num| num > 2 }
# p a.my_reject { |num| num > 2 }
# p a.my_any? { |num| num == 5 }
# p a.my_all? { |num| num < 4 }

# = [1, 2, 3, [4, [5, 6]], [[[7]], 8]].my_flatten
# p b

# a = [ 4, 5, 6 ]
# b = [ 7, 8, 9 ]
# p [1, 2, 3].my_zip(a, b)
# p a.my_zip([1,2], [8])

# a = [ "a", "b", "c", "d" ]
# p a.my_rotate
# a = [ "a", "b", "c", "d" ]
# p a.my_rotate(2)
# a = [ "a", "b", "c", "d" ]
# p a.my_rotate(-3)
# a = [ "a", "b", "c", "d" ]
# p a.my_rotate(15)

a = [ "a", "b", "c", "d" ]
p a.my_join         # => "abcd"
p a.my_join("$")    # => "a$b$c$d"

p [ "a", "b", "c" ].my_reverse   #=> ["c", "b", "a"]
p [ 1 ].my_reverse               #=> [1]
