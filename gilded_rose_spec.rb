# frozen_string_literal: true

require 'rspec'
require './gilded_rose'
require './item'

describe GildedRose do
  it 'does not change the name' do
    items = [Item.new('foo', 0, 0)]
    GildedRose.new(items).update_quality
    expect(items[0].name).to eq 'foo'
  end

  it 'check updating aged brie item' do
    items = [Item.new('Aged Brie', 2, 0)]
    3.times { GildedRose.new(items).update_quality }
    expect(items[0].quality).to eq(4)
    expect(items[0].sell_in).to eq(-1)
  end

  it 'check updating normal item' do
    items = [Item.new('Elixir of the Mongoose', 5, 7)]
    4.times { GildedRose.new(items).update_quality }
    expect(items[0].quality).to eq(3)
    expect(items[0].sell_in).to eq(1)
  end

  it 'check updating sulfuras item' do
    items = [Item.new('Sulfuras, Hand of Ragnaros', 0, 80)]
    5.times { GildedRose.new(items).update_quality }
    expect(items[0].quality).to eq(80)
    expect(items[0].sell_in).to eq(0)
  end

  it 'check updating conjured item' do
    items = [Item.new('Conjured Mana Cake', 3, 8)]
    6.times { GildedRose.new(items).update_quality }
    expect(items[0].quality).to eq(0)
    expect(items[0].sell_in).to eq(-3)
  end

  it 'check updating backstage passes item' do
    items = [Item.new('Backstage passes to a TAFKAL80ETC concert', 11, 20)]
    7.times { GildedRose.new(items).update_quality }
    expect(items[0].quality).to eq(34)
    expect(items[0].sell_in).to eq(4)
  end
end
