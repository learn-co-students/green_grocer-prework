require 'pry'

def consolidate_cart(cart)
  consolidatedCart = Hash.new 
  cart.each do |item|
  	item.each do |name, info|
  	  if consolidatedCart.key?(name) 
  	  	consolidatedCart[name][:count] += 1 
      else
  	  	consolidatedCart[name] = info 
  	  	consolidatedCart[name][:count] = 1 
  	  end 
  	end 
  end 
  consolidatedCart
end

def apply_coupons(cart, coupons)
  couponItems = Hash.new 
  coupons.each do |coupon|
	  cart.each do |item, info| 
	  	if coupon[:item] == item && coupon[:num] <= info[:count] 
	  		newItem = "#{item} W/COUPON"

	  		if couponItems.key?(newItem)
		  		couponItems[newItem][:count] += 1
		  	else 
		  		couponItems[newItem] = {
		  			price: coupon[:cost],
		  			clearance: info[:clearance],
		  			count: 1
		  		}
		  	end 

	  		cart[item][:count] -= coupon[:num]
	  	end
	  end
	end 

	couponItems.each do |item, info|  
	  cart[item] = info 
	end 
	cart 
end

def apply_clearance(cart)
  cart.each do |item, info|
    info[:price] = (info[:price] * 0.80).round(2) if info[:clearance] == true 
  end  
end

def checkout(cart, coupons)
  consolidatedCart = consolidate_cart(cart)
  couponCart = apply_coupons(consolidatedCart, coupons) 
  finalCart = apply_clearance(couponCart)
  total = 0.00
  finalCart.each do |item, info|
    total += info[:price] * info[:count]
  end 
  total > 100.00 ? (total * 0.90).round(2) : total 
end
