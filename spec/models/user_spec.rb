require 'rails_helper'
RSpec.describe User, type: :model do
  describe 'associações' do
    it { should have_many(:members) }
    it { should have_many(:owned_lists).class_name('List').with_foreign_key('owner_id') }
  end

  describe 'validações' do
    it { should validate_presence_of(:email) }

    it { should validate_presence_of(:password) }
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:email).case_insensitive }
  end

  describe 'criação de usuário' do
    it 'é válido com atributos válidos' do
      user = User.new(
        name: 'João Silva',
        email: 'teste@example.com',
        password: '123456',
        password_confirmation: '123456'
      )
      expect(user).to be_valid
    end

    it 'é inválido sem e-mail' do
      user = User.new(email: nil, password: '123456')
      expect(user).not_to be_valid
    end

    it 'é inválido sem nome' do
      user = User.new(name: "", email: 'teste@example.com', password: '123456')
      expect(user).not_to be_valid
    end

    it 'é inválido com e-mails duplicados' do
      User.create!(name: 'João Silva', email: 'teste@example.com', password: '123456')
      user2 = User.new(name: 'Maria Souza', email: 'teste@example.com', password: 'abcdef')
      expect(user2).not_to be_valid
    end
  end
end
