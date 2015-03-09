require_relative '../sort'

describe 'SemiHeapSort' do
    context 'Figure 2 (a)' do
        before do
            n = nil
            @tournament = Matrix[
                [n, 1, 1],
                [0, n, 1],
                [0, 0, n]
            ]
            check_tournament @tournament
        end

        describe 'max' do
            it 'finds 0 as max' do expect(max(@tournament, 0, 1, 2)).to eq 0 end

            it 'finds 0 as max regardless of the arguemnt order' do
                expect(max(@tournament, 0, 2, 1)).to eq 0
                expect(max(@tournament, 1, 0, 2)).to eq 0
                expect(max(@tournament, 2, 0, 1)).to eq 0
                expect(max(@tournament, 1, 2, 0)).to eq 0
                expect(max(@tournament, 2, 1, 0)).to eq 0
            end

            it 'reports 0 as max' do expect(is_max?(@tournament, 0, 1, 2)).to eq true end
            it 'reports 1 as NOT max' do expect(is_max?(@tournament, 1, 0, 2)).to eq false end
            it 'reports 2 as NOT max' do expect(is_max?(@tournament, 2, 0, 1)).to eq false end
        end

        describe 'semi max' do
            it 'reports 0 as semi max' do expect(is_semi_max?(@tournament, 0, 1, 2)).to eq  true end
            it 'reports 1 as NOT semi max' do expect(is_semi_max?(@tournament, 1, 0, 2)).to eq  false end
            it 'reports 2 as NOT semi max' do expect(is_semi_max?(@tournament, 2, 0, 1)).to eq  false end
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
            check_tournament @tournament
        end

        describe 'max' do
            it 'finds 0 as max' do expect(max(@tournament, 0, 1, 2)).to eq 0 end
        end

        describe 'semi max' do
            it 'reports 0 as semi max' do expect(is_semi_max?(@tournament, 0, 1, 2)).to eq  true end
            it 'reports 1 as NOT semi max' do expect(is_semi_max?(@tournament, 1, 0, 2)).to eq  false end
            it 'reports 2 as NOT semi max' do expect(is_semi_max?(@tournament, 2, 0, 1)).to eq  false end
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
            check_tournament @tournament
        end

        describe 'max' do
            it 'finds no max' do expect(max(@tournament, 0, 1, 2)).to eq nil end
        end

        describe 'semi max' do
            it 'reports 0 as semi max' do expect(is_semi_max?(@tournament, 0, 1, 2)).to eq  true end
            it 'reports 1 as semi max' do expect(is_semi_max?(@tournament, 1, 0, 2)).to eq  true end
            it 'reports 2 as semi max' do expect(is_semi_max?(@tournament, 2, 0, 1)).to eq  true end
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
            check_tournament @tournament
        end

        describe 'max' do
            it 'finds no max' do expect(max(@tournament, 0, 1, 2)).to eq nil end
        end

        describe 'semi max' do
            it 'reports 0 as semi max' do expect(is_semi_max?(@tournament, 0, 1, 2)).to eq  true end
            it 'reports 1 as semi max' do expect(is_semi_max?(@tournament, 1, 0, 2)).to eq  true end
            it 'reports 2 as semi max' do expect(is_semi_max?(@tournament, 2, 0, 1)).to eq  true end
        end
    end

    context 'example tournament' do
        before do
            n = nil
            @tournament = Matrix[         # Tournament
                [n, 0, 1, 0, 1, 0, 1, 1],
                [1, n, 0, 1, 0, 1, 0, 1],
                [0, 1, n, 0, 0, 1, 0, 0],
                [1, 0, 1, n, 1, 1, 0, 1],
                [0, 1, 1, 0, n, 1, 1, 1],
                [1, 0, 0, 0, 0, n, 0, 0],
                [0, 1, 1, 1, 0, 1, n, 0],
                [0, 0, 1, 0, 0, 1, 1, n]
            ]
            check_tournament @tournament
        end

        describe 'max' do
            it 'finds 3 as max in triangle 3, 6, 7' do expect(max(@tournament, 2, 5, 6)).to eq 6 end
            it 'finds 4 as max in triangle 4, 8' do expect(max(@tournament, 4, 8, 9)).to eq 4 end

            it 'finds no max in 2, 4, 5' do expect(max(@tournament, 1, 3, 4)).to eq nil end
            it 'finds no max in 1, 2, 3' do expect(max(@tournament, 0, 1, 2)).to eq nil end
        end

        describe 'semi max' do
            it 'reports 7 as semi max in 3, 6, 7' do expect(is_semi_max?(@tournament, 6, 2, 5)).to eq true end
            it 'reports 3 as NOT semi max in 3, 6, 7' do expect(is_semi_max?(@tournament, 2, 5, 6)).to eq false end
            it 'reports 6 as NOT semi max in 3, 6, 7' do expect(is_semi_max?(@tournament, 5, 2, 6)).to eq false end

            it 'reports 4 as semi max in 4, 8' do expect(is_semi_max?(@tournament, 4, 8, 9)).to eq true end
            it 'reports 8 as NOT semi max in 4, 8' do expect(is_semi_max?(@tournament, 8, 4, 9)).to eq false end

            it 'reports 2 as semi max in 2, 4, 5' do expect(is_semi_max?(@tournament, 1, 3, 4)).to eq true end
            it 'reports 4 as semi max in 2, 4, 5' do expect(is_semi_max?(@tournament, 3, 1, 4)).to eq true end
            it 'reports 5 as semi max in 2, 4, 5' do expect(is_semi_max?(@tournament, 4, 1, 3)).to eq true end
        end
    end
end
