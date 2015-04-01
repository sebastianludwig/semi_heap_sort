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
    def self.beats?(a_i, a_j)
        return false if a_i.nil?
        return true if a_j.nil?
        return a_j[:index] >= @@tournament.column_size || @@tournament[a_i[:index], a_j[:index]] == 1
    end

    def self.max(a_i, a_j, a_k)
        return a_i if beats?(a_i, a_j) && beats?(a_i, a_k)
        return a_j if beats?(a_j, a_i) && beats?(a_j, a_k)
        return a_k if beats?(a_k, a_i) && beats?(a_k, a_j)
        return nil
    end

    def self.is_max?(a_i, a_j, a_k)     # if i beats j and k
        max(a_i, a_j, a_k) == a_i
    end

    def self.is_semi_max?(a_i, a_j, a_k)    # if i is semi max, if neither j nor k are max
        !is_max?(a_j, a_i, a_k) && !is_max?(a_k, a_i, a_j)
    end

    def self.left(index)
        2 * index + 1
    end

    def self.right(index)
        2 * index + 2
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
        if not is_semi_max?(a[i], a[left(i)], a[right(i)])
            winner = max(a[i], a[left(i)], a[right(i)])
            raise "no winner" if winner.nil?
            winner_index = winner == a[left(i)] ? left(i) : right(i)
            a[i], a[winner_index] = a[winner_index], a[i]
            semi_heapify(a, winner_index)
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
    # puts SemiHeapSort.semi_heap_sort((0..7).to_a).inspect

    elements = (0..7).map { |i| {index: i, label: "n#{i + 1}"} }
    elements.reverse!
    SemiHeapSort.semi_heap_sort(elements).each { |e| print e[:label], " " }
    puts
end

