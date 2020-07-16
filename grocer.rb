require 'pry'

def count_item(cart, item)
    cart.select do |value|
        value.keys.first == item
    end.size
end

def consolidate_cart(cart)
  # code here
  new_cart = {}
  cart.each do |item|
      item.each do |key, value|
          new_cart[key] = {
              price: value[:price],
              clearance: value[:clearance],
              count: count_item(cart, key)
          }
      end
  end
  new_cart
end

def apply_coupons(cart, coupons)
  # code here
  coupons.each do |coupon|
      if cart[coupon[:item]] && cart[coupon[:item]][:count] >= coupon[:num]
          if cart[coupon[:item]+" W/COUPON"]
              cart[coupon[:item]+" W/COUPON"][:count] += 1
          else
              cart[coupon[:item]+" W/COUPON"] = {
                  price: coupon[:cost],
                  clearance: cart[coupon[:item]][:clearance],
                  count: 1
              }
          end
          cart[coupon[:item]][:count] = cart[coupon[:item]][:count]  - coupon[:num]
    end
  end
  cart
end

def apply_clearance(cart)
  # code here
  cart.each do |key, value|
      if value[:clearance]
          value[:price] = (value[:price] * 0.8).round(2)
      end
  end
end

def calculate_total(cart)
    cart.collect do |key, value|
        value[:price] * value[:count]
    end.sum
end

def checkout(cart, coupons)
  # code here
  final_cart = {}

  cart = consolidate_cart(cart)

  cart = apply_coupons(cart, coupons)

  cart = apply_clearance(cart)

  total = 0

  cart.each do |vegetable_str, veg_hash|
    total = total + (cart[vegetable_str][:price] * cart[vegetable_str][:count])
  end

  if total > 100
    total = (total * 0.9).round(2)
  end

  return total
end
