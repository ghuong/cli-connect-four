require "connect_four"

describe ConnectFour do
  describe '#move' do
    context 'after a valid move' do
      let!(:first_player) { subject.get_current_player }

      before { subject.move(4) }
      
      it 'is next player\'s turn' do
        expect(subject.get_current_player).not_to eql(first_player)
      end
    end
  end

  # describe "#connect_four?" do
    
  # end
end