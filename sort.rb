require 'matrix'

# class Element
#     attr_accessor :name, :index
# end
def check_tournament(t)
    t.each_with_index(:upper) do |e, row, col|
        raise "#{row}, #{col} must be 1, 0 or nil and is #{e}" unless [0, 1, nil].include? e
        if row == col
            raise "#{row}, #{col} ought to be nil" unless e.nil?
        else
            raise "mismatch in #{row}, #{col} and #{col}, #{row}" if t[col,row] == e
        end
    end
end

elements = (0..7).to_a

n = nil
T = Matrix[         # Tournament
    [n, 0, 1, 0, 1, 0, 1, 1],
    [1, n, 0, 1, 0, 1, 0, 1],
    [0, 1, n, 0, 0, 1, 0, 0],
    [1, 0, 1, n, 1, 1, 0, 1],
    [0, 1, 1, 0, n, 1, 1, 1],
    [1, 0, 0, 0, 0, n, 0, 0],
    [0, 1, 1, 1, 0, 1, n, 0],
    [0, 0, 1, 0, 0, 1, 1, n]
]
check_tournament T

# TODO: get rid of tournament parameter here and use T or objects i and j -> get rid of all tournament parameters
def beats?(tournament, i, j)
    return false if i.nil?
    return true if j.nil?
    return j >= tournament.column_size || tournament[i, j] == 1
end

def max(tournament, i, j, k)
    return i if beats?(tournament, i, j) && beats?(tournament, i, k)
    return j if beats?(tournament, j, i) && beats?(tournament, j, k)
    return k if beats?(tournament, k, i) && beats?(tournament, k, j)
    return nil
end

def is_max?(tournament, i, j, k)     # if i beats j and k
    max(tournament, i, j, k) == i
end

def is_semi_max?(tournament, i, j, k)    # if i is semi max, if neither j nor k are max
    !is_max?(tournament, j, i, k) && !is_max?(tournament, k, i, j)
end

def left(i)
    2 * i + 1
end

def right(i)
    2 * i + 2
end

def semi_heapify(a, i)
    puts "checking [#{i}, #{left(i)}, #{right(i)}]"
    if not is_semi_max?(T, i, left(i), right(i))
        puts "#{i} is not semi max"
        winner = max(T, i, left(i), right(i))
        puts "winner: #{winner} [#{i}, #{left(i)}, #{right(i)}]"
        raise "no winner" if winner.nil?
        a[i], a[winner] = a[winner], a[i]
        semi_heapify(a, winner)
    end
end

def build_semi_heap(a)
    ((a.size - 1) / 4).floor.downto(0) do |i|
        semi_heapify(a, i)
    end
end

def replace(tournament, a, i)
    if a[left(i)].nil? && a[right(i)].nil?
        a[i] = nil
    elsif beats?(tournament, a[i], a[left(i)]) && beats?(tournament, a[left(i)], a[right(i)])
        a[i] = a[left(i)]
        replace(tournament, a, left(i))
    else
        a[i] = a[right(i)]
        replace(tournament, a, right(i))
    end
end

def semi_heap_sort(tournament, elements)
    a = elements + [nil] * elements.size

    build_semi_heap(a)

    # puts a.inspect

    while a[left(0)] != nil || a[right(0)] != nil
        puts a[0]
        replace(tournament, a, 0)
    end
    puts a[0]
end

if __FILE__ == $0
    semi_heap_sort T, elements
end

