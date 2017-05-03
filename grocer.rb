def consolidate_cart(cart)
  cart.each_with_object({}) do |items, new_hash|
    items.each do |item, info|
      if new_hash[item]
        info[:count] += 1
      else
        info[:count] = 1
        new_hash[item] = info
      end
    end
  end
end

def apply_coupons(cart, coupons)
  coupons.each do |each_coupon|
    coupon_item = each_coupon[:item]
    if cart[coupon_item] && cart[coupon_item][:count] >= each_coupon[:num]
      if cart["#{coupon_item} W/COUPON"]
        cart["#{coupon_item} W/COUPON"][:count] += 1
      else
        cart["#{coupon_item} W/COUPON"] = {:count => 1, :price => each_coupon[:cost]}
        cart["#{coupon_item} W/COUPON"][:clearance] = cart[coupon_item][:clearance]
      end
      cart[coupon_item][:count] -= each_coupon[:num]
    end
  end
  cart
end

def apply_clearance(cart)
  cart.each do |item, info|
    if info[:clearance]
      info[:price] = (info[:price] * 0.80).round(2)
    end
  end
  cart
end

def checkout(cart, coupons)
  new_cart = consolidate_cart(cart)
  cart_with_coupons = apply_coupons(new_cart, coupons)
  last_cart = apply_clearance(cart_with_coupons)
  total_cost = 0
  last_cart.each do |item, info|
    total_each_item = info[:price] * info[:count]
    total_cost += total_each_item
  end
  if total_cost > 100
    total_cost = total_cost * 0.90
  end
  total_cost
end
