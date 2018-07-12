require "pry"

def consolidate_cart(cart)
  cart_hash = {}
  if cart == cart.uniq   
    cart.each do |item_hash|
      item_hash.values[0][:count] = 1
    end
  else
    count_hash = Hash.new(0)
    cart.each do |item_hash|
      count_hash[item_hash.keys[0]] += 1
    end
    cart.each do |item|
      count_hash.each do |count_item, count|
        if item.keys[0] == count_item
          item.values[0][:count] = count
        end
      end
    end
  end
  cart.uniq.each do |x|
    cart_hash[x.keys[0]] = x.values[0]
  end
  cart = cart_hash
  cart
end

def apply_coupons(cart, coupons)
  left_over = 0
  coupon_count = 0
  coup_array = []
  item_var = ""
  
  coupons.each do |coupon_hash|
    item_var = coupon_hash[:item]
    if cart[item_var] && cart[item_var][:count] >= coupon_hash[:num]
      item_w_coup = "#{item_var} W/COUPON"
      if cart[item_w_coup] 
        cart[item_w_coup][:count] += 1
      else
        cart[item_w_coup] = {
          :price => coupon_hash[:cost],
          :clearance => cart[item_var][:clearance],
          :count => 1
        }        
      end
      cart[item_var][:count] -= coupon_hash[:num]  
    end    
  end
  cart
end

def apply_clearance(cart)
  cart.each do |item|
    if item[1][:clearance] == true
      item[1][:price] = item[1][:price]*0.8
      item[1][:price] = item[1][:price].round(2)
    end
  end
  cart
end

def checkout(cart, coupons)
  #binding.pry
  consolidated_cart = consolidate_cart(cart)
  couponed_cart = apply_coupons(consolidated_cart, coupons)
  final_cart = apply_clearance(couponed_cart)
  total = 0
  final_cart.each do |key, values|
    total += values[:price]*values[:count]
  end
  if total > 100
    total = total*0.9
  end
  total
end

