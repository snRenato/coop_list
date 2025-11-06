require 'rails_helper'

RSpec.describe Item, type: :model do
  let(:user) { create(:user) }
  let(:list) { create(:list, title: "Lista Teste", owner: user) }

  describe "validações" do
    it "é válido com name e list" do
      item = Item.new(name: "Item 1", list: list)
      expect(item).to be_valid
    end

    it "não é válido sem name" do
      item = Item.new(name: nil, list: list)
      expect(item).not_to be_valid
      expect(item.errors[:name]).to include("can't be blank")
    end

    it "não é válido sem list" do
      item = Item.new(name: "Item 1", list: nil)
      expect(item).not_to be_valid
      expect(item.errors[:list]).to include("must exist")
    end
  end

  describe "associações" do
    it "pertence a uma lista" do
      assoc = Item.reflect_on_association(:list)
      expect(assoc.macro).to eq(:belongs_to)
    end
  end

  describe "scopes ou métodos customizados" do
    it "pode ter status ou outros métodos se existirem" do
      item = Item.create!(name: "Item 1", list: list)
      expect(item.completed?).to eq(false) if item.respond_to?(:completed?)
    end
  end
end
