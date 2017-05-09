def consolidate_cart(cart)
  new_cart = {}
  cart.each_with_index do |item, index|
    item.each do |key, value|
      value[:count] = 1
      new_cart[key] = value
    end
  end

  cart.each_with_index do |item, index|
    item.each do |key, value|
      if item == cart[index + 1]
        new_cart[key][:count] += 1
      end
    end
  end
  new_cart
end

def apply_coupons(cart, coupons)
  count = 0
  with_coupon = {}
  cart.each do |key, value|
    coupons.each do |c|
      c.each do |k, v|
        if key == c[:item] && value[:count] >= c[:num]
          with_coupon["#{key} W/COUPON"] = {:price => c[:cost], :clearance => value[:clearance], :count => count += 1}
          value[:count] -= c[:num]
        end
      end
      count = 0
    end
  end
  cart.merge(with_coupon)
end

def apply_clearance(cart)
  cart.each do |key, value|
    if value[:clearance]
      value[:price] -= 0.20 * value[:price]
    end
  end
  cart
end

def checkout(cart, coupons)
  total = 0
  consolidated = consolidate_cart(cart)
  coupons_applied = apply_coupons(consolidated, coupons)
  cart = apply_clearance(coupons_applied)
  cart.each do |key, value|
    total += value[:price] * value[:count]
  end
  if total > 100
    total -= 0.10 * total
  else
    total
  end
end
