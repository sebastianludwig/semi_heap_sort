var SemiHeapSort = {
    beats: function(a_i, a_j, comparator) {
        if (a_i == null) {
            return false;
        }
        if (a_j == null) {
            return true;
        }
        var result = comparator(a_i, a_j);
        if (result != 1 & result != -1) {
            throw "invalid comparison result " + result + " - must be -1 or 1";
        }
        return result == -1;
    },

    max: function(a_i, a_j, a_k, comparator) {
        if (this.beats(a_i, a_j, comparator) && this.beats(a_i, a_k, comparator)) {
            return a_i;
        }
        if (this.beats(a_j, a_i, comparator) && this.beats(a_j, a_k, comparator)) {
            return a_j;
        }
        if (this.beats(a_k, a_i, comparator) && this.beats(a_k, a_j, comparator)) {
            return a_k;
        }
        return null;
    },

    is_max: function(a_i, a_j, a_k, comparator) {
        return this.max(a_i, a_j, a_k, comparator) == a_i;
    },

    is_semi_max: function(a_i, a_j, a_k, comparator) {
        return !this.is_max(a_j, a_i, a_k, comparator) && !this.is_max(a_k, a_i, a_j, comparator);
    },

    left: function(index) {
        return 2 * index + 1;
    },

    right: function(index) {
        return 2 * index + 2;
    },

    replace: function(a, i, comparator) {
        if (a[this.left(i)] == null && a[this.right(i)] == null) {
            a[i] = null;
        } else if (this.beats(a[i], a[this.left(i)], comparator) && this.beats(a[this.left(i)], a[this.right(i)], comparator)) {
            a[i] = a[this.left(i)];
            this.replace(a, this.left(i), comparator);
        } else {
            a[i] = a[this.right(i)];
            this.replace(a, this.right(i), comparator);
        }
    },

    semi_heapify: function(a, i, comparator) {
        if (!this.is_semi_max(a[i], a[this.left(i)], a[this.right(i)], comparator)) {
            var winner = this.max(a[i], a[this.left(i)], a[this.right(i)], comparator);
            if (winner == null) {
                throw "no winner";
            }
            var winner_index = winner == a[this.left(i)] ? this.left(i) : this.right(i);
            var temp = a[i];
            a[i] = a[winner_index];
            a[winner_index] = temp;
            this.semi_heapify(a, winner_index, comparator);
        }
    },

    build_semi_heap: function(a, comparator) {
        var result = a.slice();
        result = result.concat(new Array(a.length).fill(null));
        for (var i = Math.floor((result.length - 1) / 4); i >= 0; i--) { 
            this.semi_heapify(result, i, comparator);
        }

        return result;
    },

    sort: function(elements, comparator) {
        var a = this.build_semi_heap(elements, comparator);

        var result = [];
        while (a[this.left(0)] != null || a[this.right(0)] != null) {
            result.push(a[0]);
            this.replace(a, 0, comparator);
        }
        result.push(a[0]);
        return result;
    }
}
