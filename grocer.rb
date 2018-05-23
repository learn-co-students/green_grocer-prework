require 'pry'

def consolidate_cart(cart)
  consolidated = {}
  cart.each do |thing|
    thing.each do |item, detail|
      if consolidated[item] == nil
        consolidated[item] = detail
        consolidated[item].merge!(:count => 1)
      else  
         consolidated[item][:count] += 1
          
      end
    end 
  end 
  consolidated
end

def apply_coupons(cart, coupons)
  applicable = {}
  coupons.each do |coupon|
    item = coupon[:item]
    if applicable[item].nil?
      applicable[item] = 1
    else 
      applicable[item] += 1
    end 

      if cart.keys.include?(item)
        if cart[item][:count] >= coupon[:num]
         cart[item][:count] -= coupon[:num]
           cart["#{item} W/COUPON"] = {:price => coupon[:cost],   :clearance => cart[item][:clearance], :count => applicable[item]}
  end    
    end
      end
    cart    
end

def apply_clearance(cart)
  cart.each do |item, detail|
    if cart[item][:clearance] == true
      cart[item][:price] -= cart[item][:price]* 0.2
    end 
  end  
  cart  
end

def checkout(cart, coupons)
  finished_cart = consolidate_cart(cart)
  apply_coupons(finished_cart, coupons)
  apply_clearance(finished_cart)
  
  total = 0
  finished_cart.each do |item, detail|
    total += finished_cart[item][:price] * finished_cart[item][:count]
      if total > 100
        total-= total * 0.1
      end 
  end    
  total  
end
