require './gilded_rose'
require 'rspec'

RSpec.describe GildedRose do

  describe "#update_quality" do
    it "does not change the name" do
      items = [Item.new("foo", 0, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].name).to eq "foo"
    end
    
    it "does not change the Sulfuras item" do
      items = [Item.new("Sulfuras", 0, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].sell_in).to eq 0
      expect(items[0].quality).to eq 0
    end
    
    it "decreses sell in" do
      items = [Item.new("foo", 0, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].sell_in).to eq -1
    end
    
    context 'before sell in' do
      it "this increases the quality of the brie by 1" do
        items = [Item.new("Brie", 5, 0)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 1
      end
      
      it "this decreases the quality of the Conjured by 2" do
        items = [Item.new("Conjured", 5, 2)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 0
      end
      
      it "this increases the quality of the Backstage by 1 when sell in is mare than 10 days" do
        items = [Item.new("Backstage", 11, 0)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 1
      end
      
      it "this increases the quality of the Backstage by 2 when sell in is equal to 10 days" do
        items = [Item.new("Backstage", 10, 0)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 2
      end
      
      it "this increases the quality of the Backstage by 2 when sell in is less than 10 days" do
        items = [Item.new("Backstage", 9, 0)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 2
      end
      
      it "this increases the quality of the Backstage by 3 when sell in is equal to 5 days" do
        items = [Item.new("Backstage", 5, 0)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 3
      end
      
      it "this increases the quality of the Backstage by 3 when sell in is less than 5 days" do
        items = [Item.new("Backstage", 4, 0)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 3
      end
    end
    
    context "after sell in" do
      it "this increases the quality of the brie by 2" do
        items = [Item.new("Brie", -1, 0)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 2
      end
      
      it "this set the quality of the Backstage to 0" do
        items = [Item.new("Backstage", -1, 50)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 0
      end
      
      it "this decreases the quality of the Conjured by 2" do
        items = [Item.new("Conjured", -1, 4)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 0
      end
    end
  end
end

