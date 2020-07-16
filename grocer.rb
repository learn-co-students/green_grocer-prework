require 'pry'
def consolidate_cart(cart)
  # code here
  cart_hash = {}
  cart.each do |item_hash|
    item_hash.each do |item_name, item_details|
      if cart_hash[item_name].nil?
        cart_hash[item_name] = item_details
      end
      if cart_hash[item_name][:count].nil?
        cart_hash[item_name][:count] = 1
      else
        cart_hash[item_name][:count] += 1
      end
    end
  end
  cart_hash
end

def apply_coupons(cart, coupons)
  coupons.each do |coupon_hash|
    item = coupon_hash[:item]
    if !cart[item].nil?
      if coupon_hash[:num] <= cart[item][:count]
        cart[item][:count] -= coupon_hash[:num]
        if cart["#{item} W/COUPON"].nil?
          cart["#{item} W/COUPON"] = {
            :price => coupon_hash[:cost],
            :clearance => cart[item][:clearance],
            :count => 1
          }
        else
          cart["#{item} W/COUPON"][:count] += 1
        end
      end
    end
  end
  cart
end

def apply_clearance(cart)
  # code here
  cart.each do |item, item_detail_hash|
    if item_detail_hash[:clearance]
       item_detail_hash[:price] = (item_detail_hash[:price] * 0.8).round(2)


    end
  end
  cart
end

def checkout(cart, coupons)
  # code here
  cart_hash = consolidate_cart(cart)
  apply_coupons(cart_hash, coupons)
  apply_clearance(cart_hash)
  cart_total = 0
  cart_hash.each do |item, item_details_hash|
    cart_total += (item_details_hash[:price] * item_details_hash[:count])
  end
  if cart_total > 100
    cart_total = (cart_total * 0.9).round(4)
  end
  cart_total
end
