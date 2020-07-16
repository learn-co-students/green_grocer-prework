def consolidate_cart(cart)
  new_cart = {}
  cart.each do |hash|
    hash.each do |key, value|
      if new_cart[key].nil?
        new_cart[key] = value.merge({:count => 1})
      else
        new_cart[key][:count] += 1
      end
    end
  end
  new_cart
end

def apply_coupons(cart, coupons)
  coupons.each do |coupon|
    name = coupon[:item]
    if cart[name] && cart[name][:count] >= coupon[:num]
      if cart["#{name} W/COUPON"]
        cart["#{name} W/COUPON"][:count] += 1
      else
        cart["#{name} W/COUPON"] = {:price => coupon[:cost], :count => 1}
        cart["#{name} W/COUPON"][:clearance] = cart["#{name}"][:clearance]
      end
      cart["#{name}"][:count] -= coupon[:num]
    end
  end
  cart
end

def apply_clearance(cart)
  cart.each do |key, value|
    if value[:clearance]
      clearance_price = value[:price] * 0.80
      value[:price] = clearance_price.round(2)
    end
  end
  cart
end

def checkout(cart, coupons)
  consolidated_cart = consolidate_cart(cart)
  applied_coupons = apply_coupons(consolidated_cart, coupons)
  applied_clearance = apply_clearance(applied_coupons)

  total = 0
  applied_clearance.each do |key, value|
    total += value[:price] * value[:count]
  end

  if total > 100
    total *= 0.9
  end
  total
end
