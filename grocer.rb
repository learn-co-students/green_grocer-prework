require 'pry'

cart = {
  "AVOCADO" => {:price => 3.0, :clearance => true, :count => 3},
  "KALE"    => {:price => 3.0, :clearance => false, :count => 1}
}

coupons = {:item => "AVOCADO", :num => 2, :cost => 5.0}

def list_items(cart)
	cart.map do |item|
		item.keys
	end.flatten.uniq
end

def get_item_values(item, cart)
	x = cart.find do |item_hash|
		item_hash.key?(item)
	end
	x[item]
end

def get_item_count(item, cart)
	count = 0
	cart.each do |item_hash|
		if item_hash.key?(item)
			count += 1
		end
	end
	count
end

def consolidate_cart(cart)
  # code here
  # 1. List items out
  # 2. Get values of items
  # 3. Get item count
  # 4. Add all into one hash
  	new_cart = {}
	list_items(cart).each do |item|
		new_cart[item] = get_item_values(item, cart)
		new_cart[item][:count] = get_item_count(item, cart)
	end
new_cart
end

def coupon_valid?(cart, coupons)
	cart.key?(coupons[:item]) && (coupons[:num] <= cart[coupons[:item]][:count])
end

def add_couponed_item(cart, coupons)
	coupon_key = coupons[:item] + " W/COUPON"

	if cart.key?(coupon_key)
		cart[coupon_key][:count] += 1
	else
		cart[coupon_key] = {}
		cart[coupon_key][:price] = coupons[:cost]
		cart[coupon_key][:clearance] = cart[coupons[:item]][:clearance]
		cart[coupon_key][:count] = 1
	end
	cart
end

def subtract_count(cart, coupons)
	cart[coupons[:item]][:count] -= coupons[:num]
	cart
end

def apply_coupons(cart, coupons)
	# check if enough of couponed item exists
	# add couponed item to cart
	# subtract from original item get_item_count
	# return new cart
	coupons.each do |coupon|
		if coupon_valid?(cart, coupon)
			cart = add_couponed_item(cart, coupon)
			cart = subtract_count(cart, coupon)
		end
	end
	cart
end

def reduce_price(item_values)
	item_values[:price] = (item_values[:price] * 0.8).round(2)
end

def apply_clearance(cart)
  # check if the item is clearanced
  # if it is multiply the price by 0.8
  # return updated cart
  cart.each do |item_name, item_values|
	  if item_values[:clearance]
		  reduce_price(item_values)
	  end
	end
	cart
end

def total_price(cart)
	price = 0
	cart.each do |item_name, item_values|
		price += (item_values[:price] * item_values[:count])
	end
	if price > 100
		price = (price * 0.9).round(2)
	end
	price
end

def checkout(cart, coupons)
	# consolidate cart
  # apply coupon discounts
  #apply clearance discounts
	cart = consolidate_cart(cart)
	cart = apply_coupons(cart, coupons)
	cart = apply_clearance(cart)
	# add all clearance_prices
	#10% if over 100
	total_price(cart)
end
