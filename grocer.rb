require "pry"

def consolidate_cart(cart)
  result = {}
  cart.each do |item|
  	item_name = item.keys[0]
  	if result.include? item_name
  		result[item_name][:count] += 1
  	else
  		result[item_name] = item[item_name]
  		result[item_name][:count] = 1
  	end
  end
  result
end


def apply_coupons(cart, coupons)
  coupons.each do |coupon|
	  if cart.include? coupon[:item]
	  	coupon_for = coupon[:item]
	  	if cart[coupon_for][:count] >= coupon[:num]
			  cart[coupon_for][:count] -= coupon[:num]
			  if cart.has_key? "#{coupon_for} W/COUPON"
			  	cart["#{coupon_for} W/COUPON"][:count] += 1
			  else
				 	cart["#{coupon_for} W/COUPON"] = {
				 		:price => coupon[:cost],
				 		:clearance => cart[coupon_for][:clearance],
			 			:count => 1
			 		}
		 		end  	
		 	end
		end
	end
  cart
end


def apply_clearance(cart)
  cart.each do |item, info|
  	if info[:clearance]
  		info[:price] = (info[:price] *= 0.8).round(2)
  	end
	end
	cart
end


def checkout(cart, coupons)
	consolidated_cart = consolidate_cart(cart)
	cart_with_coupons = apply_coupons(consolidated_cart, coupons)
	final_cart = apply_clearance(consolidated_cart)
  total = 0
  final_cart.each do |item, info|
  	total += info[:price] * info[:count]
  end
  if total > 100
  	total *= 0.9
  end
  total
end

