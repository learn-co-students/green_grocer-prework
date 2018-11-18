def consolidate_cart(cart)
  cart.each_with_object({}) do |item, result|
    item.each do |type, attributes|
      if result[type]
        attributes[:count] += 1
      else
        attributes[:count] = 1
        result[type] = attributes
      end
    end
  end
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
  cart.each do |name, data|
    if data[:clearance] == true
    new_price = data[:price] * 0.80
    data[:price] = new_price.round(2)
  end
  end
  cart
end

def checkout(cart, coupons)
total_price = 0
consol = consolidate_cart(cart)
  coupon_cart = apply_coupons(consol, coupons)
  clearance_cart = apply_clearance(coupon_cart)
  clearance_cart.each do |item, data|
total_price += data[:price] * data[:count]
  end
  if total_price > 100
    return total_price * 0.9
  else
    return total_price
  end
end
