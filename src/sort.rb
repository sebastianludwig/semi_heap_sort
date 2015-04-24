#!/usr/bin/env ruby

require 'matrix'
require_relative 'semi_heap_sort'

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
    # puts SemiHeapSort.semi_heap_sort((0..7).to_a).inspect

    elements = (0..7).map { |i| {index: i, label: "n#{i + 1}"} }
    result = SemiHeapSort.semi_heap_sort(elements) { |a, b| T[a[:index], b[:index]] == 1 ? -1 : 1 }
    result.each { |e| print e[:label], " " }
    puts
end

