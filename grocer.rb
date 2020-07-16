require 'pry'
def consolidate_cart(cart)
  count = Hash.new(0)
  new_cart = {}
  cart.each do |item|
    count[item.keys[0]] += 1
  end
  cart.each do |item|
    new_cart[item.keys[0]] = item.values[0]
    new_cart[item.keys[0]][:count] = count[item.keys[0]]
  end
  new_cart
end

def apply_coupons(cart, coupons)
  coupons.each do |coupon|
    discount = coupon[:item]
    if cart[discount] != nil && cart[discount][:count] >= coupon[:num]
      coupon_item = {"#{discount} W/COUPON" => {
        :price => coupon[:cost],
        :clearance => cart[discount][:clearance],
        :count => 1
      }
    }
    if cart["#{discount} W/COUPON"].nil?
      cart.merge!(coupon_item)
    else
      cart["#{discount} W/COUPON"][:count] += 1
    end
    cart[discount][:count] -= coupon[:num]
  end
end
cart
end

def apply_clearance(cart)
  cart.each do |key, value|
    if value[:clearance] == true
      new_price = value[:price].to_f * 0.8
      value[:price] = new_price.round(3)
    end
  end
  cart
end

def checkout(cart, coupons)
  checkout_cart = consolidate_cart(cart)
  coupons_cart = apply_coupons(checkout_cart, coupons)
  clearance_cart = apply_clearance(checkout_cart)
  total = 0
  clearance_cart.each do |key, value|
    total += value[:price] * value[:count]
  end
  if total >= 100
    total = total * 0.9
  else
    total
  end
end
