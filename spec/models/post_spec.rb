require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'Associations' do
    it { should belong_to(:user) }
    it { should have_many(:comments) }
    it { should have_many(:likes) }
  end

  describe 'Validations' do
    context 'when content is nil' do
      it { should validate_presence_of(:content) }
    end

    context 'when content length is max: 1000' do
      it {
        should validate_length_of(:content)
          .is_at_most(1000)
          .with_long_message('1000 characters in post is the maximum allowed.')
      }
    end
  end
end
