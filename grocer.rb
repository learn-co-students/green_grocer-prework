require 'pry'

def consolidate_cart(cart)
  # code here
  count = 0
  new = []
  new_hash = {}
  cart.each do |bag|
    bag.each do |item, details|
      new.push(item)
      count = new.count(item)
      #binding.pry
      new_hash[item] = details
      details[:count] = count
    end
  end
  new_hash
end

def apply_coupons(cart, coupons)
  # code here
  new = []
  cart.each do |item, info|
    new.push(item)
  end

  new.each do |item|
    coupon_hash = {:count => 0}
    coupons.each do |coupon, stats|
      if item == coupon[:item] && cart[item][:count] - coupon[:num] >= 0
        #binding.pry
        cart[item][:count] -= coupon[:num]
        coupon_hash[:price] = coupon[:cost]
        coupon_hash[:clearance] = cart[item][:clearance]
        coupon_hash[:count] += 1
        cart["#{item} W/COUPON"] = coupon_hash
        #binding.pry
      end
    end
  end
  cart
end

def apply_clearance(cart)
  # code here
  cart.each do |item, details|
    if details[:clearance] == true
      details[:price] -= details[:price] * 0.2
    end
  end
  cart
end

def checkout(cart, coupons)
  # code here
  total = 0.00
  new = []
  apply_clearance(apply_coupons(consolidate_cart(cart), coupons)).each do |item, stats|
    stats.each do |data, info|
      if stats[:count] > 0
      new.push(stats[:price] * stats[:count])

      end
    end
  end

  new.uniq.each do |item|
    total += item
  end

  if total > 100.00
    total = total - (total * 0.1)
  else total
  end

  total
  
end
