def consolidate_cart(cart)
  return_hash = {}
  if cart.length == 1
    cart[0].each do |item, info|
      info[:count] = 1
      return_hash[item] = info
    end
  end
  cart.uniq do |item_info|
    item_info.each do |item, info|
      info[:count] = cart.count { |hash| hash.keys[0] == item }
      return_hash[item] = info
    end
  end
  return_hash
end

def apply_coupons(cart, coupons)
  if coupons.empty?
    return cart
  end
  return_hash = {}
  cart.each do |item, info|
    coupons.each do |discount|
      if discount[:item] == item && discount[:num] <= info[:count]
        coupon_count = info[:count] / discount[:num]
        info[:count] = info[:count] - (discount[:num] * coupon_count)
        return_hash[item] = info
        return_hash[item + " W/COUPON"] = {:price => discount[:cost], :clearance => info[:clearance], :count => coupon_count}
      else
        return_hash[item] = info
      end
    end
  end
  return_hash
end

def apply_clearance(cart)
  cart.each do |item, info|
    if info[:clearance]
      info[:price] = (info[:price] * 0.8).round(2)
    end
  end
end

def checkout(cart, coupons)
  c_cart = consolidate_cart(cart)
  discount_cart = apply_coupons(c_cart, coupons)
  clear_cart = apply_clearance(discount_cart)
  total = 0
  clear_cart.each do |item, info|
    total += (info[:count] * info[:price]).round(2)
  end
  if total > 100
    total = (total * 0.9).round(2)
  end
  total
end
