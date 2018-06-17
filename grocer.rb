require "pry-byebug"

def consolidate_cart(cart)
  result = {}
  cart.each do |item_element|
    item_element.each do |item, item_data|
      if result.include?(item)
        result[item][:count] += 1
      else
        result[item] = item_data
        result[item][:count] = 1
      end
    end
  end
  result
end

def apply_coupons(cart, coupons)
  coupons.each do |coupon|
    item_name = coupon[:item]
    if cart.include?(item_name) && cart[item_name][:count] >= coupon[:num]
      if cart["#{item_name} W/COUPON"]
        cart["#{item_name} W/COUPON"][:count] += 1
      else
        cart["#{item_name} W/COUPON"] = {count: 1, price: coupon[:cost], clearance: cart[item_name][:clearance]}
      end
      cart[item_name][:count] -= coupon[:num]
    end
  end
  cart
end

def apply_clearance(cart)
  cart.collect do |item, item_data|
    if item_data[:clearance] == true
      item_data[:price] -= (item_data[:price] * 0.20) 
    end
  end
  cart
end

def checkout(cart, coupons)
  consolidated_cart = consolidate_cart(cart)
  coupon_cart = apply_coupons(consolidated_cart, coupons)
  finished_cart = apply_clearance(coupon_cart)

  cart_total = 0
  finished_cart.each do |item, item_data|
    cart_total += item_data[:price] * item_data[:count]
  end
  if cart_total > 100
    cart_total -= (cart_total * 0.10)
  end
   cart_total
end
