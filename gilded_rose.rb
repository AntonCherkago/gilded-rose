# frozen_string_literal: true

class GildedRose
  MAX_NORMAL_QUALITY = 50

  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each { |item| update_item(item) }
  end

  private

  def update_item(item)
    case item.name
    when 'Backstage passes to a TAFKAL80ETC concert'
      update_backstage_passes(item)
    when 'Sulfuras, Hand of Ragnaros'
      nil
    when 'Aged Brie'
      update_aged_brie(item)
    when /Conjured/
      update_normal_item(item, 2)
    else
      update_normal_item(item)
    end
  end

  def update_aged_brie(item)
    item.quality += 1 if item.quality < MAX_NORMAL_QUALITY
    item.sell_in -= 1
    return unless item.sell_in.negative?

    item.quality += 1 if item.quality < MAX_NORMAL_QUALITY
  end

  def update_backstage_passes(item)
    if item.sell_in > 10
      item.quality += 1
    elsif item.sell_in > 5
      item.quality += 2
    elsif item.sell_in.positive?
      item.quality += 3
    else
      item.quality = 0
    end
    item.sell_in -= 1
    item.quality = MAX_NORMAL_QUALITY if item.quality > MAX_NORMAL_QUALITY
  end

  def update_normal_item(item, delta = 1)
    item.quality -= delta if item.quality.positive?
    item.sell_in -= 1
    return unless item.sell_in.negative?

    item.quality -= delta if item.quality.positive?
  end
end
