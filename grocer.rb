require 'pry'

def consolidate_cart(cart)
  new_hash = {}
  cart.each do |list|
    list.each do |item, details|
        if new_hash.include?(item) == true
          new_hash[item][:count] += 1
        else
          new_hash[item] = details
          new_hash[item][:count] = 1
      end
    end
  end
  new_hash
end

def apply_coupons(cart, coupons)
  coupons.each do |coupon|
    item = coupon[:item]
    if cart[item]
      if cart[item][:count] >= coupon[:num]
        if cart["#{item} W/COUPON"]
          cart["#{item} W/COUPON"][:count] += 1
        else
          cart["#{item} W/COUPON"] = {:price => coupon[:cost], :count => 1 }
          cart["#{item} W/COUPON"][:clearance] = cart[item][:clearance]
        end
        cart[item][:count] -= coupon[:num]
      end
    end
  end
  cart
end


def apply_clearance(cart)
  cart.each do |item, details|
    if cart[item][:clearance] == true
      cart[item][:price] = (cart[item][:price] * 0.8).round(2)
    end
  end
end

def checkout(cart, coupons)
  total = 0
  consolidated = consolidate_cart(cart)
  apply_coupons(consolidated, coupons)
  apply_clearance(consolidated)
  consolidated.each do |item, details|
    total += (consolidated[item][:price] * consolidated[item][:count])
  end
  if total > 100
    total *= 0.9
  end
  total.round(2)
end
