require './caesar_cipher'

describe 'caesar_cipher' do
    it 'shifts characters by number' do
        expect(caesar_cipher('abcdef', 5)).to eql('fghijk')
    end

    it 'wraps from z to a' do
        expect(caesar_cipher('xyz', 3)).to eql('abc')
    end

    it 'works with negative number' do
        expect(caesar_cipher('abcdef', -3)).to eql('xyzabc')
    end
end