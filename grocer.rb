require "pry"

def consolidate_cart(cart)
  count_hash = Hash.new(0)
  final_hash = Hash.new(0)

  #count duplicates: elements are keys & count is the value
  cart.each do |e|
    count_hash[e] += 1
  end

  #reformat the count_hash so keys are items and their info is in one hash value
  count_hash.each do |item_data, num|
    item_data.each do |item, data|
      data[:count] = num
      final_hash[item] = data
    end
  end
  final_hash
end

def apply_coupons(cart, coupons)
  #check if coupons exist
  if coupons.length == 0
    return cart
  end

  couponed_cart = Hash.new(0)

  #go through each coupon: 1. Check if it's there. 2. Update the cart item. 3. Add couponed item. 4. Add to couponed cart.
  coupons.each do |coupon|
    #If there, update cart item
    coupon_item = coupon[:item]
    if cart.keys.include?(coupon_item)
      cart[coupon_item][:count] -= coupon[:num]
      #add couponed item and updated item to new cart
      price = coupon[:cost]
      clearance = cart[coupon_item][:clearance]
      count = coupons.count(coupon)
      couponed_cart["#{coupon_item} W/COUPON"] = {:price=> price, :clearance=> clearance, :count=> count}
      couponed_cart[coupon_item] = cart[coupon_item]
    else
      couponed_cart = cart if couponed_cart == Hash.new(0)
    end
  end

  couponed_cart
end

def apply_clearance(cart)
  clearance_cart = cart
  cart.each do |k,v|
    if v[:clearance] == true
      float_price = v[:price] * 0.8
      clearance_cart[k][:price] = float_price.round(2)
    end
  end
  clearance_cart
end

def checkout(cart, coupons)
  # code here
end
