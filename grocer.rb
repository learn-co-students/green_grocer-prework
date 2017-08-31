require 'pry'
def consolidate_cart(cart)
  cart_hash = {}
  cart.map do |item_hash|
    item_hash.map do |food_str, info_hash|
      if cart_hash.has_key?(food_str) == false
        cart_hash[food_str] = info_hash
        info_hash[:count] = 1
      else
        info_hash[:count] += 1
      end
    end
  end
  cart_hash
end

def apply_coupons(cart, coupons) # cart is hash, coupons is an array
  cart_hash = cart
  coupons.map do |coupon_hash|
    item_name_str = coupon_hash[:item]
    if cart.has_key?(item_name_str)
      if cart[item_name_str][:count] >= coupon_hash[:num]
        # pushing the discounted line item to new hash:
        cart_hash["#{item_name_str} W/COUPON"] = {}
        cart_hash["#{item_name_str} W/COUPON"][:clearance] = cart[item_name_str][:clearance]
        cart_hash["#{item_name_str} W/COUPON"][:price] = coupon_hash[:cost]
        cart_hash["#{item_name_str} W/COUPON"][:count] = 1

        # altering original line item in new hash:
        cart_hash[item_name_str][:count] -= coupon_hash[:num]
      end

      while cart_hash[item_name_str][:count] >= coupon_hash[:num]
        cart_hash["#{item_name_str} W/COUPON"][:count] += 1
        cart_hash[item_name_str][:count] -= coupon_hash[:num]
      end
    end
  end
  cart_hash
end

def apply_clearance(cart)
  cart.map do |item_name_str, info_hash|
    if info_hash[:clearance] == true
      info_hash[:price] = (info_hash[:price] * 0.8).round(2)
    end
  end
  cart
end

def checkout(cart, coupons)
  total = 0
  cart = consolidate_cart(cart)
  cart = apply_coupons(cart,coupons)
  apply_clearance(cart)
  cart.map { |item_name_str, info_hash| total += info_hash[:price] * info_hash[:count] }
  if total > 100
    (total * 0.9).round(2)
  else total
  end
end
