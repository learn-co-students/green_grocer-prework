require 'pry'

def consolidate_cart(cart)
  organized_cart = {}

  cart.each do |item_hash|
    item_hash.each do |item, info|
      if organized_cart[item].nil?
        organized_cart[item] = info
        organized_cart[item][:count] = 1
      else
        organized_cart[item][:count] += 1
      end
    end
  end

  organized_cart
end

def apply_coupons(cart, coupons)
  cart_with_coupons = {}

  cart.each do |item, info|
    cart_with_coupons[item] = info
    coupons.each do |coupon|
      if item == coupon[:item] && info[:count] >= coupon[:num]
        cart_with_coupons["#{item} W/COUPON"] = {
          :price => coupon[:cost],
          :clearance => cart[item][:clearance],
          :count => cart_with_coupons[item][:count] / coupon[:num]
        }
        cart_with_coupons[item][:count] =  cart_with_coupons[item][:count] % coupon[:num]
      end
    end
  end

  cart_with_coupons
end

def apply_clearance(cart)
  cart.each do |item, info|
    if info[:clearance] == true
      info[:price] = (info[:price]*0.8).round(2)
    end
  end
end

def checkout(cart, coupons)
  cart = consolidate_cart(cart)

  cart = apply_coupons(cart, coupons)

  cart = apply_clearance(cart)

  total_cost = 0
  cart.each do |item_hash|
    total_cost += item_hash[1][:price] * item_hash[1][:count]
  end

  if total_cost > 100
    total_cost = (total_cost*0.9).round(2)
  end

  total_cost
end
