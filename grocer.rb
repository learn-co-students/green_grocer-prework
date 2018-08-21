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
# cart is a {} 
# coupons is an [] containing one {} or multiple {}es.
  final_hash = nil
  counter = 0 
  coupons.each do |coupon_hash|
# binding.pry 
    if cart.keys.include?(coupon_hash[:item])
      counter += 1
      cart[coupon_hash[:item]][:count] = cart[coupon_hash[:item]][:count] - coupon_hash[:num]
      cart[coupon_hash[:item] + " W/COUPON"] = {:price => coupon_hash[:cost], :clearance => cart[coupon_hash[:item]][:clearance], :count => counter}
    end
  end 
  final_hash = cart 
end


def apply_clearance(cart)
  
end


def checkout(cart, coupons)
  
end