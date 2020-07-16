require "pry"

def consolidate_cart(cart)
  # code here
  total_cart = {}
  cart.each do |item|
    item.each do |name, info|
    if total_cart.keys.include?(name) == false
      total_cart[name] = info.merge!(:count => 1)
    else
      total_cart[name][:count] += 1
  end
end
end
  total_cart
end


def apply_coupons(cart, coupons)
  # code here
  coupons.each do |group|
    cart.keys.each do |item|
      if group[:item] == item && group[:num] <= cart[item][:count]
        cart["#{item} W/COUPON"] = {
          price: group[:cost],
          clearance: cart[item][:clearance],
          count: cart[item][:count] / group[:num]
        }
        cart[item][:count] = cart[item][:count] %  group[:num]
      end
    end
  end
  cart
end

def apply_clearance(cart)
  # code here
  cart.keys.each do |item|
      if cart[item][:clearance] == true
        cart[item][:price] = (cart[item][:price] * 0.8).round(1)
      end
  end
  cart
end

def checkout(cart, coupons)
  # code here
  cart = consolidate_cart(cart)
  cart = apply_coupons(cart, coupons)
  cart = apply_clearance(cart)
  total_cost = 0
  cart.keys.each do |item|
    total_cost += cart[item][:price] * cart[item][:count]
  end
  if total_cost > 100
    total_cost = (total_cost * 0.9).round(1)
  end
  total_cost
end
