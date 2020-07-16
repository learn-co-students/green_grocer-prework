require 'pry'

def consolidate_cart(cart)
  return_hash = {}
  cart.each do |item|
    item.each do |food, food_hash|
      if return_hash.has_key?(food)
        return_hash[food][:count] += 1
      else
        return_hash[food] = food_hash.merge!(:count => 1) # merge! rules
      end
    end
  end
  return_hash
end

def apply_coupons(cart, coupons)
  coupons.each do |coupon| # ary
    coupon.each do |k, v| # first val (of :item) will match with 'cart' keys
      if cart.has_key?(v) && coupon[:num] <= cart[v][:count]
        if cart.has_key?(v + " W/COUPON")
          cart[v + " W/COUPON"][:count] += 1
        else
          cart[v + " W/COUPON"] = {:price => coupon[:cost], :clearance => cart[v][:clearance], :count => 1}
        end
        cart[v][:count] = cart[v][:count] - coupon[:num]
      end
    end
  end
  cart
end

def apply_clearance(cart)
  cart.each do |k, v| # hash, per previous method
    if cart[k][:clearance] == true
      cart[k][:price] = (cart[k][:price] * 0.8).round(1)
    end
  end
end

def checkout(cart, coupons)
  final = 0
  x = consolidate_cart(cart)
  x = apply_coupons(x, coupons)
  x = apply_clearance(x)
  x.each do |k, v|
    final += v[:price] * v[:count]
  end
  if final > 100
    final = (final * 0.9).round(1)
  end
  final # finally!!
end
