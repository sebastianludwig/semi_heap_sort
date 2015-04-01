require_relative '../sort'

describe SemiHeapSort do
    before do
        @comp = Proc.new { |a, b| @tournament[a, b] == 1 ? -1 : 1 }
    end

    context 'Figure 2 (a)' do
        before do
            n = nil
            @tournament = Matrix[
                [n, 1, 1],
                [0, n, 1],
                [0, 0, n]
            ]
        end

        describe 'max' do
            it 'finds 0 as max' do expect(SemiHeapSort.max(0, 1, 2, &@comp)).to eq 0 end

            it 'finds 0 as max regardless of the arguemnt order' do
                expect(SemiHeapSort.max(0, 2, 1, &@comp)).to eq 0
                expect(SemiHeapSort.max(1, 0, 2, &@comp)).to eq 0
                expect(SemiHeapSort.max(2, 0, 1, &@comp)).to eq 0
                expect(SemiHeapSort.max(1, 2, 0, &@comp)).to eq 0
                expect(SemiHeapSort.max(2, 1, 0, &@comp)).to eq 0
            end

            it 'reports 0 as max' do expect(SemiHeapSort.is_max?(0, 1, 2, &@comp)).to eq true end
            it 'reports 1 as NOT max' do expect(SemiHeapSort.is_max?(1, 0, 2, &@comp)).to eq false end
            it 'reports 2 as NOT max' do expect(SemiHeapSort.is_max?(2, 0, 1, &@comp)).to eq false end
        end

        describe 'semi max' do
            it 'reports 0 as semi max' do expect(SemiHeapSort.is_semi_max?(0, 1, 2, &@comp)).to eq  true end
            it 'reports 1 as NOT semi max' do expect(SemiHeapSort.is_semi_max?(1, 0, 2, &@comp)).to eq  false end
            it 'reports 2 as NOT semi max' do expect(SemiHeapSort.is_semi_max?(2, 0, 1, &@comp)).to eq  false end
        end

        describe 'semi heap sort' do
            it 'sorts items correctly' do
                expect(SemiHeapSort.semi_heap_sort((0..2).to_a, &@comp)).to eq [0, 1, 2]
            end
        end
    end

    context 'Figure 2 (b)' do
        before do
            n = nil
            @tournament = Matrix[
                [n, 1, 1],
                [0, n, 0],
                [0, 1, n]
            ]
        end

        describe 'max' do
            it 'finds 0 as max' do expect(SemiHeapSort.max(0, 1, 2, &@comp)).to eq 0 end
        end

        describe 'semi max' do
            it 'reports 0 as semi max' do expect(SemiHeapSort.is_semi_max?(0, 1, 2, &@comp)).to eq  true end
            it 'reports 1 as NOT semi max' do expect(SemiHeapSort.is_semi_max?(1, 0, 2, &@comp)).to eq  false end
            it 'reports 2 as NOT semi max' do expect(SemiHeapSort.is_semi_max?(2, 0, 1, &@comp)).to eq  false end
        end

        describe 'semi heap sort' do
            it 'sorts items correctly' do
                expect(SemiHeapSort.semi_heap_sort((0..2).to_a, &@comp)).to eq [0, 2, 1]
            end
        end
    end

    context 'Figure 2 (c)' do
        before do
            n = nil
            @tournament = Matrix[
                [n, 1, 0],
                [0, n, 1],
                [1, 0, n]
            ]
        end

        describe 'max' do
            it 'finds no max' do expect(SemiHeapSort.max(0, 1, 2, &@comp)).to eq nil end
        end

        describe 'semi max' do
            it 'reports 0 as semi max' do expect(SemiHeapSort.is_semi_max?(0, 1, 2, &@comp)).to eq  true end
            it 'reports 1 as semi max' do expect(SemiHeapSort.is_semi_max?(1, 0, 2, &@comp)).to eq  true end
            it 'reports 2 as semi max' do expect(SemiHeapSort.is_semi_max?(2, 0, 1, &@comp)).to eq  true end
        end

        describe 'semi heap sort' do
            it 'sorts items correctly' do
                expect(SemiHeapSort.semi_heap_sort((0..2).to_a, &@comp)).to eq [0, 1, 2]
            end
        end
    end

    context 'Figure 2 (d)' do
        before do
            n = nil
            @tournament = Matrix[
                [n, 0, 1],
                [1, n, 0],
                [0, 1, n]
            ]
        end

        describe 'beats?' do
            it 'works' do 
                expect(SemiHeapSort.beats?(0, 2, &@comp)).to eq true
                expect(SemiHeapSort.beats?(1, 0, &@comp)).to eq true
                expect(SemiHeapSort.beats?(2, 1, &@comp)).to eq true
            end
        end

        describe 'max' do
            it 'finds no max' do expect(SemiHeapSort.max(0, 1, 2, &@comp)).to eq nil end
        end

        describe 'semi max' do
            it 'reports 0 as semi max' do expect(SemiHeapSort.is_semi_max?(0, 1, 2, &@comp)).to eq  true end
            it 'reports 1 as semi max' do expect(SemiHeapSort.is_semi_max?(1, 0, 2, &@comp)).to eq  true end
            it 'reports 2 as semi max' do expect(SemiHeapSort.is_semi_max?(2, 0, 1, &@comp)).to eq  true end
        end

        describe 'semi heap sort' do
            it 'sorts items correctly' do
                expect(SemiHeapSort.semi_heap_sort((0..2).to_a, &@comp)).to eq [0, 2, 1]
            end
        end
    end

    context 'example tournament' do
        before do
            n = nil
            @tournament = Matrix[
                [n, 0, 1, 0, 1, 0, 1, 1],
                [1, n, 0, 1, 0, 1, 0, 1],
                [0, 1, n, 0, 0, 1, 0, 0],
                [1, 0, 1, n, 1, 1, 0, 1],
                [0, 1, 1, 0, n, 1, 1, 1],
                [1, 0, 0, 0, 0, n, 0, 0],
                [0, 1, 1, 1, 0, 1, n, 0],
                [0, 0, 1, 0, 0, 1, 1, n]
            ]
        end

        describe 'beats?' do
            it 'works' do 
                expect(SemiHeapSort.beats?(6, 2, &@comp)).to eq true
                expect(SemiHeapSort.beats?(2, 6, &@comp)).to eq false
            end
        end

        describe 'max' do
            it 'finds 7 as max in triangle 3, 6, 7' do expect(SemiHeapSort.max(2, 5, 6, &@comp)).to eq 6 end
            it 'finds 4 as max in triangle 4, 8' do expect(SemiHeapSort.max(3, 7, nil, &@comp)).to eq 3 end

            it 'finds no max in 2, 4, 5' do expect(SemiHeapSort.max(1, 3, 4, &@comp)).to eq nil end
            it 'finds no max in 1, 2, 3' do expect(SemiHeapSort.max(0, 1, 2, &@comp)).to eq nil end
        end

        describe 'is_max?' do
            it 'reports 4 as max in 4, 8' do expect(SemiHeapSort.is_max?(3, 7, nil, &@comp)).to eq true end
            it 'reports 8 as NOT max in 4, 8' do expect(SemiHeapSort.is_max?(7, 3, nil, &@comp)).to eq false end
            it 'reports nil as NOT max in 4, 8' do expect(SemiHeapSort.is_max?(nil, 3, 7, &@comp)).to eq false end
        end

        describe 'semi max' do
            it 'reports 7 as semi max in 3, 6, 7' do expect(SemiHeapSort.is_semi_max?(6, 2, 5, &@comp)).to eq true end
            it 'reports 3 as NOT semi max in 3, 6, 7' do expect(SemiHeapSort.is_semi_max?(2, 5, 6, &@comp)).to eq false end
            it 'reports 6 as NOT semi max in 3, 6, 7' do expect(SemiHeapSort.is_semi_max?(5, 2, 6, &@comp)).to eq false end

            it 'reports 4 as semi max in 4, 8' do expect(SemiHeapSort.is_semi_max?(3, 7, nil, &@comp)).to eq true end
            it 'reports 8 as NOT semi max in 4, 8' do expect(SemiHeapSort.is_semi_max?(7, 3, nil, &@comp)).to eq false end

            it 'reports 2 as semi max in 2, 4, 5' do expect(SemiHeapSort.is_semi_max?(1, 3, 4, &@comp)).to eq true end
            it 'reports 4 as semi max in 2, 4, 5' do expect(SemiHeapSort.is_semi_max?(3, 1, 4, &@comp)).to eq true end
            it 'reports 5 as semi max in 2, 4, 5' do expect(SemiHeapSort.is_semi_max?(4, 1, 3, &@comp)).to eq true end
        end




        describe 'semi heap sort' do
            it 'sorts items correctly' do
                expect(SemiHeapSort.semi_heap_sort((0..7).to_a, &@comp)).to eq [0, 6, 2, 1, 3, 4, 7, 5]
            end
        end
    end
end
