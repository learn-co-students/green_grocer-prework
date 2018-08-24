def consolidate_cart(cart)
  new_hash = {}
  count = 0
  cart.each do |hash|
    hash.each do |item, info|
      new_hash[item] ||= info

      new_hash[item][:count] ||= 0
      new_hash[item][:count] += 1
    end
  end
  new_hash

end

def apply_coupons(cart, coupons)
  coupon_item = []
  coupons.each do |hash|
    coupon_item << [hash[:item], hash[:cost], hash[:num]]
  end


  coupon_item.each do |item|
    unless cart.include?(item[0])
      coupon_item.delete(item)
    end
  end

  coupon_item.each do |item|
    unless item[2] > cart[item[0]][:count]
      cart["#{item[0]} W/COUPON"] ||= {}
      cart["#{item[0]} W/COUPON"][:clearance] = cart[item[0]][:clearance]
      cart["#{item[0]} W/COUPON"][:price] = item[1]
      cart[item[0]][:count] -= item[2]
      cart["#{item[0]} W/COUPON"][:count] ||= 0
      cart["#{item[0]} W/COUPON"][:count] += 1
    end
  end

  cart
end

def apply_clearance(cart)
  cart.each do |item, info_hash|
    if info_hash[:clearance]
      info_hash[:price] = (info_hash[:price]/5) * 4
    end
  end
  cart
end

def checkout(cart, coupons)
  cart2 = consolidate_cart(cart)
  # puts cart2
  cart3 = apply_coupons(cart2, coupons)
  # puts cart3
  cart4 = apply_clearance(cart3)
  # puts cart4

  cart4.delete_if {|item, info| info[:count] < 1 }

  total = 0
  cart4.each do |item, info|
    total += info[:price] * info[:count]
  end

  if total > 100
    return total * 0.9
  end
  puts cart
  puts cart4
  puts coupons
  total
end
