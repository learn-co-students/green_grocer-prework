require 'pry'
def consolidate_cart(cart)
  # code here
  new_hash = {}
  cart.each do |element|
    element.each do |key, value|
      # binding.pry
      if new_hash.keys.include?(key)
        new_hash[key][:count] = new_hash[key][:count]+1

      else
        new_hash[key] = value
        new_hash[key][:count] = 1
      end
    end
  end
  new_hash
  # binding.pry
  end



def apply_coupons(cart, coupons)
  # code here
  new_hash ={}
  cart.each do |key, value|
    new_hash[key] = value
    coupons.each do |coupon|
    if key == coupon[:item] && value[:count] >= coupon[:num]
      new_hash[key][:count] = new_hash[key][:count] -= coupon[:num]
      if new_hash["#{key} W/COUPON"]
        new_hash["#{key} W/COUPON"][:count] +=1
      else
      new_hash["#{key} W/COUPON"] = {:price => coupon[:cost], :count => 1}
      new_hash["#{key} W/COUPON"][:clearance] = new_hash[key][:clearance]
      # binding.pry
    end
    end
    end
end
new_hash
end



def apply_clearance(cart)
  # code here
  new_hash ={}
  cart.each do |item, data|
    if data[:clearance] == true
      new = data[:price]*0.80
      data[:price] = new.round(2)
    end
  end
    cart
end



def checkout(cart, coupons)
  # code here
  consolidated_cart = consolidate_cart(cart)
  coupon_apply_cart = apply_coupons(consolidated_cart, coupons)
  last_cart = apply_clearance(coupon_apply_cart)
  total = 0
  # binding.pry
      last_cart.each do |name, properties|
            total += properties[:price] * properties[:count]
  end
  if total >100
    total = total * 0.90
  end
  total
end
