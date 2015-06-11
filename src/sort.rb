#!/usr/bin/env ruby

require 'matrix'
require_relative 'semi_heap_sort'

class Matrix
  public :"[]=", :set_element, :set_component
end

def read_char
    old_state = `stty -g`
    system("stty raw -echo") #=> Raw mode, no echo
 
    input = STDIN.getc.chr
    if input == "\e" then
        input << STDIN.read_nonblock(3) rescue nil
        input << STDIN.read_nonblock(2) rescue nil
    end
ensure
    system("stty #{old_state}")
    return input
end

def pick_winner(a, b)
    print "#{a} vs #{b} [<-/->]"
    c = read_char until ["\e[D", "\e[C"].include? c
    puts 
    puts "\033[1A\033[K"
    print "\033[1A"
    return c == "\e[D" ? :left : :right
end

if __FILE__ == $0
    n = nil
    # T = Matrix[         # Tournament
    #     [n, 0, 1, 0, 1, 0, 1, 1],
    #     [1, n, 0, 1, 0, 1, 0, 1],
    #     [0, 1, n, 0, 0, 1, 0, 0],
    #     [1, 0, 1, n, 1, 1, 0, 1],
    #     [0, 1, 1, 0, n, 1, 1, 1],
    #     [1, 0, 0, 0, 0, n, 0, 0],
    #     [0, 1, 1, 1, 0, 1, n, 0],
    #     [0, 0, 1, 0, 0, 1, 1, n]
    # ]
    T = Matrix.build(8, 8) { nil }
    SemiHeapSort.check_tournament T
    # puts SemiHeapSort.semi_heap_sort((0..7).to_a).inspect

    elements = (0..7).map { |i| {index: i, label: "n#{i + 1}"} }

    result = SemiHeapSort.sort(elements) do |a, b|
        if T[a[:index], b[:index]].nil? and a[:index] != b[:index]
            winner = pick_winner(a[:label], b[:label])
            T[a[:index], b[:index]] = winner == :left ? 1 : 0
            T[b[:index], a[:index]] = winner == :left ? 0 : 1
        end

        T[a[:index], b[:index]] == 1 ? -1 : 1
    end
    puts "n1 n7 n3 n2 n4 n5 n8 n6"
    result.each { |e| print e[:label], " " }
    puts
end

