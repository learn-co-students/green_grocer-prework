def consolidate_cart(cart)
new_hash = {}
  cart.each{|item_value|
item_value.each{|item, qualities|
if new_hash[item] == nil
new_hash[item] = qualities
new_hash[item][:count] = 1
else
  new_hash[item][:count] += 1
end
}
  }
new_hash
end

def apply_coupons(cart, coupons)
coupons.each{|coupon_hash|
if cart[coupon_hash[:item]] != nil && cart[coupon_hash[:item]][:count] >= coupon_hash[:num]
cart[coupon_hash[:item]][:count] -= coupon_hash[:num]
  if cart[coupon_hash[:item] + " W/COUPON"] == nil
cart[coupon_hash[:item] + " W/COUPON"] = {:price => coupon_hash[:cost], :clearance => cart[coupon_hash[:item]][:clearance], :count => 1 }
else
cart[coupon_hash[:item] + " W/COUPON"][:count] += 1
  end
end
  }
#binding.pry
cart
end

def apply_clearance(cart)
  new_cart = {}
  cart.each{|item, qualities|
  new_cart[item] = qualities
if qualities[:clearance]
  new_cart[item][:price] -= qualities[:price] * 0.2
end
  }
#binding.pry
new_cart
end

def checkout(cart, coupons)
  result = 0
new_cart = consolidate_cart(cart)
newer_cart = apply_coupons(new_cart, coupons)
newerer_cart = apply_clearance(newer_cart)
newerer_cart.each{|item, qualities|
result += qualities[:price] * qualities[:count]
}
if result > 100
  result -= result * 0.1
end
result
end
