require 'rails_helper'

RSpec.describe ListPolicy, type: :policy do
  let(:owner) { User.create!(name: 'Owner', email: 'owner@example.com', password: '123456') }
  let(:member) { User.create!(name: 'Member', email: 'member@example.com', password: '123456') }
  let(:outsider) { User.create!(name: 'Outsider', email: 'outsider@example.com', password: '123456') }

  let(:list) { List.create!(title: 'Lista Teste', owner: owner) }

before do
  Member.create!(user: member, list: list, status: 'accepted')
end


  describe '#show?' do
    it 'permite o dono ver a lista' do
      expect(described_class.new(owner, list).show?).to be true
    end

    it 'permite o membro ver a lista' do
      expect(described_class.new(member, list).show?).to be true
    end

    it 'nega a quem não é membro' do
      expect(described_class.new(outsider, list).show?).to be false
    end
  end

  describe '#update?' do
    it 'permite o dono atualizar' do
      expect(described_class.new(owner, list).update?).to be true
    end

    it 'permite o membro atualizar' do
      expect(described_class.new(member, list).update?).to be true
    end

    it 'nega a quem não é membro' do
      expect(described_class.new(outsider, list).update?).to be false
    end
  end

  describe '#destroy?' do
    it 'permite apenas o dono excluir' do
      expect(described_class.new(owner, list).destroy?).to be true
      expect(described_class.new(member, list).destroy?).to be false
      expect(described_class.new(outsider, list).destroy?).to be false
    end
  end

  describe 'Scope' do
    it 'retorna listas em que o usuário é dono ou membro' do
      scope = Pundit.policy_scope(member, List)
      expect(scope).to include(list)
    end

    it 'não retorna listas de outros usuários' do
      scope = Pundit.policy_scope(outsider, List)
      expect(scope).not_to include(list)
    end
  end
end
