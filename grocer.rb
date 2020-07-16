require "pry"
require "pp"

def consolidate_cart(cart)
  # code here
  new_cart = {}

  cart.each do |item|
    if new_cart.keys.include?(item.keys[0])
      new_cart[item.keys[0]][:count] += 1
    else
      new_cart[item.keys[0]] = item.values[0]
      new_cart[item.keys[0]][:count] = 1
    end
  end

  new_cart
end

def apply_coupons(cart, coupons_array)
  # code here
  #checks if coupon applies
  coupons_array.each do |coupon|
    if cart.keys.include?(coupon[:item])
      #checks cart meets coupon's min amount
      if cart[coupon[:item]][:count] >= coupon[:num]
        cart[coupon[:item]][:count] -= coupon[:num]

        #add/updates the coupon items to cart
        w_coupon_name = coupon[:item] + " W/COUPON"
        if cart.keys.include?(w_coupon_name)
          cart[w_coupon_name][:count] += 1
        else
          cart[w_coupon_name] = cart[coupon[:item]].clone
          cart[w_coupon_name][:price] = coupon[:cost]
          cart[w_coupon_name][:count] = 1
        end
      end
    end
  end

  cart
end

def apply_clearance(cart)
  cart.each do |item_key, item_values|
    if item_values[:clearance] == true
      item_values[:price] = (item_values[:price] * 0.8).round(1)
    end
  end
end

def checkout(cart, coupons)
  total = 0

  consolidated_cart = consolidate_cart(cart)
  consolidated_cart_w_coupons = apply_coupons(consolidated_cart, coupons)
  discounted_consolidated_cart_w_coupons = apply_clearance(consolidated_cart_w_coupons)

  discounted_consolidated_cart_w_coupons.each do |item_key, item_values|
    total += item_values[:price] * item_values[:count]
  end

  total > 100 ? 0.9 * total : total
end

cart = [
  {"TEMPEH" => {:price => 3.00, :clearance => true}},
  ]

coupon = {:item => "AVOCADO", :num => 2, :cost => 5.0}

# result =apply_clearance(consolidate_cart(cart))
# pp result
# pp result["TEMPEH"][:price]
