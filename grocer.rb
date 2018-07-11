require 'pry'

cart =      [
      {"AVOCADO" => {:price => 3.00, :clearance => true}},
      {"AVOCADO" => {:price => 3.00, :clearance => true}},
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


cart2 = [
{"BEER" => {:price => 13.00, :clearance => false}},
{"BEER" => {:price => 13.00, :clearance => false}},
{"BEER" => {:price => 13.00, :clearance => false}}
]

coupons2 = [{:item => "BEER", :num => 2, :cost => 20.00}, {:item => "BEER", :num => 2, :cost => 20.00}]
coupons =     [
      {:item => "AVOCADO", :num => 2, :cost => 5.00},
      {:item => "BEER", :num => 2, :cost => 20.00},
      {:item => "CHEESE", :num => 3, :cost => 15.00}
    ]


def consolidate_cart(cart)
  i = 0;
  new_hash = {}

  cart.each do |item|
    item.each do |key, value|
      cart[i][key][:count] = 1
      i += 1
    end
  end

  i=0;
  cart.each do |item|
    item.each do |key, value|
      if new_hash.keys.include?(key) == false
        new_hash[key] = value
      elsif new_hash.keys.include?(key) == true
        new_hash[key][:count] += 1
      end
    end
  end
  return new_hash
end

def apply_coupons(cart, coupons)
  coupons.each do |coupon|
    if cart.keys.include?(coupon[:item]) == true && cart.keys.include?(coupon[:item] + " W/COUPON") == false && cart[coupon[:item]][:count] >= coupon[:num]
      cart[coupon[:item] + " W/COUPON"] = {:price => coupon[:cost], :clearance => cart[coupon[:item]][:clearance], :count => 1}
      cart[coupon[:item]][:count] = cart[coupon[:item]][:count] - coupon[:num]
    elsif cart.keys.include?(coupon[:item]) == true && cart.keys.include?(coupon[:item] + " W/COUPON") == true && cart[coupon[:item]][:count] >= coupon[:num]
      cart[coupon[:item] + " W/COUPON"][:count] += 1
      cart[coupon[:item]][:count] = cart[coupon[:item]][:count] - coupon[:num]
    end
  end
# cart.each do |item|
#   item.each do |item_key, item_value|
#     coupons.each do |coupon|
#       if coupon[:item] == item_key && cart[item_key][:count] >= coupon[:num]
#           cart[item_key][:count] = cart[item_key][:count] - coupon[:num]
#           end
#       end
#     end
#   end
  return cart
end
#
# consolidated_cart = consolidate_cart(cart)
# apply_coupons(consolidated_cart, coupons)

def apply_clearance(cart)
  cart.each do |item_name, item_info|
    item_info.each do |key, value|
      if key == :clearance
        if value == true
          cart[item_name][:price] = (cart[item_name][:price] * 0.8).round(3)
        end
      end
    end
  end
  return cart
end


def checkout(cart, coupons)
  consolidated_cart = consolidate_cart(cart)
  coupons_accounted = apply_coupons(consolidated_cart, coupons)
  cleared_and_coupons = apply_clearance(coupons_accounted)
  sum = 0;
  cleared_and_coupons.each do |item, info|
    sum = sum + info[:price] * info[:count]
  end
  if sum > 100.0
    discount = sum * 0.9
    return discount
  else return sum
  end
end
