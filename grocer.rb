require "pry"

def consolidate_cart(cart)
  new_cart = cart.uniq
  result = {}
  new_cart.collect do |item_hash|
    item_quan = cart.count(item_hash)
    item_hash.collect do |item, details|
    result[item] = details
    result[item][:count] = item_quan
    # binding.pry
    end
  end
  result
  # binding.pry
end

def apply_coupons(cart, coupons)
  result = cart
  coupons.each do |coupon|
    item_name = coupon[:item]   # "AVOCADO"
    if cart.keys.include?(item_name) && cart[item_name][:count] >= coupon[:num]
      if result[item_name+" W/COUPON"].nil?
        result[item_name+" W/COUPON"] = {
          :price => (coupon[:cost] / coupon[:num]),
          :clearance => cart[item_name][:clearance],
          :count => coupon[:num]
        }
        result[item_name][:count] -= coupon[:num]
      else
        result[item_name+" W/COUPON"][:count] += coupon[:num]
        result[item_name][:count] -= coupon[:num]
      end 
    end 
  end 
  result
  # binding.pry
end

def apply_clearance(cart)
  # code here
  result = cart 
  cart.each do |item, details|
    if details[:clearance] == true
      result[item][:price] = (0.8 * result[item][:price]).round(2)
    end 
  end 
  result
end

def checkout(cart, coupons)
  new_cart = consolidate_cart(cart)
  couponed_cart = apply_coupons(new_cart, coupons)
  clearanced_cart = apply_clearance(couponed_cart)
  total = 0
  clearanced_cart.each do |item, details|
    item_total = (details[:price] * details[:count]).round(2)
    total += item_total
  end 
  total
  total > 100 ? (total*=0.9).round(2) : total
end
