cart_hash =    [
      {"AVOCADO" => {:price => 3.00, :clearance => true}},
      {"KALE" => {:price => 3.00, :clearance => false}},
      {"BLACK_BEANS" => {:price => 2.50, :clearance => false}},
      {"ALMONDS" => {:price => 9.00, :clearance => false}},
      {"TEMPEH" => {:price => 3.00, :clearance => true}},
      {"CHEESE" => {:price => 6.50, :clearance => false}},
      {"BEER" => {:price => 13.00, :clearance => false}},
      {"PEANUTBUTTER" => {:price => 3.00, :clearance => true}},
      {"BEETS" => {:price => 2.50, :clearance => false}},
      {"SOY MILK" => {:price => 4.50, :clearance => true}}
    ]
cart_hash =    [
    {"BEER" => {:price => 13.00, :clearance => false}},
    {"BEER" => {:price => 13.00, :clearance => false}},
    {"BEER" => {:price => 13.00, :clearance => false}}
    ]



coupon =     [
      {:item => "AVOCADO", :num => 2, :cost => 5.00},
      {:item => "BEER", :num => 2, :cost => 20.00},
      {:item => "BEER", :num => 2, :cost => 20.00},
      {:item => "CHEESE", :num => 3, :cost => 15.00}
    ]

def consolidate_cart(cart)
  count_dict = {}
  item_list = []
  new_cart_dict = {}
  cart.each do |item_hash|
    item_hash.each do |item, information_hash|
      item_list << item
        item_list.each do |item_in_list|
          count_dict[item_in_list] = item_list.count(item_in_list)
          new_cart_dict[item] = information_hash
        end
      count_dict.each do |grocery_item, count|
        if grocery_item == item
          new_cart_dict[item][:count] = count
        end
      end 
    end
  end
  new_cart_dict
end

def apply_coupons(cart, coupons)
  new_cart_dict = {}
  items_covered_by_coupon = 0
  num_of_coupons_applied_per_item = {}
    cart.each do |item, information_hash|
      num_of_coupons_applied_per_item[item] = 0
      new_cart_dict[item] = information_hash
      if coupons 
        coupons.each do |coupon|
        if item == coupon[:item] and new_cart_dict[item][:count] >= coupon[:num]
          num_of_coupons_applied_per_item[item] += 1
          new_item_name = "#{item} W/COUPON"
          number_of_items_leftover = new_cart_dict[item][:count].to_i - coupon[:num].to_i
          new_cart_dict[item][:price] = new_cart_dict[item][:price]
          new_cart_dict[item][:clearance] = new_cart_dict[item][:clearance]
          new_cart_dict[item][:count] = number_of_items_leftover
          new_cart_dict[new_item_name] = {}
          new_cart_dict[new_item_name][:price] = coupon[:cost]
          new_cart_dict[new_item_name][:clearance] = new_cart_dict[item][:clearance]
          new_cart_dict[new_item_name][:count] = num_of_coupons_applied_per_item[item]
        end 
      end
    end
  end 
  new_cart_dict
end

def apply_clearance(cart)
  cart.each do |item, information_hash|
    information_hash.each do |attribute, value|
      if attribute == :clearance and value == true 
        cart[item][:price] = (cart[item][:price] * 0.8).round(3)
      end
    end
  end
  cart
end

def checkout(cart, coupon)
  new_cart = consolidate_cart(cart)
  new_cart = apply_coupons(new_cart, coupon)
  new_cart = apply_clearance(new_cart)
  grand_total = 0
  new_cart.each do |item, information_hash|
    grand_total += new_cart[item][:price] * new_cart[item][:count]
  end
  if grand_total > 100
    grand_total = grand_total * 0.9
  end 
  grand_total
end

puts checkout(cart_hash, coupon)