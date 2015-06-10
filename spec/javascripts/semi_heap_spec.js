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
        });

        describe("is_max", function() {
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

    describe("Figure 2 (b)", function() {

        beforeEach(function() {
            var n = null;
            tournament = [
                [n, 1, 1],
                [0, n, 0],
                [0, 1, n]
            ];
        });

        describe("max", function() {
            it("finds 1 as max", function() {
                expect(SemiHeapSort.max(1, 2, 3, comp)).toEqual(1);
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
                expect(SemiHeapSort.sort([1, 2, 3], comp)).toEqual([1, 3, 2]);
            });
        });
    });

    describe("Figure 2 (c)", function() {
        beforeEach(function() {
            var n = null;
            tournament = [
                [n, 1, 0],
                [0, n, 1],
                [1, 0, n]
            ];
        });

        describe("max", function() {
            it("finds no max", function() {
                expect(SemiHeapSort.max(1, 2, 3, comp)).toEqual(null);
            });
        });

        describe("is_semi_max", function() {
            it("reports 1 as semi max", function() { 
                expect(SemiHeapSort.is_semi_max(1, 2, 3, comp)).toBe(true);
            });
            it("reports 2 as semi max", function() { 
                expect(SemiHeapSort.is_semi_max(2, 1, 3, comp)).toBe(true);
            });
            it("reports 3 as semi max", function() { 
                expect(SemiHeapSort.is_semi_max(3, 1, 2, comp)).toBe(true);
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
            var n = null;
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

        describe("max", function() {
            it("finds no max", function() {
                expect(SemiHeapSort.max(1, 2, 3, comp)).toEqual(null);
            });
        });

        describe("is_semi_max", function() {
            it("reports 1 as semi max", function() { 
                expect(SemiHeapSort.is_semi_max(1, 2, 3, comp)).toBe(true);
            });
            it("reports 2 as semi max", function() { 
                expect(SemiHeapSort.is_semi_max(2, 1, 3, comp)).toBe(true);
            });
            it("reports 3 as semi max", function() { 
                expect(SemiHeapSort.is_semi_max(3, 1, 2, comp)).toBe(true);
            });
        });

        describe("semi_heap_sort", function() {
            it("sorts items correctly", function() {
                expect(SemiHeapSort.sort([1, 2, 3], comp)).toEqual([1, 3, 2]);
            });
        });

    });

    describe("example tournament", function() {
        beforeEach(function() {
            var n = null;
            tournament = [
                [n, 0, 1, 0, 1, 0, 1, 1],
                [1, n, 0, 1, 0, 1, 0, 1],
                [0, 1, n, 0, 0, 1, 0, 0],
                [1, 0, 1, n, 1, 1, 0, 1],
                [0, 1, 1, 0, n, 1, 1, 1],
                [1, 0, 0, 0, 0, n, 0, 0],
                [0, 1, 1, 1, 0, 1, n, 0],
                [0, 0, 1, 0, 0, 1, 1, n]
            ];
        });

        describe("beats", function() {
            it("works", function() {
                expect(SemiHeapSort.beats(7, 3, comp)).toBe(true);
                expect(SemiHeapSort.beats(3, 7, comp)).toBe(false);
            });
        });

        describe("max", function() {
            it("finds 7 as max in triangle 3, 6, 7", function() {
                expect(SemiHeapSort.max(3, 6, 7, comp)).toEqual(7);
            });
            it("finds 4 as max in triangle 4, 8", function() {
                expect(SemiHeapSort.max(4, 8, null, comp)).toEqual(4);
            });

            it("finds no max in triangle 2, 4, 5", function() {
                expect(SemiHeapSort.max(2, 4, 5, comp)).toEqual(null);
            });
            it("finds no max in triangle 1, 2, 3", function() {
                expect(SemiHeapSort.max(1, 2, 3, comp)).toEqual(null);
            });
        }); 

        describe("is_max", function() {
            it("reports 4 as max in 4, 8", function() {
                expect(SemiHeapSort.is_max(4, 8, null, comp)).toBe(true);
            });
            it("reports 8 as NOT max in 4, 8", function() {
                expect(SemiHeapSort.is_max(8, 4, null, comp)).toBe(false);
            });
            it("reports null as max in 4, 8", function() {
                expect(SemiHeapSort.is_max(null, 4, 8, comp)).toBe(false);
            });
        });

        describe("is_semi_max", function() {
            it("reports 7 as semi max in 3, 6, 7", function() { 
                expect(SemiHeapSort.is_semi_max(7, 3, 6, comp)).toBe(true);
            });
            it("reports 3 as NOT semi max in 3, 6, 7", function() { 
                expect(SemiHeapSort.is_semi_max(3, 6, 7, comp)).toBe(false);
            });
            it("reports 6 as NOT semi max in 3, 6, 7", function() { 
                expect(SemiHeapSort.is_semi_max(6, 3, 7, comp)).toBe(false);
            });

            it("reports 4 as semi max in 4, 8", function() { 
                expect(SemiHeapSort.is_semi_max(4, 8, null, comp)).toBe(true);
            });
            it("reports 8 as NOT semi max in 4, 8", function() { 
                expect(SemiHeapSort.is_semi_max(8, 4, null, comp)).toBe(false);
            });

            it("reports 2 as semi max in 2, 4, 5", function() { 
                expect(SemiHeapSort.is_semi_max(2, 4, 5, comp)).toBe(true);
            });
            it("reports 4 as semi max in 2, 4, 5", function() { 
                expect(SemiHeapSort.is_semi_max(4, 2, 5, comp)).toBe(true);
            });
            it("reports 5 as semi max in 2, 4, 5", function() { 
                expect(SemiHeapSort.is_semi_max(5, 2, 4, comp)).toBe(true);
            });
        });

        describe("build_semi_heap", function() {
            it("orders items correctly", function() {
                var a = SemiHeapSort.build_semi_heap([1, 2, 3, 4, 5, 6, 7, 8], comp);
                a = a.filter(function(n) { return n != undefined });
                expect(a).toEqual([1, 2, 7, 4, 5, 6, 3, 8]);
            });
        });

        describe("semi heap sort", function() {
            it("sorts items correctly", function() {
                var input = [1, 2, 3, 4, 5, 6, 7, 8];
                expect(SemiHeapSort.sort(input, comp)).toEqual([1, 7, 3, 2, 4, 5, 8, 6]);
                expect(SemiHeapSort.sort(input.reverse(), comp)).toEqual([8, 7, 4, 1, 5, 3, 2, 6]);
            });
        });
    });

});
