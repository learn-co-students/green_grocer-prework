def consolidate_cart(cart)
	new_cart = {}
	cart.each do |item|
		item.each do |key, value|
			if new_cart.keys.include?(key) == false
				new_cart[key] = value
				new_cart[key][:count] = 1
			else
				new_cart[key][:count] += 1
			end
		end
	end
	new_cart
end

def apply_coupons(cart, coupons)
	coupons.each do |coupon|
		cart.keys.each do |food|
			if coupon[:item] == food && coupon[:num] <= cart[food][:count]
				cart["#{food} W/COUPON"] = {:price => coupon[:cost], :clearance => cart[food][:clearance], :count => cart[food][:count]/coupon[:num]}
				cart[food][:count] = cart[food][:count] % coupon[:num]
			end
		end
	end
	cart
end

def apply_clearance(cart)
	cart.each do |key, val_hash|
		if val_hash[:clearance] == true
			val_hash[:price] -= val_hash[:price] * 0.2
		end
	end
	cart
end

def checkout(cart, coupons)
	total = 0
	final_cart = apply_clearance(apply_coupons(consolidate_cart(cart),coupons))
	final_cart.each do |item, item_hash|
		total += item_hash[:price] * item_hash[:count]
	end
	if total > 100
		total *= 0.9
	end
	total
end

#apply_coupons(grocer,coupons1)