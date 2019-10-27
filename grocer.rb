require 'pry'
def consolidate_cart(cart)
  list_with_count = {}
  item_count = 0
  cart.each do |items|
  	items.each do |names, info|

if list_with_count[names]  == nil
	list_with_count[names] = info.merge({:count => 1})
else
	list_with_count[names][:count] += 1
end
end
end
list_with_count
 # code here 
end

def apply_coupons(cart, coupons)
 new_cart = {}
cart.each do |name_of_food, info|
	#binding.pry
 coupons.each do |each_coupon|
 	#binding.pry
 	if name_of_food == each_coupon[:item] && info[:count] >= each_coupon[:num] 		
 		info[:count] = info[:count] - each_coupon[:num]
 	
 	#binding.pry

 		if new_cart["#{name_of_food} W/COUPON"]
 		new_cart["#{name_of_food} W/COUPON"][:count] += 1
 #binding.pry
 	else
 		#return puts "Not enough quantity to apply a coupon"
new_cart["#{name_of_food} W/COUPON"] = {:price => each_coupon[:cost],
										:clearance => info[:clearance], 
									    :count =>1}
									   #binding.pry


#binding.pry

 	end

 end

end
  new_cart[name_of_food] =info
  # code here
end
new_cart
end
def apply_clearance(cart)
 discounted_items = {}
cart.each do |name_of_food, info|
 #binding.pry
 discounted_items[name_of_food] = {}
#binding.pry
if info[:clearance] == true
	#binding.pry
	discounted_items[name_of_food][:price] = (info[:price] * 0.8).round(1)
else
discounted_items[name_of_food][:price] = info[:price]
#binding.pry
end


discounted_items[name_of_food][:clearance] = info[:clearance]
discounted_items[name_of_food][:count] = info[:count]
#binding.pry

#binding.pry
end
 discounted_items
 # code here
end

def checkout(cart, coupons)
  final_total = 0



items_without_discount = consolidate_cart(cart)
items_with_coupons_applied = apply_coupons(items_without_discount, coupons)
items_finalized = apply_clearance(items_with_coupons_applied)
#binding.pry
receipt_total = 0
 
items_finalized.each do |name_of_food, info|
#binding.pry

	receipt_total += info[:count] * info[:price]
#binding.pry
end
if receipt_total < 100
	return receipt_total
else return final_total = receipt_total * 0.9
end
#binding.pry


end





