require "connect_four"

describe ConnectFour do
  context 'before any moves' do
    it 'is empty' do
      subject.columns.each do |column|
        expect(column.length).to eql(0)
      end
    end
  end

  describe '#move' do
    context 'after first valid move' do
      let!(:first_player) { subject.get_current_player }
      let!(:column_before_move) do
        Marshal.load Marshal::dump(subject.columns[column_index])
      end

      let(:column_index) { 2 }
      let(:column) { subject.columns[column_index] }

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

    context 'when column index is negative' do
      it 'returns false' do
        expect(subject.move(-1)).to be false
      end
    end

    context 'when column index out of bounds' do
      it 'returns false' do
        expect(subject.move(ConnectFour::NUM_COLS)).to be false
      end
    end

    context 'when column is full' do
      before { ConnectFour::MAX_HEIGHT.times { subject.move(0) } }

      it 'returns false' do
        expect(subject.move(0)).to be false
      end
    end
  end

  describe "#connect_four?" do
    context 'when empty' do
      it 'returns false' do
        subject.columns.each_with_index do |column, column_index|
          expect(subject.connect_four?(column_index)).to be false
        end
      end
    end

    context "when only three-of-a-kind in a column" do
      let(:column_index) { 5 }

      before do
        3.times do |i|
          subject.move(i)
          subject.move(column_index)
        end
      end

      it 'returns false' do
        expect(subject.connect_four?(column_index)).to be false
      end
    end

    context 'when four-of-a-kind in a column' do
      let(:column_index) { 5 }

      before do
        4.times do |i|
          subject.move(i)
          subject.move(column_index)
        end
      end

      it 'returns true' do
        expect(subject.connect_four?(column_index)).to be true
      end
    end

    context 'when five-of-a-kind in a column' do
      let(:column_index) { 5 }

      before do
        5.times do |i|
          subject.move(i)
          subject.move(column_index)
        end
      end

      it 'returns true' do
        expect(subject.connect_four?(column_index)).to be true
      end
    end

    context "when three-of-a-kind in a row" do
      before do
        3.times do |i|
          subject.move(i + 1)
          subject.move(0)
        end
      end

      it 'returns false' do
        expect(subject.connect_four?(2)).to be false  
      end
    end

    context "when four-of-a-kind in a row" do
      before do
        4.times do |i|
          subject.move(i + 1)
          subject.move(0)
        end
      end

      it 'returns true' do
        expect(subject.connect_four?(2)).to be true  
      end
    end

    context "when five-of-a-kind in a row" do
      before do
        5.times do |i|
          subject.move(i + 1)
          subject.move(0)
        end
      end

      it 'returns true' do
        expect(subject.connect_four?(3)).to be true  
      end
    end
  end
end