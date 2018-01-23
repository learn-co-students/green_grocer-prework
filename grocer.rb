require 'pry'

def consolidate_cart(cart)
  consolidated = {}
	item_names = []
	cart.each do |item|
		item_names << item.keys
		item.each do |key, value|
		  consolidated[key] = value
		end
	end
	flattened = item_names.flatten!
	consolidated.each do |hash, value|

	  value[:count] =  item_names.count(hash)
	end
end

def apply_coupons(cart, coupons)

  coupons.each do |coupon|
    if cart.keys.include?(coupon[:item]) && cart[coupon[:item]][:count] >= coupon[:num]
      coupon_name = coupon[:item] + " W/COUPON"
      if cart.keys.include?(coupon_name)

        cart[coupon[:item]][:count] -= coupon[:num]
        cart[coupon_name][:count] += 1

      else
      cart[coupon_name] = {}
      cart[coupon_name][:price] = coupon[:cost]
      cart[coupon_name][:clearance] = cart[coupon[:item]][:clearance]
      cart[coupon_name][:count] = 1
      cart[coupon[:item]][:count] = cart[coupon[:item]][:count] - coupon[:num]
      end
    end
  end

    cart
end

def apply_clearance(cart)
  cart.each do |item, data|

    if data[:clearance]
      data[:price] = data[:price] - data[:price]* ".20".to_f

    else
      cart
    end
  end
end

def checkout(cart, coupons)

  total = 0
if cart.length == 1
  new_cart = apply_clearance(apply_coupons(consolidate_cart(cart), coupons))

new_cart.each do |item, value|
  return value[:price]
end
else

  cart = consolidate_cart(cart)

  cart = apply_coupons(cart, coupons)
  cart = apply_clearance(cart)

  cart.each do |item, value|

    total += value[:price]*value[:count]
  end

end
  if total > 100
    total -= total*".10".to_f
  else
    return total
  end
end
