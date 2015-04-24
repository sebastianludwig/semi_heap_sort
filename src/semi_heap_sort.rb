class SemiHeapSort
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

    def self.beats?(a_i, a_j, &comparator)
        return false if a_i.nil?
        return true if a_j.nil?
        result = comparator.call(a_i, a_j)
        raise "invalid comparison result #{result} - must be -1 or 1" if result != 1 and result != -1
        return result == -1
    end

    def self.max(a_i, a_j, a_k, &comparator)
        return a_i if beats?(a_i, a_j, &comparator) && beats?(a_i, a_k, &comparator)
        return a_j if beats?(a_j, a_i, &comparator) && beats?(a_j, a_k, &comparator)
        return a_k if beats?(a_k, a_i, &comparator) && beats?(a_k, a_j, &comparator)
        return nil
    end

    def self.is_max?(a_i, a_j, a_k, &comparator)     # if i beats j and k
        max(a_i, a_j, a_k, &comparator) == a_i
    end

    def self.is_semi_max?(a_i, a_j, a_k, &comparator)    # if i is semi max, if neither j nor k are max
        !is_max?(a_j, a_i, a_k, &comparator) && !is_max?(a_k, a_i, a_j, &comparator)
    end

    def self.left(index)
        2 * index + 1
    end

    def self.right(index)
        2 * index + 2
    end

    def self.replace(a, i, &comparator)
        if a[left(i)].nil? && a[right(i)].nil?
            a[i] = nil
        elsif beats?(a[i], a[left(i)], &comparator) && beats?(a[left(i)], a[right(i)], &comparator)
            a[i] = a[left(i)]
            replace(a, left(i), &comparator)
        else
            a[i] = a[right(i)]
            replace(a, right(i), &comparator)
        end
    end

    def self.semi_heapify(a, i, &comparator)
        if not is_semi_max?(a[i], a[left(i)], a[right(i)], &comparator)
            winner = max(a[i], a[left(i)], a[right(i)], &comparator)
            raise "no winner" if winner.nil?
            winner_index = winner == a[left(i)] ? left(i) : right(i)
            a[i], a[winner_index] = a[winner_index], a[i]
            semi_heapify(a, winner_index, &comparator)
        end
    end

    def self.build_semi_heap(a, &comparator)
        a = a + [nil] * a.size
        
        ((a.size - 1) / 4).floor.downto(0) do |i|
            semi_heapify(a, i, &comparator)
        end
        a
    end

    def self.sort(elements, &comparator)
        raise "no comparison block given" unless block_given?

        a = build_semi_heap(elements, &comparator)

        result = []
        while a[left(0)] != nil || a[right(0)] != nil
            result << a[0]
            replace(a, 0, &comparator)
        end
        result << a[0]
    end
end
