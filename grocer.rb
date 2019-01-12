require 'pry'

def consolidate_cart(cart)
  cart_hash = {}
  cart.each do |array|
    array.each do |item, item_hash|
        if cart_hash[item] == nil
          cart_hash[item] = item_hash.merge(:count => 1)
        else
          cart_hash[item][:count] += 1
        end
    end
  end
  cart_hash
end

def apply_coupons(cart, coupons)
  coupons.each do |coupon|
  name = coupon[:item]
    if cart[name] && cart[name][:count] >= coupon[:num]
      if cart["#{name} W/COUPON"]
        cart["#{name} W/COUPON"][:count] += 1
      else
        cart["#{name} W/COUPON"] = {:count => 1, :price => coupon[:cost], :clearance => cart[name][:clearance]}
      end
      cart[name][:count] -= coupon[:num]
    else
      cart
    end
  end
cart
end

def apply_clearance(cart)
    cart.each do |item, item_hash|
      if item_hash[:clearance]
        new_price = (item_hash[:price] * 0.80)
        item_hash[:price] = new_price.round(2)
      end
    end
cart
end

def checkout(cart, coupons)
cart_total = 0
consolidated_cart = consolidate_cart(cart)
cart_after_coupon = apply_coupons(consolidated_cart, coupons)
final_cart = apply_clearance(cart_after_coupon)

  final_cart.each do |item, item_hash|
    cart_total += item_hash[:price] * item_hash[:count]
  end

  if cart_total > 100
    cart_total = (cart_total * 0.90)
  end

  cart_total
end
