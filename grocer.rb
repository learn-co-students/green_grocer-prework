require "pry"

def consolidate_cart(cart)
  # code here
  new_hash = {}

  cart.each do |item|
    item.each do |item_name, details|
      # new_hash.key?(item_name) ? new_hash[item_name][:count] += 1 : new_hash[item_name] = (details[:count] = 1)
      if new_hash.key?(item_name)
        new_hash[item_name][:count] += 1
      else
        new_hash[item_name] = details
        new_hash[item_name][:count] = 1
      end
    end
  end

  new_hash
end

def apply_coupons(cart, coupons)
  # code here
  # cart.each do |item, details|
  #   new_hash[item] = {}
  #   details.each do |key, value|
  #     new_hash[item][key] = value
  #   end
  # end
  #
  # coupons.each do |coupon|
  #   item_name = coupon[:item]
  # binding.pry
  coupons.each do |coupon|
    item_name = coupon[:item]
    # instantiate the item with coupon
    if cart.key?(item_name) && cart[item_name][:count] >= coupon[:num]
      coupon_name = "#{item_name} W/COUPON"
      if cart.key?(coupon_name)
        cart[coupon_name][:count] += 1
      # cart[item_name].each do |key, value|
      else
        cart[coupon_name] = {}
        cart[coupon_name][:price] = coupon[:cost]
        cart[coupon_name][:clearance] = cart[item_name][:clearance]
        cart[coupon_name][:count] = 1
      end
      cart[item_name][:count] -= coupon[:num]
    end
  end

  cart
end

def apply_clearance(cart)
  # code here
  cart.each do |item, details|
    if details[:clearance] == true
      details[:price] = (details[:price] * 0.8).round(1)
    end
  end

  cart
end

def checkout(cart, coupons)
  # code here
  cart = consolidate_cart(cart)
  apply_coupons(cart, coupons)
  apply_clearance(cart)
  total_cost = 0

  cart.each do |item, detail|
    detail[:count].times do
      total_cost += detail[:price]
    end
  end

  if total_cost > 100
    total_cost = total_cost * 0.9
  end

  total_cost
end
