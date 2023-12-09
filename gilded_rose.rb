class GildedRose
  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each do |item|
      update_item(item)
    end
  end

  private

  def update_item(item)
    if item.name.include?("Brie")
      update_aged_brie(item)
    elsif item.name.include?("Backstage")
      update_backstage_passes(item)
    elsif item.name.include?("Sulfuras")
      return # Sulfuras - Do nothing as its quality and sell_in never change
    elsif item.name.include?("Conjured")
      update_conjured(item)
    else
      update_normal_item(item)
    end
    
    decrease_sell_in(item)
    update_quality_after_sell_in(item)
  end
  
  def update_conjured(item)
    decrease_quality(item, 2)
  end

  def update_aged_brie(item)
    increase_quality(item)
  end

  def update_backstage_passes(item)
    if item.sell_in <= 0
      item.quality = 0
    elsif item.sell_in <= 5
      increase_quality(item, 3)
    elsif item.sell_in <= 10
      increase_quality(item, 2)
    else
      increase_quality(item)
    end
  end

  def update_normal_item(item)
    decrease_quality(item)
  end

  def decrease_sell_in(item)
    item.sell_in -= 1
  end

  def update_quality_after_sell_in(item)
    if item.sell_in < 0
      if item.name.include?("Brie")
        increase_quality(item)
      elsif item.name.include?("Conjured")
      	decrease_quality(item, 2)
      else
        decrease_quality(item)
      end
    end
  end

  def increase_quality(item, amount = 1)
    item.quality += amount if item.quality < 50
    item.quality = 50 if (item.quality + amount) > 50
  end

  def decrease_quality(item, amount = 1)
    item.quality -= amount if item.quality > 0
    item.quality = 0 if (item.quality - amount) < 0
  end
end

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end

