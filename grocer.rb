def consolidate_cart(cart)
  new_hash = {}
  cart.each do |hash|
    hash.each do |food, data|
      new_hash[food] = data
      new_hash[food][:count] ||= 0
      if new_hash.has_key?(food)
        new_hash[food][:count] += 1
      end
    end
  end
  new_hash
end

def apply_coupons(cart, coupons)
  coupons.each do |coupon|
    name = coupon[:item]
    if cart[name] && cart[name][:count] >= coupon[:num]
      if cart["#{name} W/COUPON"]
        cart["#{name} W/COUPON"][:count] += 1
      else
        cart["#{name} W/COUPON"] = {:count => 1, :price => coupon[:cost]}
        cart["#{name} W/COUPON"][:clearance] = cart[name][:clearance]
      end
      cart[name][:count] -= coupon[:num]
    end
  end
  cart
end

def apply_clearance(cart)
  cart.each do |food, data|
    if data[:clearance] == true
      new_price = data[:price] * 0.80
      data[:price] = new_price.round(2)
    end
  end
  cart
end

def checkout(cart, coupons)
  cart_a = consolidate_cart(cart)
  cart_b = apply_coupons(cart_a, coupons)
  cart_c = apply_clearance(cart_b)

  total = 0

  cart_c.values.each do |data|
    total += (data[:price] * data[:count])
  end

  total > 100 ? (total * 0.90) : total
end
