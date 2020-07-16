require 'pry'

def consolidate_cart(cart)
  	consolidated_hash = {}
  	count_arr = []
  	cart.each do |item|
  		item.each do |key, hash|
  			count_arr << key
  			if consolidated_hash[key] == nil
  				consolidated_hash[key] = hash
			else
				next
			end
		end
	end
	consolidated_hash.each do |cibo, data|
		data[:count] = count_arr.count(cibo)
	end
	consolidated_hash
end

def apply_coupons(cart, coupons)
	coupon_hash = {}
	if coupons.size != 0
		coupons.each do |discount|
			cart.each do |food, data|
				if discount[:item] == food
					c = 0
					if data[:count] >= discount[:num]
						c += data[:count] / discount[:num].floor
						coupon_hash["#{food} W/COUPON"] = {:price => discount[:cost], :clearance => data[:clearance], :count => c}
						coupon_hash[food] = {:price => data[:price], :clearance => data[:clearance], :count => data[:count] - c * discount[:num]}
						cart.delete(food)
					elsif data[:count] < discount[:num]
						coupon_hash[food] = data
					end
				else
					coupon_hash[food] = data
				end
			end
		end
	else
		coupon_hash = cart
	end
	coupon_hash
end

def apply_clearance(cart)
	cart.each do |food, food_data|
		if food_data[:clearance] == true
			food_data[:price] = (food_data[:price] * 0.8).round(1)
		end
	end
end

def checkout(cart, coupons)
	total = 0
	cart = consolidate_cart(cart)
	cart = apply_coupons(cart, coupons)
	apply_clearance(cart)
	cart.each do |food, food_data|
		total += (food_data[:price] * food_data[:count]).round(2)
	end
	if total > 100
		total = total * 0.9
	end
	total
end
