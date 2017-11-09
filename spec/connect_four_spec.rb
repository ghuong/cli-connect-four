require "connect_four"

describe ConnectFour do
  context 'before any moves' do
    it 'is empty' do
      (0...ConnectFour::NUM_COLS).each do |column_index|
        expect(subject.get_column(column_index).length).to eql(0)
      end
    end
  end

  describe '#move' do
    context 'after first valid move' do
      let!(:first_player) { subject.get_current_player }
      let!(:column_before_move) do
        Marshal.load Marshal::dump(subject.get_column(column_index))
      end

      let(:column_index) { 4 }
      let(:column) { subject.get_column(column_index) }

      before { subject.move(column_index) }
      
      it 'is no longer first player\'s turn' do
        expect(subject.get_current_player).not_to eql(first_player)
      end

      it 'means that column contains one piece' do
        expect(column.length).to eql(1)
      end

      it 'means top of that column is first player\'s piece' do
        expect(column.last).to eql(first_player)
      end

      context 'and after second valid move in the same column' do
        let!(:second_player) { subject.get_current_player }

        before { subject.move(column_index) }

        it 'is first player\'s turn again' do
          expect(subject.get_current_player).to eql(first_player)
        end

        it 'means that column contains two pieces' do
          expect(column.length).to eql(2)
        end

        it 'means top of that column is second player\'s piece' do
          expect(column.last).to eql(second_player)
        end
      end
    end
  end

  describe "#connect_four?" do
    context 'when four-of-a-kind in a column' do
      it 'returns true' do
        expect(subject.connect_four?).to be true
      end
    end
  end
end