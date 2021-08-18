require './lib/connect_four.rb'

describe ConnectFour do
  describe '#initialize' do
    context 'when the game is initialized' do
    end
  end

  describe '#valid_input?' do
    context 'when the input is 3' do
      subject(:game) { described_class.new }

      it 'returns true' do
        input = 3
        expect(game.valid_input?(input)).to be_truthy
      end
    end

    context 'when the input is 0' do
      subject(:game) { described_class.new }

      it 'returns false' do
        input = 0
        expect(game.valid_input?(input)).to be_falsey
      end
    end
    
    context 'when the input is nil' do
      subject(:game) { described_class.new }

      it 'returns false' do
        input = nil
        expect(game.valid_input?(input)).to be_falsey
      end
    end
  end

  describe '#next_turn' do
    context 'when current player is 1' do
      subject(:game) { described_class.new }
      it 'changes player from 1 to 2' do
        game.next_turn
        expect(game.current_player).to eql('2')
      end
    end
    
    context 'when current player is 2' do
      subject(:game) { described_class.new }
      it 'changes player from 2 to 1' do
        game.next_turn
        game.next_turn
        expect(game.current_player).to eql('1')
      end
    end
  end

  describe '#valid_move?' do
    context 'when column is empty' do
      subject(:game) { described_class.new }
      it 'returns true' do
        expect(game).to be_valid_move(1)
      end
    end
    
    context 'when column is full' do
      subject(:game) { described_class.new }
      it 'returns false' do
        game_board = game.board
        game_board.insert_disk(1, '1')
        game_board.insert_disk(1, '1')
        game_board.insert_disk(1, '1')
        game_board.insert_disk(1, '1')
        game_board.insert_disk(1, '1')
        game_board.insert_disk(1, '1')
        expect(game).not_to be_valid_move(1)
      end
    end
  end
end
