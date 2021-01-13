require 'rails_helper'

RSpec.describe User, type: :model do
  subject do
    described_class.new(name: '')
  end
  describe 'Associations' do
    it { should have_many(:posts) }
    it { should have_many(:comments) }
    it { should have_many(:likes) }
    it { should have_many(:friendships).conditions(status: false) }
    it { should have_many(:friends).class_name(:Friendship).with_foreign_key(:friend_id) }
  end

  describe 'Validations' do
    it 'is not valide without name' do
      subject.name = nil
      expect(subject).to_not be_valid
    end

    context 'when length of name is greater than 20' do
      it { should validate_length_of(:name).is_at_most(20) }
    end

    context 'when email is nil' do
      it { should validate_presence_of(:email) }
    end

    context 'when password is nil' do
      it { should validate_presence_of(:password) }
    end
  end
end
