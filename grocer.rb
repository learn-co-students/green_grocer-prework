require "pry"

def consolidate_cart(cart)
  cart.each_with_object({}) do |item, result|
    item.each do |x, y|
      if result[x]
        y[:count] += 1
      else
        y[:count] = 1
        result[x] = y
      end
    end
  end
end

def apply_coupons(cart, coupons)
  coupons.each do |coupon|
   if cart.has_key?(coupon[:item]) && cart[coupon[:item]][:count] >= coupon[:num]
     coupon_item = coupon[:item] + " W/COUPON"
   if cart.has_key?(coupon_item)
     cart[coupon_item][:count] += 1
   else
     cart[coupon_item] = {price: coupon[:cost],
       clearance: cart[coupon[:item]][:clearance],
       count: 1}
   end
   cart[coupon[:item]][:count] -= coupon[:num]
   end
 end
 cart
end

def apply_clearance(cart)
  cart.each do |x, y|
    if cart[x][:clearance]
      cart[x][:price] = cart[x][:price] - (cart[x][:price] * 0.2)
    end
  end
  cart
end

def checkout(cart, coupons)
  cart = consolidate_cart(cart)
  cart = apply_coupons(cart, coupons)
  cart = apply_clearance(cart)
  total = 0
  cart.each do |item, attributes|
      total += attributes[:price] * attributes[:count]
  end
  if total >= 100
      total = (total * 0.9).round(2)
  end
  total
end
