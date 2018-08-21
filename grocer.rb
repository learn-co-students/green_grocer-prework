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
  num_of_coupons = coupons.length 
binding.pry
  cart.each do |food_item_key, attribute_hash|
  coupon_applied_cart = nil 
     if cart[food_item_key] == coupons[:item] 
    coupon_applied_cart[food_item_key][:count] = cart[food_item_key][:count] - coupons[:num]
    coupon_applied_cart[food_item_key" W/COUPON"] = {:price => coupons[:cost], :clearance => food_item_key[:clearance], :count => 1}
    end
  end
  coupon_applied_cart
end


def apply_clearance(cart)
  
end


def checkout(cart, coupons)
  
end