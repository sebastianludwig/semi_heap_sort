describe("SemiHeapSort", function() {
    var tournament = [[]];
    var comp = function(a, b) { 
        return tournament[a - 1][b - 1] == 1 ? -1 : 1
    };

    describe("Figure 2 (a)", function() {

        beforeEach(function() {
            var n = null;
            tournament = [
                [n, 1, 1],
                [0, n, 1],
                [0, 0, n]
            ];
        });

        describe("max", function() {
            it("finds 1 as max", function() {
                expect(SemiHeapSort.max(1, 2, 3, comp)).toEqual(1);
            });

            it("finds 1 as max regardless of the argument order", function() {
                expect(SemiHeapSort.max(1, 3, 2, comp)).toEqual(1);
                expect(SemiHeapSort.max(2, 1, 3, comp)).toEqual(1);
                expect(SemiHeapSort.max(3, 1, 2, comp)).toEqual(1);
                expect(SemiHeapSort.max(2, 3, 1, comp)).toEqual(1);
                expect(SemiHeapSort.max(3, 2, 1, comp)).toEqual(1);
            });

            it("reports 1 as max", function() {
                expect(SemiHeapSort.is_max(1, 2, 3, comp)).toBe(true);
            });
            it("reports 2 as NOT max", function() {
                expect(SemiHeapSort.is_max(2, 1, 3, comp)).toBe(false);
            });
            it("reports 3 as NOT max", function() {
                expect(SemiHeapSort.is_max(3, 1, 2, comp)).toBe(false);
            });
        });

        describe("is_semi_max", function() {
            it("reports 1 as semi max", function() { 
                expect(SemiHeapSort.is_semi_max(1, 2, 3, comp)).toBe(true);
            });
            it("reports 2 as NOT semi max", function() { 
                expect(SemiHeapSort.is_semi_max(2, 1, 3, comp)).toBe(false);
            });
            it("reports 3 as NOT semi max", function() { 
                expect(SemiHeapSort.is_semi_max(3, 1, 2, comp)).toBe(false);
            });
        });

        describe("semi_heap_sort", function() {
            it("sorts items correctly", function() {
                expect(SemiHeapSort.sort([1, 2, 3], comp)).toEqual([1, 2, 3]);
            });
        });
    });


    describe("Figure 2 (d)", function() {

        beforeEach(function() {
            var n = null
            tournament = [
                [n, 0, 1],
                [1, n, 0],
                [0, 1, n]
            ];
        });

        describe("beats", function() {
            it("works", function() {
                expect(SemiHeapSort.beats(1, 3, comp)).toBe(true);
                expect(SemiHeapSort.beats(2, 1, comp)).toBe(true);
                expect(SemiHeapSort.beats(3, 2, comp)).toBe(true);
            });
        });
    });

});
