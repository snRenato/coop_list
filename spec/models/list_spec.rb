require 'rails_helper'

RSpec.describe List, type: :model do
  describe 'associações' do
    it { should belong_to(:owner).class_name('User') }
    it { should have_many(:members).dependent(:destroy) }
    it { should have_many(:users).through(:members) }
    it { should have_many(:items).dependent(:destroy) }
  end

  describe 'validações' do
    # Adicione aqui se a List tiver validações de atributos (ex: validates :title, presence: true)
  end

  describe 'criação de lista' do
    let(:current_user) { User.create!(name: 'Renato Souza', email: 'user@example.com', password: '123456') }

    it 'é válida quando criada com um owner (simulando current_user)' do
      list = List.new(title: "Nova Lista", owner: current_user)
      expect(list).to be_valid
    end

    it 'é inválida sem owner (não há current_user)' do
      list = List.new(title: "Nova Lista", owner: nil)
      expect(list).not_to be_valid
    end
  end

  describe 'método privado add_owner_as_member' do
    let(:current_user) { User.create!(name: 'Renato Souza', email: 'owner2@example.com', password: '123456') }

    it 'adiciona o dono como membro com status 1 quando chamado manualmente' do
      list = List.create!(title: "Nova Lista", owner: current_user)
      expect {
        list.send(:add_owner_as_member)
      }.to change { list.members.count }.by(1)

      member = list.members.last
      expect(member.user).to eq(current_user)
      expect(member.status).to eq(1)
    end
  end
end
