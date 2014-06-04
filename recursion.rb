def range(start_num, end_num)
  return [] if end_num < start_num
  if start_num == end_num
    return [end_num]
  end
  [start_num] + range(start_num+ 1, end_num)
end

def sum(arr)
  return 0 if arr.empty?
  arr.first + sum(arr[1..-1])
end

def sum_iter(arr)
  sum = 0
  arr.each { |el| sum += el }
  sum
end

def exp1(b, n)
  return 1 if n == 0
  b * exp1(b, n - 1)
end

def exp2(b, n)
  if n == 0
    1
  elsif n.even?
    exp2(b, n / 2) * exp2(b, n / 2)
  else
    b * (exp2(b, n / 2) * exp2(b, n / 2))
  end
end

class Array
  def deep_dup
    new_array = []
    each do |el|
      if el.is_a?(Array)
        new_array << el.deep_dup
      else
        new_array << el
      end
    end
    new_array
  end
end

def fib_recur(n)
  if n == 1
    [0]
  elsif n == 2
    [0, 1]
  else
    fibs = fib_recur(n - 1)
    fibs + [fibs[-1] + fibs[-2]]
  end
end

def fib_iter(n)
  fibs = [0, 1]
  if n <= 2
    fibs.take(n)
  else
    3.upto(n) { fibs << fibs[-1] + fibs[-2] }
    fibs
  end
end


def bsearch(array, target)
  if array.empty?
    return nil
  end

  mid_point = array.count / 2
  mid = array[mid_point]

  if target < mid
    bsearch(array[0...mid_point], target)
  elsif mid == target
    mid_point
  else
    idx = bsearch(array[(mid_point+ 1)..-1], target)
    return nil unless idx
    mid_point + 1 + bsearch(array[(mid_point+ 1)..-1], target)
  end
end

def make_change(amt, coins = [10, 7, 1])
  if coins.empty?
    return []
  end
  combos = []
  coins.each_with_index do |coin, index|
    combos << make_change_helper(amt, coins[index..-1])
  end
  combos.min_by { |combo| combo.count}
end

def make_change_helper(amt, coins)
  current_amt = amt

  new_amt = current_amt - coins[0]
  if new_amt == 0
    [coins[0]]
  elsif new_amt < 0
    make_change_helper(current_amt, coins[1..-1])
  else
    [coins[0]] + make_change_helper(new_amt, coins)
  end
end


def merge_sort(array)
  if array.count == 1
    return array
  end
  mid = array.count / 2
  left_half = merge_sort(array[0..mid-1])
  right_half = merge_sort(array[mid..-1])

  merge(left_half, right_half)

end

def merge(arr1, arr2)
  sorted_array = []
  until arr1.empty? || arr2.empty? do
    if arr1[0] < arr2[0]
      sorted_array << arr1.shift
    else
      sorted_array << arr2.shift
    end

  end
  sorted_array + arr1 + arr2
end

def subsets(nums)
  if nums.empty?
    return [nums]
  end

  lower_subsets = subsets(nums[0...-1])
  upper_subsets = lower_subsets.map {|set| set += [nums.last]}

  lower_subsets + upper_subsets
end
