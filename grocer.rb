require "pry"
# each_with_object

def consolidate_cart(cart)
  cart_hash = {}
  cart.each do |food_item_hash|
    food_item_frequency = cart.count(food_item_hash)
    food_item_hash.each do |food_item_key, attribute_hash|
      attribute_hash[:count] = food_item_frequency
        if cart_hash == {}
          cart_hash = {food_item_key => attribute_hash}
        else  
          cart_hash[food_item_key] = attribute_hash
        end
    end 
  end 
  cart_hash
end


def apply_coupons(cart, coupons)
  coupons.each do |coupon_hash|
    name = coupon_hash[:item]
    if cart[name] && cart[name][:count] >= coupon_hash[:num]
      if cart["#{name} W/COUPON"] 
        cart["#{name} W/COUPON"][:count] += 1
      else 
        cart["#{name} W/COUPON"] = {:price => coupon_hash[:cost], :clearance => cart[name][:clearance], :count => 1}
      end 
      cart[name][:count] -= coupon_hash[:num]
    end
  end 
  cart 
end


def apply_clearance(cart)
  cart.each do |food_item_key, food_item_hash|
    if  cart[food_item_key][:clearance] == true
       cart[food_item_key][:price] =  (cart[food_item_key][:price] * 0.8).round(1)
    end
  end 
  cart 
end


def checkout(cart, coupons)
  total = 0 
  consolidated_cart = consolidate_cart(cart)
  couponed_cart = apply_coupons(consolidated_cart, coupons)
  cleared_cart = apply_clearance(couponed_cart)
  cleared_cart.each do |food_item_key, food_item_info_hash|
    total += food_item_info_hash[:price] * food_item_info_hash[:count]
  end
  total 
  if total > 100.0 
    total = total * 0.9
  end
  total 
end