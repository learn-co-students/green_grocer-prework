require 'pry'

def consolidate_cart(cart)
  organised_items = Hash.new
  cart.each do |item|
    item.each do |name, attributes|
      if organised_items[name]
        organised_items[name][:count] += 1
      else
        organised_items[name] = attributes
        organised_items[name][:count] = 1
      end
    end
  end
  organised_items
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
  cart.each do |name, attributes|
    if attributes[:clearance]
      attributes[:price] = (attributes[:price] * 0.8).round(2)
    end
  end
  cart
end

def checkout(cart, coupons)
  total = 0
  consolidated_cart = consolidate_cart(cart)
  with_coupons = apply_coupons(consolidated_cart, coupons)
  final_cart = apply_clearance(with_coupons)
  final_cart.each do |name, properties|
    total += properties[:price] * properties [:count]
  end
  if total > 100
    total = total * 0.9
  end
  total
end

