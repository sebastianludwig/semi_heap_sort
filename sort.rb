require 'matrix'

# class Element
#     attr_accessor :name, :index
# end

class SemiHeapSort
    @@tournament = nil
    def self.tournament
        @@tournament
    end
    def self.tournament=(t)
        self.check_tournament t
        @@tournament = t
    end

    def self.check_tournament(t)
        t.each_with_index(:upper) do |e, row, col|
            raise "#{row}, #{col} must be 1, 0 or nil and is #{e}" unless [0, 1, nil].include? e
            if row == col
                raise "#{row}, #{col} ought to be nil" unless e.nil?
            else
                raise "mismatch in #{row}, #{col} and #{col}, #{row}" if t[col,row] == e
            end
        end
    end

    # TODO: get rid of tournament parameter here and use T or objects i and j -> get rid of all tournament parameters
    def self.beats?(i, j)
        return false if i.nil?
        return true if j.nil?
        return j >= @@tournament.column_size || @@tournament[i, j] == 1
    end

    def self.max(i, j, k)
        return i if beats?(i, j) && beats?(i, k)
        return j if beats?(j, i) && beats?(j, k)
        return k if beats?(k, i) && beats?(k, j)
        return nil
    end

    def self.is_max?(i, j, k)     # if i beats j and k
        max(i, j, k) == i
    end

    def self.is_semi_max?(i, j, k)    # if i is semi max, if neither j nor k are max
        !is_max?(j, i, k) && !is_max?(k, i, j)
    end

    def self.left(i)
        2 * i + 1
    end

    def self.right(i)
        2 * i + 2
    end

    def self.replace(a, i)
        if a[left(i)].nil? && a[right(i)].nil?
            a[i] = nil
        elsif beats?(a[i], a[left(i)]) && beats?(a[left(i)], a[right(i)])
            a[i] = a[left(i)]
            replace(a, left(i))
        else
            a[i] = a[right(i)]
            replace(a, right(i))
        end
    end

    def self.semi_heapify(a, i)
        if not is_semi_max?(i, left(i), right(i))
            winner = max(i, left(i), right(i))
            raise "no winner" if winner.nil?
            a[i], a[winner] = a[winner], a[i]
            semi_heapify(a, winner)
        end
    end

    def self.build_semi_heap(a)
        ((a.size - 1) / 4).floor.downto(0) do |i|
            semi_heapify(a, i)
        end
    end

    def self.semi_heap_sort(elements)
        a = elements + [nil] * elements.size

        build_semi_heap(a)

        result = []
        while a[left(0)] != nil || a[right(0)] != nil
            result << a[0]
            replace(a, 0)
        end
        result << a[0]
    end
end


if __FILE__ == $0
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
    SemiHeapSort.check_tournament T
    SemiHeapSort.tournament = T
    puts SemiHeapSort.semi_heap_sort((0..7).to_a).inspect
end

