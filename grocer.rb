require 'pry'




def consolidate_cart(cart)
  # code here
  groceries_hash = {}

  cart.each do |produce|
  	produce.each do |category, values|
  		if groceries_hash.include?(category)
  			groceries_hash[category][:count] += 1
  		else
  			groceries_hash[category] = {}
  			values.each do |key, value|
  				groceries_hash[category][key] = value
  				groceries_hash[category][:count] = 1
  			end
  		end
  	end
  end
  groceries_hash
end

# cart = {
#   "AVOCADO" => {:price => 3.0, :clearance => true, :count => 3},
#   "KALE"    => {:price => 3.0, :clearance => false, :count => 1}
# }

# coupons = {:item => "AVOCADO", :num => 2, :cost => 5.0}

def apply_coupons(cart, coupons) #(hash, hash)
 	coupons.each do |coupon|

 	name = coupon[:item]

 	if cart[name] && cart[name][:count] >= coupon[:num] # If the coupon matches the item_in_cart
 		if cart["#{name} W/COUPON"]
 			cart ["#{name} W/COUPON"][:count] += 1
 		else
 			cart["#{name} W/COUPON"] = {:count => 1, :price => coupon[:cost]}
 			cart["#{name} W/COUPON"][:clearance] = cart[name][:clearance]
 		end
 		cart[name][:count] -= coupon[:num]
 		# binding.pry
 	end
 end
 cart
end



def apply_clearance(cart)
  # code here
  cart.each do |item_in_cart|
  	if item_in_cart[1][:clearance] == true
  		item_in_cart[1][:price] = item_in_cart[1][:price] - (item_in_cart[1][:price] * 0.2)
  	end
  end
  cart
end

def checkout(cart, coupons)
 consolidated_cart = consolidate_cart(cart)
 applied_coupons = apply_coupons(consolidated_cart, coupons)
 final_cart = apply_clearance(applied_coupons)
 final_cost = 0

 final_cart.each do |name, attributes|
 	final_cost += attributes[:price] * attributes[:count]
 end
 	if final_cost > 100
 		final_cost = final_cost * 0.9

 	end
 final_cost
end


