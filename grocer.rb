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

  couponed_cart = cart

  #go through each coupon: 1. Check if it's there & meets min. 2. Add couponed item. 3. Update item.
  coupons.each do |coupon|
     #If there, update cart item
     coupon_item = coupon[:item]
     if couponed_cart.keys.include?(coupon_item) && coupon[:num] <= couponed_cart[coupon_item][:count]
       #add couponed item and update item to new cart
       count = (couponed_cart[coupon_item][:count]/coupon[:num]).floor
       price = coupon[:cost]
       clearance = cart[coupon_item][:clearance]
       couponed_cart["#{coupon_item} W/COUPON"] = {:price=> price, :clearance=> clearance, :count=> count}
       couponed_cart[coupon_item][:count] = (couponed_cart[coupon_item][:count] % coupon[:num])
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

  consolidated = consolidate_cart(cart)
  couponed = apply_coupons(consolidated,coupons)
  couponed_clearance = apply_clearance(couponed)

  total_cost = 0

  couponed_clearance.each do |k,v|
    total_item_cost = v[:price] * v[:count]
    total_cost += total_item_cost
  end

  if total_cost > 100
    float_total = total_cost * 0.9
    return float_total.round(2)
  else
    return total_cost.round(2)
  end
end
